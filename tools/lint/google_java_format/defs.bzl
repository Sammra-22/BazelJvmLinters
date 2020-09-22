"""
Build rules for source files formatting in Java
"""

load("//tools/lint:code_style.bzl", "code_style_lint_check", "code_style_lint_fix")

def java_formatter(name, targets):
    code_style_lint_check(
        name = name,
        targets = targets,
        extension = "java",
        linter_tool = "//tools/lint/google_java_format",
        arguments = ["--dry-run"],
    )
    code_style_lint_fix(
        name = "%s.FIX" % name,
        target = name,
        linter_tool = "//tools/lint/google_java_format",
        arguments = ["-i"],
        optimized = True,
    )
