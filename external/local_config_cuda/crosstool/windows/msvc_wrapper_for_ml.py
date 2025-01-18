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

"""Crosstool wrapper for assembling file with llvm-ml on Windows.

DESCRIPTION:
  This script is the llvm-ml version of //third_party/gpus/crosstool/windows/msvc_wrapper_for_nvcc.py
"""

import os
import subprocess
import sys

def ProcessFlagForCommandFile(file):
  new_argv = []
  invalid = ['/bigobj',
    '/Zm500',
    '/Z500',
    '/Z00',
    '/Z0',
    '/J',
    '/GF',
    '/Gy',
    '/EHsc',
    '/wd4351',
    '/wd4291',
    '/wd4250',
    '/wd4996',
    '/showIncludes',
    '/O2',
    '/Zc:__cplusplus',
    '/Zc:preprocessor',
    '/d2ReducedOptimizeHugeFunctions',
    '/clang:-Weverything',
    '/arch:SSE2',
    '/arch:SSE4.2',
    '/arch:AVX',
    '/arch:AVX2',
    '/arch:AVX512',
    '/arch:AVX10.1',
  ]

  for l in file.readlines():
    flag = l.strip()
    if not flag in invalid:
      new_argv.append(flag)

  return new_argv

def ExpandParamsFileForArgv():
  new_argv = []
  invalid_index = []
  with open(sys.argv[1].strip("@")) as f:
    new_argv.extend(ProcessFlagForCommandFile(f))

  return new_argv

def AsmCleanLine(line):
  invalid = []
  # clang-cl does not support multi-line comment
  invalid.append(line.strip("\n").startswith("/*"))
  invalid.append(line.strip("\n").startswith(" *"))
  # windows does not support GNU stack
  invalid.append(line.strip("\n").find(".note.GNU-stack,") >= 0)
  # clang-cl does not support .hidden
  invalid.append(line.strip("\n").find(".hidden") >= 0)
  # clang-cl does not support .type
  invalid.append(line.strip("\n").find('.type') >= 0)

  if True in invalid:
    return '// ' + line
  else:
    return line

def AsmCleanup(commandfile, new_file):
  with open(commandfile, "r") as f:
    lines = f.readlines()
    with open(new_file, "w") as new_f:
      for line in lines:
        new_f.write(AsmCleanLine(line))

def main():
  ml_path = 'C:/Program Files/LLVM/bin/clang-cl.exe'
  assembler_flags = [ml_path]
  assembler_flags.extend(ExpandParamsFileForArgv())

  commandfile = sys.argv[1].split('/')[-1]
  file_extension = commandfile.split('.')
  file_extension = file_extension[0] + '.clang-cl.S'

  asm_path = assembler_flags[-1].split('/')
  asm_path[-1] = file_extension
  asm_path = '/'.join(asm_path)
  AsmCleanup(os.path.join(os.getcwd(), assembler_flags[-1]).replace('\\', '/'),
    os.path.join(os.getcwd(), asm_path).replace('\\', '/'))

  assembler_flags[-1] = asm_path
  return subprocess.call(assembler_flags)

if __name__ == '__main__':
  sys.exit(main())
