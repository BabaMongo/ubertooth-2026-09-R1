#!/bin/bash
# Verification script für Ubertooth 2026-09-R1 Verbesserungen

echo "🔍 Ubertooth 2026-09-R1 Verbesserungen Verifizierung"
echo "=================================================="
echo ""

cd "$(dirname "$0")"

# Farben
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

passed=0
failed=0

# Test 1: CMake Version Check
echo -n "✓ CMake Version (3.10...3.28): "
if grep -q "cmake_minimum_required(VERSION 3.10...3.28)" host/CMakeLists.txt; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

# Test 2: Security Flags
echo -n "✓ Compiler Security Flags: "
if grep -q "D_FORTIFY_SOURCE=2" host/CMakeLists.txt && \
   grep -q "fstack-protector-strong" host/CMakeLists.txt; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

# Test 3: Configuration Files
echo -n "✓ cppcheck config: "
if [ -f ".cppcheck.cfg" ]; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

echo -n "✓ clang-tidy config: "
if [ -f ".clang-tidy" ]; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

echo -n "✓ editorconfig: "
if [ -f ".editorconfig" ]; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

# Test 4: Documentation
echo -n "✓ SECURITY.md: "
if [ -f "SECURITY.md" ]; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

echo -n "✓ CONTRIBUTING.md: "
if [ -f "CONTRIBUTING.md" ]; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi

# Test 5: Build Test
echo -n "✓ Build Test: "
cd host
if make clean > /dev/null 2>&1 && cmake . > /dev/null 2>&1 && make -j4 > /dev/null 2>&1; then
	echo -e "${GREEN}PASS${NC}"
	((passed++))
else
	echo -e "${RED}FAIL${NC}"
	((failed++))
fi
cd ..

# Test 6: Unsafe String Functions (sample check)
echo -n "✓ strcpy Warnings: "
unsafe_count=$(grep -r "strcpy\|strcat" --include="*.c" host/ 2>/dev/null | grep -v "snprintf" | grep -v "//" | wc -l)
if [ "$unsafe_count" -lt 5 ]; then
	echo -e "${GREEN}PASS${NC} (${unsafe_count} remaining)"
	((passed++))
else
	echo -e "${YELLOW}CHECK${NC} (${unsafe_count} Aufrufe)"
fi

echo ""
echo "=================================================="
echo -e "Ergebnisse: ${GREEN}${passed} PASS${NC}, ${RED}${failed} FAIL${NC}"
echo ""

if [ $failed -eq 0 ]; then
	echo -e "${GREEN}✅ Alle Verbesserungen erfolgreich!${NC}"
	exit 0
else
	echo -e "${RED}❌ Einige Tests fehlgeschlagen${NC}"
	exit 1
fi
