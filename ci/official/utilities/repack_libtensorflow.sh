#!/bin/bash
#
# Copyright 2022 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ==============================================================================
#
# Repacks libtensorflow tarballs into $DIR with provided $TARBALL_SUFFIX,
# and also repacks libtensorflow-src.jar into a standardized format.

# Helper function to copy a srcjar after moving any source files
# directly under the root to the "maven-style" src/main/java layout
#
# Source files generated by annotation processors appear directly
# under the root of srcjars jars created by bazel, rather than under
# the maven-style src/main/java subdirectory.
#
# Bazel manages annotation generated source as follows: First, it
# calls javac with options that create generated files under a
# bazel-out directory. Next, it archives the generated source files
# into a srcjar directly under the root. There doesn't appear to be a
# simple way to parameterize this from bazel, hence this helper to
# "normalize" the srcjar layout.
#
# Arguments:
#   src_jar - path to the original srcjar
#   dest_jar - path to the destination
# Returns:
#   None
function cp_normalized_srcjar() {
  src_jar="$1"
  dest_jar="$2"
  tmp_dir=$(mktemp -d)
  cp "${src_jar}" "${tmp_dir}/orig.jar"
  pushd "${tmp_dir}"
  # Extract any src/ files
  jar -xf "${tmp_dir}/orig.jar" src/
  # Extract any org/ files under src/main/java
  (mkdir -p src/main/java && cd src/main/java && jar -xf "${tmp_dir}/orig.jar" org/)
  # Repackage src/
  jar -cMf "${tmp_dir}/new.jar" src
  popd
  cp "${tmp_dir}/new.jar" "${dest_jar}"
  rm -rf "${tmp_dir}"
}

DIR=$1
mkdir -p "$DIR"
TARBALL_SUFFIX=$2

if [[ $(uname -s) != MSYS_NT* ]]; then
  cp bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz "${DIR}/libtensorflow${TARBALL_SUFFIX}.tar.gz"
  cp bazel-bin/tensorflow/tools/lib_package/libtensorflow_jni.tar.gz "${DIR}/libtensorflow_jni${TARBALL_SUFFIX}.tar.gz"
  cp bazel-bin/tensorflow/java/libtensorflow.jar "${DIR}"
  cp_normalized_srcjar bazel-bin/tensorflow/java/libtensorflow-src.jar "${DIR}/libtensorflow-src.jar"
  cp bazel-bin/tensorflow/tools/lib_package/libtensorflow_proto.zip "${DIR}"
else
  LIB_PKG="$1/lib_package"
  mkdir -p ${LIB_PKG}

  # Zip up the .dll and the LICENSE for the JNI library.
  cp bazel-bin/tensorflow/java/tensorflow_jni.dll ${LIB_PKG}/tensorflow_jni.dll
  zip -j ${LIB_PKG}/libtensorflow_jni-cpu-windows-$(uname -m).zip \
    ${LIB_PKG}/tensorflow_jni.dll \
    bazel-bin/tensorflow/tools/lib_package/include/tensorflow/THIRD_PARTY_TF_JNI_LICENSES \
    LICENSE
  rm -f ${LIB_PKG}/tensorflow_jni.dll

  # Zip up the .dll, LICENSE and include files for the C library.
  mkdir -p ${LIB_PKG}/include/tensorflow/c
  mkdir -p ${LIB_PKG}/include/tensorflow/c/eager
  mkdir -p ${LIB_PKG}/include/tensorflow/core/platform
  mkdir -p ${LIB_PKG}/include/xla/tsl/c
  mkdir -p ${LIB_PKG}/include/tsl/platform
  mkdir -p ${LIB_PKG}/lib
  cp bazel-bin/tensorflow/tensorflow.dll ${LIB_PKG}/lib/tensorflow.dll
  cp bazel-bin/tensorflow/tensorflow.lib ${LIB_PKG}/lib/tensorflow.lib
  cp tensorflow/c/c_api.h \
    tensorflow/c/tf_attrtype.h \
    tensorflow/c/tf_buffer.h  \
    tensorflow/c/tf_datatype.h \
    tensorflow/c/tf_status.h \
    tensorflow/c/tf_tensor.h \
    tensorflow/c/tf_tensor_helper.h \
    tensorflow/c/tf_tstring.h \
    tensorflow/c/tf_file_statistics.h \
    tensorflow/c/tensor_interface.h \
    tensorflow/c/c_api_macros.h \
    tensorflow/c/c_api_experimental.h \
    ${LIB_PKG}/include/tensorflow/c
  cp tensorflow/c/eager/c_api.h \
    tensorflow/c/eager/c_api_experimental.h \
    tensorflow/c/eager/dlpack.h \
    ${LIB_PKG}/include/tensorflow/c/eager
  cp tensorflow/core/platform/ctstring.h \
    tensorflow/core/platform/ctstring_internal.h \
    ${LIB_PKG}/include/tensorflow/core/platform
  cp third_party/xla/xla/tsl/c/tsl_status.h ${LIB_PKG}/include/xla/tsl/c
  cp third_party/xla/third_party/tsl/tsl/platform/ctstring.h \
     third_party/xla/third_party/tsl/tsl/platform/ctstring_internal.h \
     ${LIB_PKG}/include/tsl/platform
  cp LICENSE ${LIB_PKG}/LICENSE
  cp bazel-bin/tensorflow/tools/lib_package/THIRD_PARTY_TF_C_LICENSES ${LIB_PKG}/
  cd ${LIB_PKG}
  zip libtensorflow-cpu-windows-$(uname -m).zip \
    lib/tensorflow.dll \
    lib/tensorflow.lib \
    include/tensorflow/c/eager/c_api.h \
    include/tensorflow/c/eager/c_api_experimental.h \
    include/tensorflow/c/eager/dlpack.h \
    include/tensorflow/c/c_api.h \
    include/tensorflow/c/tf_attrtype.h \
    include/tensorflow/c/tf_buffer.h  \
    include/tensorflow/c/tf_datatype.h \
    include/tensorflow/c/tf_status.h \
    include/tensorflow/c/tf_tensor.h \
    include/tensorflow/c/tf_tensor_helper.h \
    include/tensorflow/c/tf_tstring.h \
    include/tensorflow/c/tf_file_statistics.h \
    include/tensorflow/c/tensor_interface.h \
    include/tensorflow/c/c_api_macros.h \
    include/tensorflow/c/c_api_experimental.h \
    include/tensorflow/core/platform/ctstring.h \
    include/tensorflow/core/platform/ctstring_internal.h \
    include/xla/tsl/c/tsl_status.h \
    include/tsl/platform/ctstring.h \
    include/tsl/platform/ctstring_internal.h \
    LICENSE \
    THIRD_PARTY_TF_C_LICENSES
  rm -rf lib include

  cd ..
  tar -zcvf windows_cpu_libtensorflow_binaries.tar.gz $LIB_PKG
  rm -rf $LIB_PKG

fi