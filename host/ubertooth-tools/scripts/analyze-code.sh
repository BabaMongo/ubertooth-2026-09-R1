#!/bin/bash
# Code Analysis Script for Ubertooth Tools
# Runs static analysis tools and generates reports

set -e

ANALYSIS_DIR="${1:-.}"
REPORT_DIR="${ANALYSIS_DIR}/analysis-reports"

echo "========================================="
echo "Ubertooth Code Analysis"
echo "========================================="
echo ""

# Create reports directory
mkdir -p "${REPORT_DIR}"

# Check for analysis tools
echo "Checking for analysis tools..."
echo ""

# cppcheck analysis
if command -v cppcheck &> /dev/null; then
    echo "Running cppcheck..."
    cppcheck --enable=all \
             --std=c99 \
             --force \
             --suppress=missingIncludeSystem \
             --xml \
             --xml-version=2 \
             "src/" 2> "${REPORT_DIR}/cppcheck-report.xml"

    echo "  - Report: ${REPORT_DIR}/cppcheck-report.xml"

    # Convert XML to text format
    if command -v cppcheck &> /dev/null; then
        cppcheck --enable=all \
                 --std=c99 \
                 --force \
                 --suppress=missingIncludeSystem \
                 "src/" > "${REPORT_DIR}/cppcheck-report.txt" 2>&1 || true
        echo "  - Text Report: ${REPORT_DIR}/cppcheck-report.txt"
    fi
else
    echo "cppcheck not found - install with: apt-get install cppcheck"
fi

echo ""

# clang-analyzer
if command -v scan-build &> /dev/null; then
    echo "Running clang-analyzer..."
    scan-build -o "${REPORT_DIR}/clang-analysis" \
               make -C "${ANALYSIS_DIR}" clean all 2>&1 | grep -E "^clang|^checking|error" || true
    echo "  - Report: ${REPORT_DIR}/clang-analysis"
else
    echo "clang-analyzer not found - install with: apt-get install clang-tools"
fi

echo ""

# Summary
echo "========================================="
echo "Analysis Reports Generated"
echo "========================================="
echo "Reports location: ${REPORT_DIR}/"
echo ""
echo "Files:"
ls -lh "${REPORT_DIR}"/ 2>/dev/null || echo "  No reports generated"
echo ""
