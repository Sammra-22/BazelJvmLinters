workspace(name = "bazel_jvm_linters")

## External rules & toolchains ##

load("//:dependencies.bzl", "generate_workspace_rules", "import_external_tools")

generate_workspace_rules()
import_external_tools()

load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kotlin_repositories", "kt_register_toolchains")

kotlin_repositories()
kt_register_toolchains()
android_sdk_repository(name = "androidsdk")

## External libraries & artifacts ##

load("@rules_jvm_external//:defs.bzl", "maven_install")

ANDROIDX_ANNOTATION = "1.1.0"
ANDROIDX_APPCOMPAT = "1.1.0"
ANDROIDX_CONSTRAINT_LAYOUT = "1.1.3"
ANDROIDX_CORE = "1.1.0"
ANDROIDX_FRAGMENT = "1.0.0"
ANDROIDX_LIFECYCLE = "2.2.0"
ANDROIDX_NAVIGATION = "2.3.0"
COM_GOOGLE_MATERIAL = "1.0.0"
COM_PINTEREST_KTLINT = "0.39.0"

maven_install(
    artifacts = [
        "androidx.annotation:annotation:%s" % ANDROIDX_ANNOTATION,
        "androidx.appcompat:appcompat:%s" % ANDROIDX_APPCOMPAT,
        "androidx.constraintlayout:constraintlayout:%s" % ANDROIDX_CONSTRAINT_LAYOUT,
        "androidx.core:core:%s" % ANDROIDX_CORE,
        "androidx.fragment:fragment:%s" % ANDROIDX_FRAGMENT,
        "androidx.lifecycle:lifecycle-runtime:%s" % ANDROIDX_LIFECYCLE,
        "androidx.lifecycle:lifecycle-viewmodel:%s" % ANDROIDX_LIFECYCLE,
        "androidx.lifecycle:lifecycle-common:%s" % ANDROIDX_LIFECYCLE,
        "androidx.navigation:navigation-fragment:%s" % ANDROIDX_NAVIGATION,
        "com.google.android.material:material:%s" % COM_GOOGLE_MATERIAL,
        "com.pinterest:ktlint:%s" % COM_PINTEREST_KTLINT,
    ],
    repositories = [
        "https://maven.google.com",
        "https://repo1.maven.org/maven2/"
    ],
    fetch_sources = True,
)
