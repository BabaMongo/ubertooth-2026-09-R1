# Unit Tests Configuration

# Test runner executable
add_executable(ubertooth-tests test_runner.c)

# Add test to CMake's test suite
enable_testing()
add_test(NAME ubertooth-unit-tests COMMAND ubertooth-tests)

# Custom targets for running tests
add_custom_target(test-run
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
    DEPENDS ubertooth-tests
    COMMENT "Running Ubertooth unit tests"
)

add_custom_target(test-verbose
    COMMAND ${CMAKE_CTEST_COMMAND} -VV
    DEPENDS ubertooth-tests
    COMMENT "Running Ubertooth unit tests (verbose)"
)

# Memory test target (requires valgrind)
find_program(VALGRIND valgrind)
if(VALGRIND)
    add_custom_target(test-memory
        COMMAND ${VALGRIND} --leak-check=full --show-leak-kinds=all
                --track-origins=yes --log-file=valgrind.log
                ./ubertooth-tests
        DEPENDS ubertooth-tests
        COMMENT "Running Ubertooth unit tests with valgrind"
    )
else()
    message(STATUS "valgrind not found - memory tests disabled. Install with: apt-get install valgrind")
endif()
