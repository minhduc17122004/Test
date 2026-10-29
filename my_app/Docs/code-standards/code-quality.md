# Code Quality & Best Practices


Style conventions, null safety, testing strategies, documentation, and linting.


## Code Style Conventions


### Prefer Single Quotes


Use single quotes for strings unless escaping is needed:


```dart
// ✅ Good
final String name = 'John Doe';
final String message = 'It\'s a beautiful day';


// ❌ Avoid
final String name = "John Doe";
```


### String Interpolation


Use interpolation instead of concatenation:


```dart
// ✅ Good
final String greeting = 'Hello, $name!';
final String details = 'User: ${user.name} (${user.email})';


// ❌ Avoid
final String greeting = 'Hello, ' + name + '!';
final String details = 'User: ' + user.name + ' (' + user.email + ')';
```


### Explicit Return Types


Always declare return types for functions (no implicit `dynamic`):


```dart
// ❌ Bad
Future fetchNotes() async { ... }
List getUsers() { ... }
processData() { ... }


// ✅ Good
Future<List<Note>> fetchNotes() async { ... }
List<User> getUsers() { ... }
void processData() { ... }
```


### Const Keywords


Use `const` for compile-time constants and immutable objects:


```dart
// ✅ Good
const int defaultTimeout = 30;
const List<String> supportedLanguages = ['en', 'vi', 'th'];
final widget = const SizedBox(width: 100);


// ❌ Avoid
final int defaultTimeout = 30;
final List<String> supportedLanguages = ['en', 'vi', 'th'];
final widget = SizedBox(width: 100);
```


---


## Null Safety


### Avoid Nullable Types When Possible


```dart
// ❌ Bad — nullable when not needed
String? name;
int? count = 0;


// ✅ Good — explicit non-nullable
final String name = 'John';
final int count = 0;
```


### Use Late Keyword


For variables initialized after declaration but guaranteed before use:


```dart
// ✅ Good — late initialization, guaranteed before use
late String userName;


void initialize() {
  userName = 'John'; // Must initialize before using
}


void printName() {
  print(userName); // Safe because initialized in initialize()
}
```


### Null Coalescing & Optional Access


```dart
// ✅ Good — use ?? for fallback
final String displayName = nickname ?? name;
final int? length = list?.length;


// ❌ Bad — verbose
final String displayName = nickname == null ? name : nickname;
final int? length = list == null ? null : list.length;
```


### Early Returns to Reduce Nesting


```dart
// ✅ Good — early return, clear flow
Future<Result> process(String? input) async {
  if (input == null || input.isEmpty) {
    return Result.empty();
  }


  final processed = await _process(input);
  if (processed == null) {
    return Result.error('Processing failed');
  }


  return Result.success(processed);
}


// ❌ Bad — nested ifs
Future<Result> process(String? input) async {
  if (input != null && input.isNotEmpty) {
    final processed = await _process(input);
    if (processed != null) {
      return Result.success(processed);
    } else {
      return Result.error('Processing failed');
    }
  } else {
    return Result.empty();
  }
}
```


---


## Testing Standards


### BLoC Testing with bloc_test


```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNoteRepository extends Mock implements NoteRepository {}


void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockNoteRepository mockRepository;


    setUp(() {
      mockRepository = MockNoteRepository();
      homeBloc = HomeBloc(mockRepository);
    });


    tearDown(() => homeBloc.close());


    group('FetchNotes', () {
      final notes = [
        const NoteEntity(
          id: '1',
          title: 'Test Note',
          content: 'Test content',
          createdAt: null,
          updatedAt: null,
        ),
      ];


      blocTest<HomeBloc, HomeState>(
        'emits [Loading, Success] when fetch succeeds',
        setUp: () {
          when(() => mockRepository.fetchNotes())
              .thenAnswer((_) async => Right(notes));
        },
        build: () => homeBloc,
        act: (bloc) => bloc.add(const HomeEvent.fetchNotes()),
        expect: () => [
          const HomeState.loading(),
          HomeState.success(notes),
        ],
      );


      blocTest<HomeBloc, HomeState>(
        'emits [Loading, Failure] when fetch fails',
        setUp: () {
          when(() => mockRepository.fetchNotes()).thenAnswer(
            (_) async => Left(NetworkFailure('No internet')),
          );
        },
        build: () => homeBloc,
        act: (bloc) => bloc.add(const HomeEvent.fetchNotes()),
        expect: () => [
          const HomeState.loading(),
          isA<_Failure>(),
        ],
      );
    });
  });
}
```


### Running Tests


```bash
# All tests
flutter test


# Single file
flutter test test/home_bloc_test.dart


# With coverage
flutter test --coverage


# Watch mode
flutter test --watch
```


### Coverage Targets


| Layer | Target | Purpose |
|-------|--------|---------|
| **Critical paths** | > 80% | BLoCs, repositories, models |
| **UI layer** | > 50% | Widgets, screens |
| **Overall** | > 70% | Full project |


---


## Documentation


### Inline Comments


