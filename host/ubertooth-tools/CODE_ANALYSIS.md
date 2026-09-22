# Ubertooth Code Analysis and Testing

This document describes the code analysis and testing infrastructure for Ubertooth tools.

## Code Analysis Tools

### Setup

The code analysis tools are configured in `CodeAnalysis.cmake` and automatically detected during CMake configuration.

#### Available Tools

1. **cppcheck** - Static C/C++ analysis
   - Install: `apt-get install cppcheck`
   - Detects: memory leaks, buffer overflows, null pointer dereferences, unused variables

2. **clang-analyzer** - Part of LLVM toolchain
   - Install: `apt-get install clang-tools`
   - Detects: logic errors, dead code, API usage errors

3. **valgrind** - Runtime memory analysis
   - Install: `apt-get install valgrind`
   - Detects: memory leaks, invalid memory access, use-after-free

### Running Analysis

#### Quick Analysis
```bash
./scripts/analyze-code.sh
```

#### With CMake
```bash
cd build
cmake ..
make cppcheck-all
make clang-analyze-all
```

#### Memory Analysis (requires valgrind)
```bash
valgrind --leak-check=full ./ubertooth-debug
```

## Unit Testing

### Test Framework

A simple unit test framework is provided in `tests/test_runner.c` with assertion macros for common checks.

#### Assertion Macros

- `ASSERT_TRUE(condition)` - Assert condition is true
- `ASSERT_FALSE(condition)` - Assert condition is false
- `ASSERT_EQUAL(expected, actual)` - Assert values are equal
- `ASSERT_NOT_NULL(ptr)` - Assert pointer is not NULL
- `ASSERT_NULL(ptr)` - Assert pointer is NULL

### Building Tests

```bash
cd build
cmake ..
make ubertooth-tests
```

### Running Tests

#### Basic Test Run
```bash
ctest
```

#### Verbose Output
```bash
ctest -VV
```

#### With Memory Analysis
```bash
make test-memory
```

#### Using make test target
```bash
make test-run
make test-verbose
```

## Integration with CI/CD

The analysis tools can be integrated into CI/CD pipelines:

### GitHub Actions Example
```yaml
- name: Run Static Analysis
  run: |
    make cppcheck-all
    make clang-analyze-all

- name: Run Unit Tests
  run: |
    make ubertooth-tests
    ctest --output-on-failure
```

## Best Practices

1. **Run analysis regularly** - Integrate into CI/CD pipelines
2. **Fix high-priority issues** - Address memory and safety issues first
3. **Review warnings** - Not all warnings indicate actual bugs
4. **Use consistent compiler flags** - Security flags help catch issues early
5. **Write unit tests** - Add tests for critical functions

## Current Status

- ✅ cppcheck configuration: Ready
- ✅ clang-analyzer configuration: Ready
- ✅ valgrind integration: Ready
- ✅ Basic unit test framework: Ready
- ⚠️ Full test coverage: In progress

## See Also

- `CodeAnalysis.cmake` - CMake integration
- `tests/` - Unit test files
- `scripts/analyze-code.sh` - Analysis runner script
