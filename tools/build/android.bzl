"""
Build rules for Android targets.
"""

load(
    "@build_bazel_rules_android//android:rules.bzl",
    _android_binary = "android_binary",
    _android_instrumentation_test = "android_instrumentation_test",
    _android_library = "android_library",
    _android_local_test = "android_local_test",
)
load(
    "//tools/build:utils.bzl",
    _java_format = "java_format"
)

def android_library(**args):
    _java_format(args["name"])
    _android_library(**args)

def android_binary(**args):
    _java_format(args["name"])
    _android_binary(**args)

def android_local_test(**args):
    _java_format(args["name"])
    _android_local_test(**args)

def android_instrumentation_test(tags = [], **args):
    _java_format(args["name"])
    _android_instrumentation_test(**args)
