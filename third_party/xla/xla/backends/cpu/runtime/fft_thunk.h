/* Copyright 2024 The OpenXLA Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#ifndef XLA_BACKENDS_CPU_RUNTIME_FFT_THUNK_H_
#define XLA_BACKENDS_CPU_RUNTIME_FFT_THUNK_H_

#include <cstdint>
#include <memory>
#include <vector>

#include "absl/status/statusor.h"
#include "absl/types/span.h"
#include "xla/backends/cpu/runtime/thunk.h"
#include "xla/service/buffer_assignment.h"
#include "xla/shape.h"
#include "xla/stream_executor/stream_executor.h"
#include "xla/tsl/concurrency/async_value_ref.h"

namespace xla::cpu {

// This class stores everything that is needed to launch an FFT.
// It is generated by IrEmitter.
//
// This is thread-compatible.
class FftThunk final : public Thunk {
 public:
  static absl::StatusOr<std::unique_ptr<FftThunk>> Create(
      Info thunk_info, bool is_multi_thread_eigen, int32_t fft_type,
      absl::Span<const int64_t> fft_length,
      BufferAllocation::Slice input_buffer, const Shape& input_shape,
      BufferAllocation::Slice output_buffer, const Shape& output_shape);

  tsl::AsyncValueRef<Thunk::ExecuteEvent> Execute(
      const ExecuteParams& params) final;

  BufferUses buffer_uses() const final;

  bool is_multi_thread_eigen() const { return is_multi_thread_eigen_; }
  int32_t fft_type() const { return fft_type_; }
  const std::vector<int64_t>& fft_length() const { return fft_length_; }
  const BufferAllocation::Slice& input_buffer() const { return input_buffer_; }
  const Shape& input_shape() const { return input_shape_; }
  const BufferAllocation::Slice& output_buffer() const {
    return output_buffer_;
  }
  const Shape& output_shape() const { return output_shape_; }

 private:
  // Constructs a thunk for launching an FFT on a host.
  FftThunk(Info thunk_info, bool is_multi_thread_eigen, int32_t fft_type,
           absl::Span<const int64_t> fft_length,
           BufferAllocation::Slice input_buffer, const Shape& input_shape,
           BufferAllocation::Slice output_buffer, const Shape& output_shape);

  const bool is_multi_thread_eigen_;
  const bool is_double_precision_;
  const int32_t fft_type_;
  const std::vector<int64_t> fft_length_;

  const BufferAllocation::Slice input_buffer_;
  const BufferAllocation::Slice output_buffer_;

  const Shape input_shape_;
  const Shape output_shape_;
};

}  // namespace xla::cpu

#endif  // XLA_BACKENDS_CPU_RUNTIME_FFT_THUNK_H_
