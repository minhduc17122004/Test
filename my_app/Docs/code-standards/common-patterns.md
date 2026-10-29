# Common Patterns & Anti-Patterns


Good practices vs anti-patterns with real examples and code review checklist.


## ✅ Good Practices


### Immutability


**Use freezed for immutable models**:
```dart
// ✅ Good — frozen, immutable
@freezed
class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String content,
  }) = _Note;
}


// ✅ Good — final fields (read-only)
class NoteBloc extends Bloc {
  final NoteRepository _repository;
  NoteBloc(this._repository);
}


// ✅ Good — const constructors
const widget = SizedBox(width: 100);
```


**Why**: Eliminates bugs from unintended mutations, enables hot reload, improves performance.


---


### Composition Over Inheritance


**Use mixins for reusable behavior**:
```dart
// ✅ Good — mixin for cross-cutting concerns
mixin SafeSubscriptionMixin on Bloc {
  final List<StreamSubscription> _subscriptions = [];


  Future<void> safeSubscribe(Stream stream, Function onData) async {
    _subscriptions.add(stream.listen(onData));
  }


  @override
  Future<void> close() async {
    for (final sub in _subscriptions) await sub.cancel();
    await super.close();
  }
}


class MyBloc extends Bloc with SafeSubscriptionMixin {
  // All subscriptions auto-cleaned
}
```


**Why**: Avoids deep inheritance hierarchies, enables multiple behavior mixing, cleaner code.


---


### Explicit Error Handling


**Use Either<Failure, T> pattern**:
```dart
// ✅ Good — explicit error types
Either<Failure, Note> fetchNote(String id);


// ✅ Good — handle all cases
result.fold(
  (failure) {
    logger.error('Failed: ${failure.message}');
    return null;
  },
  (note) {
    logger.info('Success: loaded note ${note.id}');
    return note;
  },
);
```


**Why**: No silent null errors, clear error communication, composable error handling.


---


### Single Responsibility


**Each class has one reason to change**:
```dart
// ✅ Good — separate concerns
class NoteRepository {
  Future<Either<Failure, Note>> fetchNote(String id) async { ... }
}


class NoteMapper {
  NoteEntity toEntity(NoteModel model) { ... }
}


class NoteBloc extends Bloc {
  // Only manages UI state, delegates data/mapping to repo/mapper
}
```


**Why**: Easier to test, maintain, and extend. Easy to understand responsibility.


---


### Dependency Injection


**Inject dependencies, don't create them**:
```dart
// ✅ Good — injected dependencies (testable)
@injectable
class NoteBloc extends Bloc {
  final NoteRepository _repository;
  NoteBloc(this._repository); // Injected
}


// ✅ Good — mock in tests
final mockRepository = MockNoteRepository();
final bloc = NoteBloc(mockRepository);
```


**Why**: Enables easy testing with mocks, decouples dependencies, supports multiple implementations.


---


### Constant Over Magic Numbers


**Use named constants**:
```dart
// ✅ Good — named constant (self-documenting)
const int MAX_RETRIES = 3;
const Duration REQUEST_TIMEOUT = Duration(seconds: 30);


Future<void> retry(Future Function() fn) async {
  for (int attempt = 0; attempt < MAX_RETRIES; attempt++) {
    try {
      return await fn().timeout(REQUEST_TIMEOUT);
    } catch (e) {
      if (attempt == MAX_RETRIES - 1) rethrow;
    }
  }
}


// ❌ Bad — magic numbers
for (int attempt = 0; attempt < 3; attempt++) {
  try {
    return await fn().timeout(const Duration(seconds: 30));
  } catch (e) {
    if (attempt == 2) rethrow;
  }
}
```


**Why**: Self-documenting, easy to change, prevents typos.


---


## ❌ Anti-Patterns to Avoid


### Nullable Return Types Without Reason


```dart
// ❌ Bad — what does null mean? Undefined behavior
Note? fetchNote() { ... }


// ✅ Good — explicit failure handling
Either<Failure, Note> fetchNote() { ... }


// ✅ Good — if null is a valid state, document it
Note? get cachedNote => _cache; // Returns null if cache empty
```


**Problem**: Ambiguous semantics, requires null checks everywhere, easy to miss.


---


### Global State Without DI


```dart
// ❌ Bad — hidden dependency, hard to test
static MyService _instance;
class MyService {
  static MyService get instance => _instance;
}


// Usage — unclear dependency
MyService.instance.doSomething();


// ✅ Good — injected, testable
@singleton
class MyService { ... }
final service = getIt<MyService>();
```


**Problem**: Hidden dependencies make code hard to understand, impossible to mock for tests.


---


### BLoC Listeners in BLoC Listeners


```dart
// ❌ Bad — nested listeners, memory leaks, hard to follow
on<MyEvent>((event, emit) {
  context.read<OtherBloc>().add(SomeEvent());
  emit(MyState());
});


// ✅ Good — emit state, let UI handle side effects
on<MyEvent>((event, emit) {
  emit(MyState.needsOtherAction());
});


// In UI:
BlocListener<MyBloc, MyState>(
  listenWhen: (prev, curr) => curr is NeedsOtherAction,
  listener: (context, state) {
    context.read<OtherBloc>().add(SomeEvent());
  },
)
```


