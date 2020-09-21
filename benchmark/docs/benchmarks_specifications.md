# Benchmarks Specifications

This is a summary of the benchmarks and how they are executed.

> **Note that the specifications below have not been programmatically tied to the benchmark files, so please do check the code itself if you want to *really* confirm what's going on in the benchmarks, specially when it comes to how many times they're run.**

## 1. Lists

> Note that, currently, with the [`benchmark_harness`][benchmark_harness] package, both `setup` and `teardown` are equivalent to `setUpAll` and `tearDownAll` in the [`test`][test] package.


[benchmark_harness]: https://pub.dev/packages/benchmark_harness
[test]: https://pub.dev/packages/test

### 1.1. Empty Initialization

| Data Object      | Setup | Run                   | Teardown       |
| ---------------- | ----- | --------------------- | -------------- |
| `List` (Mutable) | -     | `<int>[]`             | Log Empty List |
| `IList`          | -     | `IList<int>()`        | Log Empty List |
| `KtList`         | -     | `KtList<int>.empty()` | Log Empty List |
| `BuiltList`      | -     | `BuiltList<int>()`    | Log Empty List |

### 1.2. Reading an Element

Size here is the *length* of the list being read.

| Size |
| ---- |
| 10k  |

| Data Object      | Setup                         | Run  | Teardown       |
| ---------------- | ----------------------------- | ---- | -------------- |
| `List` (Mutable) | `List.generate`               | `[]` | Log Value Read |
| `IList`          | `IList(List.generate)`        | `[]` | Log Value Read |
| `KtList`         | `KtList.from(List.generate)`  | `[]` | Log Value Read |
| `BuiltList`      | `BuiltList.of(List.generate)` | `[]` | Log Value Read |

### 1.3. Adding 1 or Multiple Elements

Size refers to the *length* of the original list before the insertion of the new element(s).

| Size |
| ---- |
| 10   |
| 1k   |
| 100k |

| Data Object      | Setup                         | Run                                  | Teardown       |
| ---------------- | ----------------------------- | ------------------------------------ | -------------- |
| `List` (Mutable) | `List.generate`               | 3x `..add()`                         | Log Final List |
| `IList`          | N times `IList().add()`       | 3x `.add()`                          | Log Final List |
| `KtList`         | `KtList.from(List.generate)`  | 3x `.plusElement()`                  | Log Final List |
| `BuiltList`      | `BuiltList.of(List.generate)` | 3x `.rebuild(.add())`                | Log Final List |
| `BuiltList`      | `BuiltList.of(List.generate)` | (# Runs / 50)x `ListBuilder.build()` | Log Final List |

### 1.4. Removing 1 Element

| Size |
| ---- |
| 10   |
| 1k   |
| 100k |

| Data Object      | Setup                         | Run                                  | Teardown       |
| ---------------- | ----------------------------- | ------------------------------------ | -------------- |
| `List` (Mutable) | `List.generate`               | 3x `..remove()`                      | Log Final List |
| `IList`          | `IList(List.generate)`        | 3x `.remove()`                       | Log Final List |
| `KtList`         | `KtList.from(List.generate)`  | 3x `.minusElement()`                 | Log Final List |
| `BuiltList`      | `BuiltList.of(List.generate)` | 3x `.rebuild(.remove())`             | Log Final List |
| `BuiltList`      | `BuiltList.of(List.generate)` | (# Runs / 50)x `ListBuilder.build()` | Log Final List |

### 1.5. Adding Multiple Elements at Once with `addAll`

| Size of the Original List | Size of the List to be Added |
| ------------------------- | ---------------------------- |
| 10                        | 10                           |
| 1k                        | 1k                           |
| 10k                       | 10k                          |

| Data Object      | Setup          | Run                    | Teardown       |
| ---------------- | -------------- | ---------------------- | -------------- |
| `List` (Mutable) | `List.of`      | `.addAll()`            | Log Final List |
| `IList`          | `IList`        | `.addAll()`            | Log Final List |
| `KtList`         | `KtList.from`  | `.plus(KtList.from())` | Log Final List |
| `BuiltList`      | `BuiltList.of` | `.rebuild(.addAll())`  | Log Final List |