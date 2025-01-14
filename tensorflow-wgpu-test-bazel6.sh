# export MSYS_NO_PATHCONV=1
# export MSYS2_ARG_CONV_EXCL="*"
export PATH="/c/Users/AMD/anaconda3:$PATH"
export PATH="/c/Users/AMD/anaconda3/Scripts:$PATH"
export PYTHON_BIN_PATH=/c/Users/AMD/anaconda3/python.exe
export PYTHON_LIB_PATH=/c/Users/AMD/anaconda3/Lib/site-packages
export PYTHON_DIRECTORY=/c/Users/AMD/anaconda3/Scripts
export BAZEL_SH=/c/msys64/usr/bin/bash.exe
export BAZEL_VS="/c/Program Files/Microsoft Visual Studio/2022/Community"
export BAZEL_VC="/c/Program Files/Microsoft Visual Studio/2022/Community/VC"
export BAZEL_LLVM="/c/Program Files/LLVM"
export PATH="/c/Program Files/LLVM/bin:$PATH"
export PATH="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.5/bin:$PATH"
export PATH="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.5/extras/CUPTI/lib64:$PATH"
bazel build --repository_cache=/e/tensorflow --disk_cache=/e/tensorflow --test_tmpdir=/e/tensorflow --config=win_clang --config=cuda_wheel --config=opt --define=no_tensorflow_py_deps=true --repo_env=TF_PYTHON_VERSION=3.12 //tensorflow/tools/pip_package:wheel --repo_env=WHEEL_NAME=tensorflow_gpu