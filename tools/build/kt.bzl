"""
Build rules for Kotlin targets.
"""

load("@build_bazel_rules_android//android:rules.bzl",
    _android_binary = "android_binary",
)
load(
    "@io_bazel_rules_kotlin//kotlin:kotlin.bzl",
    _kt_android_library = "kt_android_library",
    _kt_jvm_binary = "kt_jvm_binary",
    _kt_jvm_library = "kt_jvm_library",
    _kt_jvm_test = "kt_jvm_test",
)
load(
    "//tools/build:utils.bzl",
    _kt_lint = "kt_lint"
)

def kt_jvm_library(**args):
    _kt_lint(args["name"])
    _kt_jvm_library(**args)

def kt_jvm_binary(**args):
    _kt_lint(args["name"])
    _kt_jvm_binary(**args)

def kt_android_library(**args):
    _kt_lint(args["name"])
    _kt_android_library(**args)

def kt_android_binary(name, srcs = [], deps = [], **args):
    library_name = name + "_kt_android_lib"
    kt_android_library(
        name = library_name,
        tags = args.get("tags", default = []),
        srcs = srcs,
        deps = deps,
    )
    _android_binary(
        name = name,
        deps = deps + [library_name],
        **args
    )

def kt_jvm_test(tags = [], **args):
    _kt_lint(args["name"])
    _kt_jvm_test(tags = tags, **args)
