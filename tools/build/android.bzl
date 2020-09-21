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

def android_library(**args):
    _android_library(**args)

def android_binary(**args):
    _android_binary(**args)

def android_local_test(**args):
    _android_local_test(**args)

def android_instrumentation_test(tags = [], **args):
    _android_instrumentation_test(**args)
