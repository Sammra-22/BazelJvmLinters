"""
Common utils.
"""

load("//tools/lint:defs.bzl", "java_formatter", "kt_linter")

def java_format(target):
    java_formatter("%s.formatter" % target, target)

def kt_lint(target):
    kt_linter("%s.linter" % target, target)
