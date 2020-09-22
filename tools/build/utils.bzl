"""
Common utils.
"""

load("//tools/lint:defs.bzl", "java_formatter")

def java_format(target):
    java_formatter("%s.formatter" % target, target)
