load("//tools/lint/google_java_format:defs.bzl", _java_formatter = "java_formatter")
load("//tools/lint/detekt:defs.bzl", _kt_linter = "kt_linter")

def java_formatter(name, target):
    _java_formatter(
        name = name,
        targets = [target],
    )

def kt_linter(name, target):
    _kt_linter(
        name = name,
        targets = [target],
    )
