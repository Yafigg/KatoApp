import 'package:flutter_test/flutter_test.dart';
import 'package:katoapp/main.dart';

void main() {
  testWidgets('Kato App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KatoApp());

    // Verify that the app starts with splash screen
    expect(find.text('Kato App'), findsOneWidget);
    expect(find.text('Sistem Digitalisasi Supply Chain'), findsOneWidget);
  });
}
