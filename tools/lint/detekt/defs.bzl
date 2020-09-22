"""
Build rules for static analysis & linting in Kotlin
"""

load("//tools/lint:code_style.bzl", "code_style_lint_check")

def kt_linter(name, targets):
    code_style_lint_check(
        name = name,
        targets = targets,
        extension = "kt",
        linter_tool = "//tools/lint/detekt",
        arguments = ["--input"],
        separator = ";",
    )
