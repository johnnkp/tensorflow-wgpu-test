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

kFingerprintError: str
kFingerprintFound: str
kFingerprintNotFound: str

class MetricException(Exception): ...

def AddAsyncCheckpointWriteDuration(*args, **kwargs): ...
def AddCheckpointReadDuration(*args, **kwargs): ...
def AddCheckpointWriteDuration(*args, **kwargs): ...
def AddNumCheckpointShardsWritten(*args, **kwargs): ...
def AddShardingCallbackDuration(*args, **kwargs): ...
def AddTrainingTimeSaved(*args, **kwargs): ...
def CalculateFileSize(arg0: str) -> int: ...
def GetAsyncCheckpointWriteDurations(*args, **kwargs): ...
def GetCheckpointReadDurations(*args, **kwargs): ...
def GetCheckpointSize(*args, **kwargs): ...
def GetCheckpointWriteDurations(*args, **kwargs): ...
def GetFoundFingerprintOnLoad() -> str: ...
def GetNumCheckpointShardsWritten() -> int: ...
def GetRead(*args, **kwargs): ...
def GetReadApi(arg0: str) -> int: ...
def GetReadFingerprint() -> str: ...
def GetReadPath() -> str: ...
def GetReadPathAndSingleprint() -> tuple[str, str]: ...
def GetShardingCallbackDescription() -> str: ...
def GetShardingCallbackDuration() -> int: ...
def GetTrainingTimeSaved(*args, **kwargs): ...
def GetWrite(*args, **kwargs): ...
def GetWriteApi(arg0: str) -> int: ...
def GetWriteFingerprint() -> str: ...
def GetWritePath() -> str: ...
def GetWritePathAndSingleprint() -> tuple[str, str]: ...
def IncrementRead(*args, **kwargs): ...
def IncrementReadApi(arg0: str) -> None: ...
def IncrementWrite(*args, **kwargs): ...
def IncrementWriteApi(arg0: str) -> None: ...
def RecordCheckpointSize(*args, **kwargs): ...
def SetFoundFingerprintOnLoad(*args, **kwargs): ...
def SetReadFingerprint(*args, **kwargs): ...
def SetReadPath(*args, **kwargs): ...
def SetReadPathAndSingleprint(*args, **kwargs): ...
def SetShardingCallbackDescription(*args, **kwargs): ...
def SetWriteFingerprint(*args, **kwargs): ...
def SetWritePath(*args, **kwargs): ...
def SetWritePathAndSingleprint(*args, **kwargs): ...