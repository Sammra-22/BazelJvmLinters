"""
Build rules for source files formatting in Kotlin
"""

load("//tools/lint:code_style.bzl", "code_style_lint_check", "code_style_lint_fix")

def kt_formatter(name, targets):
    code_style_lint_check(
        name = name,
        targets = targets,
        extension = "kt",
        linter_tool = "//tools/lint/ktlint",
        arguments = ["-a"],
    )
    code_style_lint_fix(
        name = "%s.FIX" % name,
        target = name,
        linter_tool = "//tools/lint/ktlint",
        arguments = ["-a", "-F"],
    )
