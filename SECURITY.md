# Security Guidelines für Ubertooth 2026-09-R1

## Sicherheitsverbesserungen in dieser Version

### 1. Compiler Security Flags
Alle Binaries werden mit folgenden Security-Flags kompiliert:
- **FORTIFY_SOURCE=2**: Stack-Smashing-Schutz
- **fstack-protector-strong**: Function-Prologue-Schutz
- **-Wall -Wextra -Werror**: Strikte Compiler-Warnungen
- **-fPIE**: Position-Independent Code

### 2. String-Function Sicherheit
**ALLE** unsicheren String-Funktionen wurden durch sichere Varianten ersetzt:
- ❌ `strcpy()` → ✅ `snprintf()`
- ❌ `strcat()` → ✅ `strncat()`
- ❌ `sprintf()` → ✅ `snprintf()`

### 3. Memory Safety
- Alle `malloc()`-Aufrufe prüfen NULL-Return
- Destructor-Pattern implementiert wo möglich
- Valgrind-Tests in CI/CD integriert

### 4. Code Analysis
Automatisierte Analysen in CI/CD:
- **cppcheck**: Static code analysis
- **clang-tidy**: LLVM-basierte Analyse
- **Semgrep**: OWASP Top 10 Patterns
- **valgrind**: Memory-Leak-Detection

## Sicherheits-Best-Practices

### Buffer Overflow Schutz
```c
// ❌ FALSCH
char buffer[100];
strcpy(buffer, user_input);  // Buffer Overflow!

// ✅ RICHTIG
char buffer[100];
snprintf(buffer, sizeof(buffer), "%s", user_input);
```

### NULL-Pointer Checking
```c
// ❌ FALSCH
void* ptr = malloc(size);
ptr->field = value;  // NULL-Crash möglich!

// ✅ RICHTIG
void* ptr = malloc(size);
if (!ptr) {
    perror("malloc failed");
    return -1;
}
ptr->field = value;
```

## Überprüfung ausführen

### cppcheck
```bash
cppcheck --enable=all --suppress=missingIncludeSystem host/
```

### clang-tidy
```bash
cd host
clang-tidy -p . host/ubertooth-tools/src/*.c
```

### valgrind
```bash
valgrind --leak-check=full ./ubertooth-tools/src/ubertooth-util
```

## Sicherheitslücken melden

Bitte Sicherheitslücken **NICHT** öffentlich auf GitHub melden.
Stattdessen: [security@ubertooth.io](mailto:security@ubertooth.io)

## Weitere Ressourcen
- OWASP Top 10: https://owasp.org/www-project-top-ten/
- CWE Top 25: https://cwe.mitre.org/top25/
- SEI CERT C: https://wiki.sei.cmu.edu/confluence/display/c/
