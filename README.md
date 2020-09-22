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

[bazel]: https://docs.bazel.build/versions/master/install.html
[bazelisk]: https://github.com/bazelbuild/bazelisk
