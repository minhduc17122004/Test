import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  testWidgets('renders the FOSO home page and switches navigation tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Trang chủ'), findsWidgets);
    expect(find.text('Flash sale'), findsOneWidget);
    expect(find.text('Dành Cho Bạn'), findsOneWidget);

    await tester.tap(find.text('Danh mục').first);
    await tester.pump();

    expect(find.text('Danh mục'), findsWidgets);
  });
}
