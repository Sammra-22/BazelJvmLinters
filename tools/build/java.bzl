"""
Build rules for Java targets.
"""

load(
    "@rules_java//java:defs.bzl",
    _java_binary = "java_binary",
    _java_library = "java_library",
    _java_test = "java_test"
)
load(
    "//tools/build:utils.bzl",
    _java_format = "java_format"
)

def java_library(**args):
    _java_format(args["name"])
    _java_library(**args)

def java_binary(**args):
    _java_format(args["name"])
    _java_binary(**args)

def java_test(**args):
    _java_format(args["name"])
    _java_test(**args)
