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

### GUI Tool (ubertooth_tool.py) 🎨
- **Internationalization (i18n)** - Full support for German & English with live language switching
- **Dynamic Language Packs** - Auto-load language JSON files from `langs/` directory
- **Complete Tool Integration** - GUI control for all 15 Ubertooth tools
- **Command Preview** - Real-time command line preview before execution
- **Auto-Stop Timer** - Configurable timeout for long-running operations
- **Detached Mode** - Background execution for GUI-external tools (Wireshark, etc.)
- **Wireshark Integration** - Live FIFO pipe for real-time packet analysis
- **Radio Auto-Reset** - Automatic reset after tool execution
- **Log Export** - Save execution logs to file
- **Command Copy** - Copy generated commands to clipboard
- **Comprehensive Error Handling** - Missing tool detection and user-friendly messages

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

## Usage: Ubertooth GUI Tool

### Launch the GUI

```bash
sudo python3 ubertooth_tool.py
```

### Features

**6 Tab-Based Control:**
1. **Device & Radio** - Device info, firmware, channel/PA settings, LED control
2. **BLE Sniffing** - Follow capture, promiscuous mode, advertising scan, faux-slave injection
3. **Classic BR/EDR** - Survey mode, piconet following, AFH mapping, active scans
4. **Spectrum & Raw Data** - Spectrum sweep, 3D visualization, raw bitstream dumps, register debugging
5. **Firmware** - Write/read firmware, DFU operations, binary suffix management
6. **Analysis & Workflow** - crackle integration, Wireshark live pipe, pcap analysis

**Language Support:**
- Built-in: Deutsch (German), English
- Load custom language packs: Button "Pack laden…" or auto-load from `langs/` folder
- Live language switching without restart

**Advanced Features:**
- Copy any command to clipboard for manual execution
- Auto-stop timeout configuration per command
- Device index selection for multiple Ubertooth devices
- Radio auto-reset after operations
- Export full logs to `.log` files

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
