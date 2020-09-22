# Bazel JVM Linters

Source code linting for Android projects built in Bazel using `google-java-format`, `ktlint` and `detekt`.

## Prerequisites

- Install [Bazel][bazel] or [Bazelisk][bazelisk] which is a simple wrapper for managing multiple versions of Bazel
- Set the `ANDROID_HOME` variable to the location of the Android SDK: 
```
export ANDROID_HOME=$HOME/Library/Android/sdk
```

## Build & Run

To build the sample Android application:
```
bazel build //src/main/java/com/sample/app
```

To run lint checks for a specific target (Add suffix `.formatter`):
```
bazel build //src/main/java/com/sample/app:app.formatter
```

To apply lint fixes for a specific target (Add suffix `.formatter.FIX`):
```
bazel run //src/main/java/com/sample/app:app.formatter.FIX
```

To run lint checks for the whole workspace:
```
tools/lint/checks.sh
```

## Integration

To use the Android lint rules in your bazel project, add the following to your `WORKSPACE`:
```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "bazel_jvm_linters",
    urls = ["https://github.com/Sammra-22/BazelJvmLinters/archive/v0.1.zip"],
    sha256 = "78604ccf89d12cca2522b57c79e2c98f9a1f56ccb93cb9a4adb724e0d5ae09f1",
    strip_prefix = "BazelJvmLinters-0.1",
)
```

Then import and use the rules in your `BUILD` file:

```
load("@bazel_jvm_linters//tools/lint:defs.bzl", "java_formatter", "kt_formatter", "kt_linter")
java_formatter(
    name = ...
    target = ...
)
kt_formatter(
    name = ...
    target = ...
)
kt_linter(
    name = ...
    target = ...
)
```

[bazel]: https://docs.bazel.build/versions/master/install.html
[bazelisk]: https://github.com/bazelbuild/bazelisk
