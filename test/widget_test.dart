import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zaika_app/components/choose_user_widget.dart';
import 'package:zaika_app/components/splash_screen.dart';

void main() {
  testWidgets('SplashScreen displays correctly and navigates', (WidgetTester tester) async {
    // Build the app starting with SplashScreen
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    // Verify logo is present
    expect(find.byType(Image), findsNWidgets(2)); // zaika_logo + zaika_text

    // Verify tagline is present
    expect(find.text("DESI ZAIKA. MODERN TADKA"), findsOneWidget);

    // Wait 2 seconds for navigation
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle(); // complete all animations and navigation

    // Verify that we navigated to ChooseUserWidget
    expect(find.byType(ChooseUserWidget), findsOneWidget);

    // Verify buttons exist
    expect(find.widgetWithText(ElevatedButton, 'Admin'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Users'), findsOneWidget);
  });

  testWidgets('Admin and Users buttons can be tapped', (WidgetTester tester) async {
    // Start directly on ChooseUserWidget
    await tester.pumpWidget(const MaterialApp(home: ChooseUserWidget()));
    await tester.pumpAndSettle();

    // Tap Admin button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Admin'));
    await tester.pump();

    // Tap Users button
    await tester.tap(find.widgetWithText(OutlinedButton, 'Users'));
    await tester.pump();

    // Buttons exist and tappable
    expect(find.widgetWithText(ElevatedButton, 'Admin'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Users'), findsOneWidget);
  });
}
