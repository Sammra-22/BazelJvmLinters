_LINT_SCRIPT = """
{linter_tool} $@ 2>{output_path} > {output_path}
[[ -s {output_path} ]] && echo '[FAIL] Lint issues detected @ {label}'
exit 0
"""

FilesInfo = provider(
    fields = {
        "srcs": "Source files of this target",
    },
)

def _collect_src_files_impl(target, ctx):
    src_files = []
    if hasattr(ctx.rule.attr, "srcs"):
        for src in ctx.rule.attr.srcs:
            src_files += [f for f in src.files.to_list() if ctx.attr.extension in ["*", f.extension]]
    return FilesInfo(srcs = depset(src_files))

collect_src_files = aspect(
    implementation = _collect_src_files_impl,
    attrs = {
        "extension": attr.string(values = ["*", "java", "kt"]),
    },
)

def _code_style_lint_check_impl(ctx):
    source_files = _unbox_source_files(ctx, *ctx.attr.targets)
    source_files_list = source_files.to_list()

    input_args = ctx.actions.args()
    input_args.add_all(ctx.attr.arguments)
    if ctx.attr.separator:
        input_args.add(ctx.attr.separator.join([f.path for f in source_files_list]))
    else:
        input_args.add_all(source_files_list)

    if source_files:
        ctx.actions.run_shell(
            inputs = source_files_list,
            outputs = [ctx.outputs.out],
            tools = [ctx.executable.linter_tool],
            progress_message = "codestyle: " + str(ctx.label),
            arguments = [input_args],
            command = _LINT_SCRIPT.format(
                name = ctx.attr.name,
                linter_tool = ctx.executable.linter_tool.path,
                output_path = ctx.outputs.out.path,
                label = ctx.label,
            ),
        )
    else:
        ctx.actions.write(output = ctx.outputs.out, content = "")

    return FilesInfo(srcs = source_files)

code_style_lint_check = rule(
    implementation = _code_style_lint_check_impl,
    attrs = {
        "arguments": attr.string_list(
            doc = "Arguments to be applied to the linter",
        ),
        "extension": attr.string(
            default = "*",
        ),
        "linter_tool": attr.label(
            mandatory = True,
            executable = True,
            cfg = "host",
            allow_files = True,
        ),
        "separator": attr.string(),
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "targets": attr.label_list(
            aspects = [collect_src_files],
        ),
    },
    outputs = {"out": "%{name}.OUTPUT"},
    doc = """
    Check/lint code style of the selected targets.
    """,
)

def _code_style_lint_fix_impl(ctx):
    source_files = _unbox_source_files(ctx, ctx.attr.target)
    source_files_list = source_files.to_list()

    linter_tool = ctx.executable.linter_tool
    linter_script = ctx.actions.declare_file(ctx.attr.name)

    input_arg = " ".join([f.path for f in source_files_list])
    if ctx.attr.optimized:
        input_arg = "@%s" % ctx.files.target[0].path

    script_lines = ["#!/bin/bash"]
    tool_path = linter_tool.path
    script_lines.append('cd "$BUILD_WORKSPACE_DIRECTORY"')

    script_lines.append("{cmd} {args} {input} > /dev/null 2>&1".format(
        cmd = tool_path,
        args = " ".join(ctx.attr.arguments),
        input = input_arg,
    ))

    ctx.actions.write(
        output = linter_script,
        content = "\n".join(script_lines),
        is_executable = True,
    )

    runfiles = ctx.runfiles(
        files = ctx.files.target + [linter_tool],
    ).merge(
        ctx.attr.linter_tool.default_runfiles,
    ).merge(
        ctx.attr.linter_tool.data_runfiles,
    )

    return DefaultInfo(
        executable = linter_script,
        runfiles = runfiles,
    )

code_style_lint_fix = rule(
    implementation = _code_style_lint_fix_impl,
    attrs = {
        "arguments": attr.string_list(
            doc = "Arguments to be applied to the linter",
        ),
        "linter_tool": attr.label(
            mandatory = True,
            executable = True,
            cfg = "host",
            allow_files = True,
        ),
        "optimized": attr.bool(
            doc = "Ability to use lint check output",
            default = False,
        ),
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "target": attr.label(
            providers = [FilesInfo],
        ),
    },
    executable = True,
    doc = """
    Fix code style of the selected targets.
    """,
)

def _unbox_source_files(ctx, *targets):
    if not targets and not ctx.attr.srcs:
        fail("either `srcs` or `target(s)` must be provided")
    if targets and ctx.attr.srcs:
        fail("`srcs` or `target(s)` must be provided, not both")

    if targets:
        return depset(
            [],
            transitive = [target[FilesInfo].srcs for target in targets],
        )
    return depset([f for f in ctx.files.srcs if f.is_source])
