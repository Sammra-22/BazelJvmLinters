"""
Common utils.
"""

load("//tools/lint:defs.bzl", "java_formatter", "kt_linter", "kt_formatter")

def java_format(target):
    java_formatter("%s.formatter" % target, target)

def kt_lint(target):
    kt_linter("%s.linter" % target, target)

def kt_format(target):
    kt_formatter("%s.formatter" % target, target)
