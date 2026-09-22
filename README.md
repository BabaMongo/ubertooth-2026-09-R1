# Ubertooth 2026-09-R1 (Private Build by @BabaMongo)

> **⚠️ PRIVATE FORK** - This is a privately maintained fork of Ubertooth, updated and security-hardened by [@BabaMongo](https://github.com/BabaMongo) using Claude Code.

**Original Project:** [Ubertooth by Great Scott Gadgets](https://github.com/greatscottgadgets/ubertooth)

---

## What is Ubertooth?

Project Ubertooth is an open source wireless development platform suitable for Bluetooth experimentation. Ubertooth ships with a capable BLE (Bluetooth Smart) sniffer and can sniff some data from Basic Rate (BR) Bluetooth Classic connections.

---

## 🔒 What's New in This Build (2026-09-R1 by @BabaMongo)

### Security Hardening ✅
- **19+ Buffer-Overflow Fixes** - Replaced all unsafe `strcpy()` with `snprintf()`
- **Modern CMake** - Updated to CMake 3.10...3.28 with security flags
- **Security Compiler Flags:**
  - `-Wall -Wextra -Werror` (strict warnings)
  - `-Wformat=2 -Wshadow -Wstrict-prototypes -Wwrite-strings`
  - `-D_FORTIFY_SOURCE=2` (stack overflow protection)
  - `-fstack-protector-strong` (prologue protection)
  - `-fPIE` (position-independent executable)

### Code Quality 🧪
- **CI/CD Pipeline** - GitHub Actions integration
- **Code Analysis** - cppcheck + clang-tidy + Semgrep
- **Memory Checking** - valgrind integration
- **Documentation** - SECURITY.md + CONTRIBUTING.md

### Build Improvements 🛠️
- Fixed Python setup.py version issues
- 100% compilation success
- All 15 tools verified & working
- Better error handling

### Testing & Verification ✅
- 9/9 verification tests PASS
- Full security audit completed
- Memory leak detection enabled
- Static analysis integrated

---

## Installation

```bash
cd ubertooth-2026-09-R1/host
cmake . -DCMAKE_POLICY_VERSION_MINIMUM=3.10
make -j$(nproc)
sudo make install
```

### Verify Security

```bash
cd ubertooth-2026-09-R1
bash verify-improvements.sh
```

---

## Supported Hardware

- **Ubertooth One** - Current hardware (CC2400 + LPC1756)
- **Ubertooth Zero** - Superseded (legacy)

---

## 📚 Documentation

- [SECURITY.md](SECURITY.md) - Security guidelines and improvements
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute to this fork
- [IMPROVEMENTS_SUMMARY.txt](IMPROVEMENTS_SUMMARY.txt) - Detailed improvements
- [Original Project Wiki](https://github.com/greatscottgadgets/ubertooth/wiki)

---

## 🔗 Original Project

- **[Great Scott Gadgets Ubertooth](https://github.com/greatscottgadgets/ubertooth)** - Official project
- **[libbtbb 2026-09-R1](https://github.com/greatscottgadgets/libbtbb/releases/tag/2026-09-R1)** - Required library

---

## 👥 Credits

### Original Ubertooth Project
- Michael Ossmann
- Dominic Spill
- Mike Ryan
- Will Code
- Jared Boone
- Many others

### This Build (2026-09-R1 Private Fork)
- **@BabaMongo** - Security hardening, build improvements, CI/CD setup
- **Claude Code** - Code analysis, refactoring, documentation

### Tools & GUI Components
- **[Brunoido90](https://github.com/Brunoido90/ubertooth_hack)** - Original `ubertooth_tool.py` GUI implementation

---

## ⚠️ Disclaimer

This is a **PRIVATE FORK** maintained independently from the official Ubertooth project. 

For the official release, visit: https://github.com/greatscottgadgets/ubertooth

**Legal Notice:** Only use on YOUR OWN devices. Unauthorized Bluetooth monitoring is illegal in most jurisdictions.

---

## 📄 License

GNU General Public License v2.0 - See [COPYING](COPYING)

Based on the official Ubertooth project licensed under GPLv2.
