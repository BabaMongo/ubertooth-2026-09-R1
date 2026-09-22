# Code Analysis Tools Configuration
# This file integrates static analysis tools into the CMake build system

# cppcheck configuration
find_program(CPPCHECK cppcheck)
if(CPPCHECK)
    message(STATUS "cppcheck found: ${CPPCHECK}")
    set(CPPCHECK_ARGS
        --enable=all
        --std=c99
        --force
        --inline-suppr
        --suppress=missingIncludeSystem
        --error-exitcode=1
    )
else()
    message(STATUS "cppcheck not found - install with: apt-get install cppcheck")
endif()

# clang-analyzer configuration
find_program(CLANG_ANALYZER clang-analyzer)
if(CLANG_ANALYZER)
    message(STATUS "clang-analyzer found: ${CLANG_ANALYZER}")
else()
    message(STATUS "clang-analyzer not found - install with: apt-get install clang-tools")
endif()

# Function to add cppcheck target for a source file
function(add_cppcheck_analysis target_name source_files)
    if(CPPCHECK)
        add_custom_target(
            cppcheck_${target_name}
            COMMAND ${CPPCHECK} ${CPPCHECK_ARGS} ${source_files}
            COMMENT "Running cppcheck on ${target_name}"
        )
    endif()
endfunction()

# Function to add clang-analyzer target
function(add_clang_analysis target_name source_files)
    if(CLANG_ANALYZER)
        add_custom_target(
            clang_analyze_${target_name}
            COMMAND scan-build -o ${CMAKE_BINARY_DIR}/scan-build-results
                    gcc -c ${source_files}
            COMMENT "Running clang-analyzer on ${target_name}"
        )
    endif()
endfunction()

# Add global analysis targets
if(CPPCHECK)
    add_custom_target(cppcheck-all
        COMMENT "Running cppcheck on all sources"
    )
endif()

if(CLANG_ANALYZER)
    add_custom_target(clang-analyze-all
        COMMENT "Running clang-analyzer on all sources"
    )
endif()
