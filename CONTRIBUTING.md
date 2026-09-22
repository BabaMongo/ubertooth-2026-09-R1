# Contributing to Ubertooth

Danke dass du zu Ubertooth 2026-09-R1 beiträgt! 🎉

## Code-Standards

### Security
- **KEINE** `strcpy()`, `strcat()`, `sprintf()` - verwende `snprintf()`, `strncat()`
- Alle `malloc()`-Aufrufe müssen NULL-Checks haben
- Compile mit: `-Wall -Wextra -Werror`
- Memory-Leaks sind nicht acceptable

### Style
- Tabs für Einrückung (4 Spaces = 1 Tab)
- Max 100 Zeichen pro Zeile
- K&R Brace Style
- Aussagekräftige Variablennamen

```c
// ✅ RICHTIG
int function_name(int parameter)
{
	char buffer[100];
	if (condition) {
		do_something();
	}
	return 0;
}

// ❌ FALSCH
int functionName(int p){
	char buf[100];
	strcpy(buf, input);  // SICHERHEITSLÜCKE!
	return 0;
}
```

### Memory Management
```c
// ✅ Cleanup Pattern
char* data = malloc(size);
if (!data) {
	perror("malloc");
	goto error;
}

// use data...

free(data);
return 0;

error:
	free(data);
	return -1;
```

## Vor dem Commit

1. **Build testen**
   ```bash
   cd host
   make clean
   make -j4
   ```

2. **Security Checks**
   ```bash
   make -f Makefile.security security-check
   ```

3. **Memory Check**
   ```bash
   make -f Makefile.security valgrind-check
   ```

4. **Code formatieren**
   ```bash
   make -f Makefile.security format-fix
   ```

## Pull Request Prozess

1. Fork das Repository
2. Erstelle einen Feature Branch: `git checkout -b feature/deine-feature`
3. Committe mit aussagekräftigen Messages:
   ```
   [SECURITY] Fix strcpy buffer overflow in xyz.c
   
   - Replaced strcpy with snprintf
   - Added buffer bounds checking
   - Verified with valgrind
   ```
4. Pushe zu deinem Fork
5. Erstelle einen Pull Request mit:
   - Description der Änderungen
   - Begründung
   - Ergebnis von Security-Checks

## Sicherheits-Lücken melden

**BITTE NICHT** auf GitHub reportieren!

Sende Email an: security@ubertooth.io
- Beschreibe die Lücke
- Provide Reproduktionsschritte
- Gib time zum Fixen bevor du public disclosure machst (90 Tage)

## Fragen?

- GitHub Issues für Feature Requests
- GitHub Discussions für Fragen
- Email: info@ubertooth.io

Danke! 🚀
