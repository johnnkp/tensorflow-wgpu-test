"""Loads a lightweight subset of the ICU library for Unicode processing."""

load("//third_party:repo.bzl", "tf_http_archive", "tf_mirror_urls")

# NOTE: If you upgrade this, generate the data files by following the
# instructions in third_party/icu/data/BUILD
def repo():
    tf_http_archive(
        name = "icu",
        strip_prefix = "icu4c-76.1",
        sha256 = "605181c31ce7b44577ee3294e2083bdcf0424033427403f7985990ff491cb645",
        urls = "https://github.com/johnnkp/icu4c/archive/refs/tags/v76.1.zip",
        build_file = "//third_party/icu:icu.BUILD",
        system_build_file = "//third_party/icu:BUILD.system",
        # patch_file = ["//third_party/icu:udata.patch"],
    )
