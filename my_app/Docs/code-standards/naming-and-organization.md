# Naming & Organization


File naming, class/variable naming, directory structure, and import organization.


## File & Naming Conventions


### Dart/Flutter Files
- **snake_case** for filenames: `home_screen.dart`, `authentication_cubit.dart`, `note_repository.dart`
- **PascalCase** for class names: `HomeScreen`, `AuthenticationCubit`, `NoteRepository`
- **camelCase** for variables/functions: `userName`, `fetchNotes()`, `isLoading`
- **lowerCamelCase** for local/top-level constants and **PascalCase** for constant holder classes: `defaultTimeout`, `StoreConfig`
- **camelCase** for enum values: `success`, `loading`, `failure`


**Example**:
```dart
// File: lib/features/home/presentation/screens/home_screen.dart
class HomeScreen extends StatelessWidget { ... }


const int defaultTimeout = 30;
final int maxRetries = 3;


enum HomeLoadingState { initial, loading, success, failure }
```


### Directory Structure


**Feature-First Architecture**:
```
lib/
├── features/{feature_name}/
│   ├── presentation/
│   │   ├── blocs/
│   │   │   └── {feature_name}_bloc/
│   │   │       ├── {feature_name}_bloc.dart
│   │   │       ├── {feature_name}_event.dart
│   │   │       └── {feature_name}_state.dart
│   │   ├── screens/
│   │   │   └── {feature_name}_screen.dart
│   │   ├── widgets/
│   │   │   └── {widget_name}.dart
│   │   └── constants/
│   │       └── {feature_name}_constants.dart
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── gql/
│   │       ├── queries/
│   │       └── mutations/
│   └── domain/
│       ├── entities/
│       └── repositories/
└── shared/
    ├── blocs/
    ├── services/
    ├── models/
    ├── widgets/
    └── i18n/
```


### BLoC & State Files


**Organization**:
- **BLoC file**: `{feature_name}_bloc.dart`
- **Event file**: `{feature_name}_event.dart`
- **State file**: `{feature_name}_state.dart`
- All three in `presentation/blocs/{feature_name}_bloc/` directory


**Example**:
```
lib/features/home/presentation/blocs/
└── home_bloc/
    ├── home_bloc.dart
    ├── home_event.dart
    └── home_state.dart
```


### Repository Pattern


**Two-File Structure**:
- **Interface**: `{feature_name}_repository.dart` in `domain/repositories/`
- **Implementation**: `{feature_name}_repository_impl.dart` in `data/repositories/`


**Example**:
```dart
// domain/repositories/note_repository.dart
abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> fetchNotes();
}


// data/repositories/note_repository_impl.dart
class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<Either<Failure, List<Note>>> fetchNotes() async { ... }
}
```


---


## Code Organization


### Import Order


**Strict order** (enforced by linting):
1. Dart imports (`dart:async`, `dart:ui`)
2. Package imports (`flutter`, `package:freezed_annotation`)
3. Relative imports (`../`, `../../`)


**Example**:
```dart
import 'dart:async';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


import '../../../core/error/failure.dart';
import '../../shared/models/note.dart';
```


### File Organization Pattern


**Typical file structure** (logic → UI):
```dart
// Imports


// Part files (for code generation)
part 'file.freezed.dart';
part 'file.g.dart';


// Constants
const int DEFAULT_SIZE = 100;


// Main class/function
class MyWidget extends StatelessWidget { ... }


// Helper functions (if any)
String _formatDate(DateTime date) { ... }
```


---


## Naming Guidelines


### Variables & Parameters


- Use descriptive names (avoid abbreviations)
- Avoid single-letter names except in loops
- Use `is`/`has` prefix for booleans


**Examples**:
```dart
// ❌ Bad
final n = 5;
final bool loading = false;
final String usr = 'john';


// ✅ Good
final int maxItems = 5;
final bool isLoading = false;
final String userName = 'john';
final bool hasPermission = true;
```


### Functions & Methods


- Use verb names for actions
- Use noun names for getters/query methods
- Keep names concise but clear


**Examples**:
```dart
// ✅ Good — verbs for actions
void openDialog() { ... }
Future<void> fetchNotes() { ... }
void clearCache() { ... }


// ✅ Good — nouns for getters
List<Note> get allNotes => _notes;
String get userDisplayName => user.name;
bool get isEmpty => items.length == 0;
```


### Classes & Types


- Use noun names
- Prefix mixins with descriptive word (`with_*`)
- Suffix abstract classes with base class if complex (`with...Mixin`)


**Examples**:
```dart
// ✅ Good
class NoteRepository { ... }
class UserViewModel { ... }
mixin SafeSubscriptionMixin { ... }
abstract class Failure { ... }
```


---


## File Size Guidelines


**Target: Keep files under 200 LOC** (for optimal context)


**When to split**:
- BLoC + Events + States → separate files (3 files)
- Large feature → split into multiple services
- Utility class with 10+ functions → create separate modules


**Example split**:
```
❌ note_service.dart (250 LOC) — too large
✅ Split into:
   ├── note_cache_service.dart (80 LOC)
   ├── note_sync_service.dart (90 LOC)
   └── note_export_service.dart (75 LOC)
```


---


## Module Organization


### Feature Modules


Each feature is **self-contained** with minimal cross-feature dependencies:


```
feature/
├── presentation/
│   └── [UI layer — screens, widgets, BLoCs]
├── data/
│   └── [Data layer — repositories, models, data sources]
└── domain/
    └── [Domain layer — entities, interfaces]
```


### Shared Modules


**Only use `shared/` for**:
- Global BLoCs (auth, app behavior)
- Cross-feature services (file storage, notifications)
- Shared models (user, note, etc.)
- Reusable widgets (buttons, dialogs)


**Avoid putting feature-specific code in shared/**


---


## Consistency Checklist


Before committing, verify:


- [ ] Filenames use snake_case
- [ ] Classes use PascalCase
- [ ] Variables/functions use camelCase
- [ ] Constants follow Dart lowerCamelCase/PascalCase convention
- [ ] Imports are ordered (dart → package → relative)
- [ ] Files stay under 200 LOC
- [ ] Directory structure follows feature-first pattern
- [ ] No hardcoded strings (use ARB for i18n)
- [ ] No magic numbers (use named constants)



