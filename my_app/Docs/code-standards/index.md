# Code Standards & Conventions


Complete guide for maintaining code quality, consistency, and best practices in SORA Note.


## Contents


- **[Naming & Organization](./naming-and-organization.md)** — File naming, class naming, directory structure, import order
- **[Architecture Patterns](./architecture-patterns.md)** — DI, state management (BLoC), error handling, data models
- **[User Authentication System](./user-authentication-system.md)** — Token types, user type abstraction, feature gating, guest mode
- **[Code Quality](./code-quality.md)** — Style conventions, null safety, testing, documentation, linting
- **[Common Patterns](./common-patterns.md)** — Good practices vs anti-patterns, code examples, review checklist


## Quick Reference


### Naming Conventions
- **Files**: snake_case (`home_screen.dart`)
- **Classes**: PascalCase (`HomeScreen`)
- **Variables/Functions**: camelCase (`fetchNotes()`)
- **Constants**: lowerCamelCase or PascalCase per Dart/Flutter convention (`defaultTimeout`, `StoreConfig`)


### Key Rules
1. Explicit return types (no `dynamic`)
2. Single quotes for strings
3. Const constructors
4. Null-safe code
5. Either<Failure, T> error handling
6. Freezed + Injectable DI
7. > 70% test coverage


### Code Generation
```bash
flutter pub get  # also regenerates lib/shared/i18n/generated/ from ARB
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n  # optional after ARB edits if pub get was not run
```


See individual sections for detailed guidance.