**Problem**: Tight coupling, memory leaks, side effects hard to trace.


---


### Hardcoded Strings


```dart
// ❌ Bad — hardcoded, not translatable
Text('My Notes')
showSnackBar('Error loading notes')


// ✅ Good — from ARB via localization
Text(AppLocalizations.of(context).homeScreenTitle)
showSnackBar(AppLocalizations.of(context).errorLoadingNotes)
```


**Problem**: Not translatable, no single source of truth, duplicates across codebase.


---


### Mixing Layers


```dart
// ❌ Bad — presentation layer accessing data sources directly
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = NotesDataSource().fetchNotes(); // Mixing layers!
    return ListView(children: notes);
  }
}


// ✅ Good — clean separation
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => state.when(
        success: (notes) => ListView(children: notes),
        // ...
      ),
    );
  }
}
```


**Problem**: Hard to test, breaks separation of concerns, difficult to change.


---


### Ignoring Lint Warnings


```dart
// ❌ Bad — ignoring valid warnings
// ignore: avoid_empty_else
if (condition) {
} else {
  // Do nothing
}


// ✅ Good — fix the actual issue
if (condition) {
  doSomething();
}
```


**Problem**: Accumulates technical debt, makes code harder to maintain.


---


### Too Much Logic in Widgets


```dart
// ❌ Bad — business logic in widget
class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final note = Note(/* ... */);
        final result = await GraphQL().mutate(createNoteMutation);
        final mapped = _parseResponse(result);
        await _cache.save(mapped);
      },
      child: const Icon(Icons.add),
    );
  }
}


// ✅ Good — logic delegated to BLoC
class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<NoteBloc>().add(
        const NoteEvent.create(),
      ),
      child: const Icon(Icons.add),
    );
  }
}
```


**Problem**: Hard to test, reuse, or change behavior. Widget becomes too large.


---


### Type Unsafe Code


```dart
// ❌ Bad — dynamic (defeats type safety)
final data = json['notes'] as dynamic;
final notes = data.map((n) => Note.fromJson(n)).toList();


// ✅ Good — explicit types
final data = json['notes'] as List?;
final notes = (data ?? [])
    .whereType<Map<String, dynamic>>()
    .map((n) => Note.fromJson(n))
    .toList();
```


**Problem**: Runtime errors, IDE cannot help, defeats purpose of strong typing.


---


### Massive Files


```dart
// ❌ Bad — 500+ LOC in one file
// home_screen.dart — UI, logic, state management, helpers


// ✅ Good — modular files
// home_screen.dart (100 LOC) — UI only
// home_bloc.dart (80 LOC) — state management
// home_repository.dart (70 LOC) — data
// home_mapper.dart (40 LOC) — mapping logic
```


**Problem**: Hard to navigate, understand, test. Multiple responsibilities.


---


## Code Review Checklist


### Before Submitting MR


**Naming & Organization**:
- [ ] Filenames use snake_case
- [ ] Classes use PascalCase
- [ ] Variables/functions use camelCase
- [ ] Constants follow Dart lowerCamelCase/PascalCase convention
- [ ] Imports organized (dart → package → relative)
- [ ] Files under 200 LOC


**Code Quality**:
- [ ] All return types explicit (no `dynamic`)
- [ ] Const constructors used
- [ ] Null-safe code (no unnecessary optionals)
- [ ] Single quotes for strings
- [ ] No magic numbers (use constants)


**Architecture**:
- [ ] Error handling uses Either pattern
- [ ] BLoCs use freezed for states/events
- [ ] Repositories return Either<Failure, T>
- [ ] DI uses @injectable/@singleton annotations
- [ ] No mixing of layers (presentation/data/domain)
- [ ] Composition over inheritance


**Localization**:
- [ ] All UI strings in ARB files (no hardcoded text)
- [ ] No hardcoded colors/sizes


**Testing**:
- [ ] Tests added for new logic
- [ ] BLoC tests use bloc_test + mocktail
- [ ] Coverage target > 70%
- [ ] All tests passing


**Documentation**:
- [ ] Comments explain "why", not "what"
- [ ] Public APIs have doc comments
- [ ] No TODO comments (fix or remove)


**Code Style**:
- [ ] `flutter analyze` passes (zero high-severity)
- [ ] Code formatted: `dart format`
- [ ] No secrets/API keys in code
- [ ] No print() statements (use logger)


**Review Before Fix**:
- [ ] Review findings shared with team
- [ ] Team approval before making changes
- [ ] Fixes committed in new commit (not amended)


---


## Resources


- **Flutter Style Guide**: https://dart.dev/guides/language/style
- **flutter_lints**: https://pub.dev/packages/flutter_lints
- **BLoC Pattern**: https://bloclibrary.dev
- **Clean Architecture**: https://resocoder.com/flutter-clean-architecture



