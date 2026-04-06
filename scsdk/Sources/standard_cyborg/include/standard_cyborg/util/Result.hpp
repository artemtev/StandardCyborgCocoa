/*
Copyright 2020 Standard Cyborg

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/


#pragma once

#include <string>

#if __cplusplus >= 201703L
#include <optional>
#endif

namespace standard_cyborg {

// A hacky std::expected<> while the committee seeks consensus
template <typename T>
struct Result {
#if __cplusplus >= 201703L
  std::optional<T> value;
  bool IsOk() const { return value.has_value(); }
#else
  T value;
  bool _has_value;
  bool IsOk() const { return _has_value; }
#endif
  std::string error;

  // Or use "{.value = v}"
  static Result<T> Ok(T &&v) {
    Result<T> r;
#if __cplusplus >= 201703L
    r.value = std::move(v);
#else
    r.value = std::move(v);
    r._has_value = true;
#endif
    return r;
  }

  // Or use "{.error = s}"
  static Result<T> Err(const std::string &s) {
    Result<T> r;
    r.error = s;
    return r;
  }
};

using OkOrErr = Result<bool>;
#if __cplusplus >= 201703L
static const OkOrErr kOK = {.value = true};
#endif

} // namespace standard_cyborg
