load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_ANDROID_VERSION = "0.1.1"
RULES_ANDROID_SHA = "cd06d15dd8bb59926e4d65f9003bfc20f9da4b2519985c27e190cddc8b7a7806"

RULES_KOTLIN_VERSION = "legacy-1.3.0"
RULES_KOTLIN_SHA = "4fd769fb0db5d3c6240df8a9500515775101964eebdf85a3f9f0511130885fde"

RULES_JVM_EXTERNAL_TAG = "2.2"
RULES_JVM_EXTERNAL_SHA = "f1203ce04e232ab6fdd81897cf0ff76f2c04c0741424d192f28e65ae752ce2d6"

def generate_workspace_rules():
    """
    Repository rules macro to be called in the WORKSPACE file.
    """
    http_archive(
        name = "build_bazel_rules_android",
        urls = ["https://github.com/bazelbuild/rules_android/archive/v%s.zip" % RULES_ANDROID_VERSION],
        type = "zip",
        strip_prefix = "rules_android-%s" % RULES_ANDROID_VERSION,
        sha256 = RULES_ANDROID_SHA
    )
    http_archive(
        name = "io_bazel_rules_kotlin",
        urls = ["https://github.com/bazelbuild/rules_kotlin/archive/%s.zip" % RULES_KOTLIN_VERSION],
        type = "zip",
        strip_prefix = "rules_kotlin-%s" % RULES_KOTLIN_VERSION,
        sha256 = RULES_KOTLIN_SHA
    )
    http_archive(
        name = "rules_jvm_external",
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
        sha256 = RULES_JVM_EXTERNAL_SHA,
        url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
    )
