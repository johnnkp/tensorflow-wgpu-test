# Copyright 2025 The TensorFlow Authors. All Rights Reserved.
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
# ==============================================================================

"""Crosstool wrapper for compiling library file with lib.exe on Windows.

DESCRIPTION:
  This script is the lib.exe version of //third_party/gpus/crosstool/windows/msvc_wrapper_for_nvcc.py
"""

import subprocess
import sys

def main():
  lib_path = 'C:/Program Files/LLVM/bin/llvm-lib.exe'
  output = [flag for flag in sys.argv if flag.startswith("/OUT:")]
  commandfile_path = output[0].strip('/OUT:') + ".msvc_params"
  commandfile = open(commandfile_path, "w")
  commandfile.write("\n".join(sys.argv[1:]))
  commandfile.close()
  return subprocess.call([lib_path, "@" + commandfile_path])

if __name__ == '__main__':
  sys.exit(main())
