# buildtest
Scripts to develop compile time tests using CMake and CTest.

## Usage
```cmake
enable_testing()
include(buildtest.cmake)

# Test that the project in success subfolder correctly compiles
add_build_test(
    NAME ts_success
    FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/success)

# Test that the project in failure subfolder doesn't compile
add_build_test(
    NAME ts_failure
    FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/failure
    EXPECT_FAIL)
```

To run the tests, simply run `ctest`

## Limitations
* When expecting a failure, it is not possible to specify the expected cause of
failure.

* CMake files of projects under tests must be self-contained; it is not possible
to propagate options or command line arguments from the current CMake project.

## License
This work is released into the public domain.
