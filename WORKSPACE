## External rules & toolchains ##

load("//:dependencies.bzl", "generate_workspace_rules")

generate_workspace_rules()

load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kotlin_repositories", "kt_register_toolchains")

kotlin_repositories()
kt_register_toolchains()
android_sdk_repository(name = "androidsdk")
