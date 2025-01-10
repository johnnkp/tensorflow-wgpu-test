"""Hermetic Python initialization. Consult the WORKSPACE on how to use it."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def python_init_rules():
    http_archive(
        name = "rules_python",
        sha256 = "5b09fb82d8577bdae45fa3adaf50b41d6719f5dadb61d8b39c32eac3e2927a21",
        strip_prefix = "bazel_rules_python-39",
        url = "https://github.com/johnnkp/bazel_rules_python/archive/refs/tags/v39.tar.gz",
        patch_args = ["-p1"],
        patches = [Label("//third_party/py:rules_python.patch")],
    )
