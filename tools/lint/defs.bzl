load("//tools/lint/google_java_format:defs.bzl", _java_formatter = "java_formatter")

def java_formatter(name, target):
    _java_formatter(
        name = name,
        targets = [target],
    )
