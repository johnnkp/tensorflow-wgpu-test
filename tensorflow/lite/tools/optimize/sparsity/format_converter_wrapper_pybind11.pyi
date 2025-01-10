# Copyright 2023 The TensorFlow Authors. All Rights Reserved.
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

from typing import ClassVar, overload

TF_LITE_DIM_DENSE: TfLiteDimensionType
TF_LITE_DIM_SPARSE_CSR: TfLiteDimensionType
TF_LITE_ERROR: TfLiteStatus
TF_LITE_OK: TfLiteStatus

class FormatConverterFp32:
    @overload
    def __init__(self, arg0: list[int], arg1: list[int], arg2: list[TfLiteDimensionType], arg3: list[int], arg4: list[int]) -> None: ...
    @overload
    def __init__(self, arg0: list[int], arg1: TfLiteSparsity) -> None: ...
    def DenseToSparse(self, arg0) -> TfLiteStatus: ...
    def GetData(self) -> list[float]: ...
    def GetDimMetadata(self) -> list[list[int]]: ...
    def SparseToDense(self, arg0) -> TfLiteStatus: ...

class TfLiteDimensionType:
    __members__: ClassVar[dict] = ...  # read-only
    TF_LITE_DIM_DENSE: ClassVar[TfLiteDimensionType] = ...
    TF_LITE_DIM_SPARSE_CSR: ClassVar[TfLiteDimensionType] = ...
    __entries: ClassVar[dict] = ...
    def __init__(self, value: int) -> None: ...
    def __eq__(self, other: object) -> bool: ...
    def __hash__(self) -> int: ...
    def __index__(self) -> int: ...
    def __int__(self) -> int: ...
    def __ne__(self, other: object) -> bool: ...
    @property
    def name(self) -> str: ...
    @property
    def value(self) -> int: ...

class TfLiteSparsity:
    def __init__(self, *args, **kwargs) -> None: ...

class TfLiteStatus:
    __members__: ClassVar[dict] = ...  # read-only
    TF_LITE_ERROR: ClassVar[TfLiteStatus] = ...
    TF_LITE_OK: ClassVar[TfLiteStatus] = ...
    __entries: ClassVar[dict] = ...
    def __init__(self, value: int) -> None: ...
    def __eq__(self, other: object) -> bool: ...
    def __hash__(self) -> int: ...
    def __index__(self) -> int: ...
    def __int__(self) -> int: ...
    def __ne__(self, other: object) -> bool: ...
    @property
    def name(self) -> str: ...
    @property
    def value(self) -> int: ...
