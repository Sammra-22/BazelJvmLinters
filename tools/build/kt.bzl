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

def kt_jvm_library(**kwargs):
    _kt_jvm_library(**kwargs)

def kt_jvm_binary(**kwargs):
    _kt_jvm_binary(**kwargs)

def kt_android_library(**kwargs):
    _kt_android_library(**kwargs)

def kt_android_binary(name, srcs = [], deps = [], **kwargs):
    library_name = name + "_kt_android_lib"
    kt_android_library(
        name = library_name,
        tags = kwargs.get("tags", default = []),
        srcs = srcs,
        deps = deps,
    )
    _android_binary(
        name = name,
        deps = deps + [library_name],
        **kwargs
    )

def kt_jvm_test(tags = [], **kwargs):
    _kt_jvm_test(tags = tags, **kwargs)
