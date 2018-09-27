cmake_minimum_required(VERSION 3.1)

project(build_test_root)

enable_testing()
include(../buildtest/buildtest.cmake)

add_build_test(
    NAME ts_success
    FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/success)

add_build_test(
    NAME ts_failure
    FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/failure
    EXPECT_FAIL)

