"""Loads a lightweight subset of the ICU library for Unicode processing."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# NOTE: If you upgrade this, generate the data files by following the
# instructions in third_party/icu/data/BUILD
def repo():
    http_archive(
        name = "icu",
        strip_prefix = "icu4c-76.1",
        sha256 = "4613cee8aaded96aac559b195e36857b4bedad53895b76571543c1b319f6ae68",
        url = "https://github.com/johnnkp/icu4c/archive/refs/tags/v76.1.tar.gz",
        build_file = "//third_party/icu:icu.BUILD",
        # system_build_file = "//third_party/icu:BUILD.system",
        # patch_file = ["//third_party/icu:udata.patch"],
    )