Use sparingly for non-obvious logic (explain "why", not "what"):


```dart
// ✅ Good — explains why
// Cache regex patterns to avoid recompilation on every search.
// This LRU cache with max 50 entries reduces CPU usage by ~40%.
final _regexCache = LRUCache<String, RegExp>(maxSize: 50);


// ❌ Bad — explains obvious what
// Create a new regex cache
final _regexCache = LRUCache<String, RegExp>(maxSize: 50);
```


### Public API Documentation


```dart
/// Fetches notes from the remote API with optional pagination.
///
/// Returns an Either containing:
/// - Left: [Failure] on error (NetworkFailure, TimeoutFailure, etc.)
/// - Right: List of [NoteEntity] on success
///
/// Parameters:
///   - [limit]: Max number of notes per page (default: 50)
///   - [nextToken]: Pagination token for fetching next page
///
/// Example:
/// ```dart
/// final result = await repository.fetchNotes(limit: 50);
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (notes) => print('Fetched ${notes.length} notes'),
/// );
/// ```
///
/// Throws: [GraphQLException] on severe GraphQL errors
Future<Either<Failure, List<NoteEntity>>> fetchNotes({
  required int limit,
  String? nextToken,
});
```


### README for Large Features


For complex features (> 200 LOC), create `lib/features/{feature}/README.md`:
- Architecture overview
- Key state flows
- Integration points
- Testing strategy


---


## Linting & Formatting


### flutter_lints Configuration


Enable in `analysis_options.yaml`:


```yaml
linter:
  rules:
    - avoid_empty_else
    - avoid_print
    - avoid_returning_null_for_future
    - cancel_subscriptions
    - close_sinks
    - hash_and_equals
    - invariant_booleans
    - literal_only_boolean_expressions
    - no_adjacent_strings_in_list
    - no_duplicate_case_values
    - prefer_void_to_null
    - unrelated_type_equality_checks


analyzer:
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false


  errors:
    missing_required_param: error
    missing_return: error
    todo: ignore
```


### Running Linter


```bash
flutter analyze
```


### Formatting Code


```bash
# Format all Dart files
dart format lib/ test/


# Check formatting without fixing
dart format --output=none --set-exit-if-changed lib/
```


### Pre-Commit Hook


Add to `.git/hooks/pre-commit`:
```bash
#!/bin/bash
dart format --output=none --set-exit-if-changed lib/ test/ || exit 1
flutter analyze || exit 1
```


---


## Performance Considerations


### Hot Reload Compatibility


- Avoid `static` variables (reset on reload)
- Prefer const constructors
- Use BLoCs for mutable state, not global variables


### Memory Management


```dart
// ✅ Good — dispose resources in close()
@override
Future<void> close() async {
  await _streamSubscription.cancel();
  await super.close();
}


// ✅ Good — use mixin for auto-disposal
class MyBloc extends Bloc with SafeSubscriptionMixin {
  // Subscriptions auto-cleaned up on close()
}
```


### Rebuild Optimization


```dart
// ✅ Good — filter unnecessary rebuilds
BlocBuilder<MyBloc, MyState>(
  buildWhen: (previous, current) =>
    previous.items != current.items, // Only rebuild if items changed
  builder: (context, state) {
    return ListView(children: state.items);
  },
);


// ✅ Good — use const constructors
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 100);
  }
}
```


---


## Security Best Practices


### API Keys & Secrets


- Never hardcode API keys in code
- Use `.env` files (gitignored) for local development
- Use `--dart-define` for CI/CD builds


```bash
# Build with secrets
flutter run --dart-define=API_KEY=xxx --dart-define=FLAVOR=production
```


### Input Validation


```dart
// ✅ Good — validate all user input
if (email.isEmpty || !_validateEmail(email)) {
  return Left(ValidationFailure('Invalid email'));
}


// ✅ Good — escape special chars for regex
final escapedQuery = RegExp.escape(userInput);
final pattern = RegExp(escapedQuery);
```


### HTTPS Only


```dart
// ✅ Good — GraphQL uses HTTPS by default
final httpLink = HttpLink('https://api.example.com/graphql');


// ✅ Good — Dio with HTTPS enforcement
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  validateStatus: (status) => status != null && status < 500,
));
```


---


## Code Review Checklist


Before submitting PR, verify:


- [ ] All return types explicit (no `dynamic`)
- [ ] Imports organized (dart → package → relative)
- [ ] Const constructors used
- [ ] Null-safe code (no unnecessary optionals)
- [ ] Error handling uses Either pattern
- [ ] BLoCs use freezed for states/events
- [ ] Repositories return Either<Failure, T>
- [ ] All strings localized (in ARB)
- [ ] No hardcoded colors/sizes/strings
- [ ] `flutter analyze` passes (zero high-severity warnings)
- [ ] Tests added (target > 70% coverage)
- [ ] Code formatted: `dart format`
- [ ] No secrets/API keys in code
- [ ] Files under 200 LOC
- [ ] Comments explain "why", not "what"



