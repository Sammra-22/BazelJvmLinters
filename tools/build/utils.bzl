"""
Common utils.
"""

load("//tools/lint/google_java_format:defs.bzl", "java_formatter")

def java_format(target):
    java_formatter(
        name = "%s.formatter" % target,
        targets = [target],
    )
