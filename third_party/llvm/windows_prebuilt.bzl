"""Loads a prebuilt subset of the LLVM library for Windows CUDA build."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def repo():
    http_archive(
        name = "llvm_windows_prebuilt",
        strip_prefix = "clang+llvm-19.1.7-x86_64-pc-windows-msvc",
        sha256 = "b4557b4f012161f56a2f5d9e877ab9635cafd7a08f7affe14829bd60c9d357f0",
        url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.7/clang+llvm-19.1.7-x86_64-pc-windows-msvc.tar.xz",
    )
