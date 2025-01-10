"""Hermetic Python initialization. Consult the WORKSPACE on how to use it."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def python_init_rules():
    http_archive(
        name = "rules_python",
        sha256 = "1d537b4e6bb950064b9772ef15e03e51709b97ea3a17f20baf4d201205f54660",
        strip_prefix = "bazel_rules_python-1.0.0",
        url = "https://github.com/johnnkp/bazel_rules_python/archive/refs/tags/v1.0.0.tar.gz",
        patch_args = ["-p1"],
        patches = [Label("//third_party/py:rules_python.patch")],
    )
