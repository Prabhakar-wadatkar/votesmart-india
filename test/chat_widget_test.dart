import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votesmart_india/features/chat/presentation/chat_screen.dart';
import 'package:votesmart_india/features/chat/providers/chat_provider.dart';
import 'package:votesmart_india/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:votesmart_india/core/providers/session_provider.dart';
import 'flow_test.dart';

void main() {
  testWidgets('ChatScreen should display empty state initially', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(FakeSharedPreferences()),
          firestoreServiceProvider.overrideWithValue(FakeFirestoreService()),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: ChatScreen(),
        ),
      ),
    );

    // Wait for localizations
    await tester.pumpAndSettle();

    // Initial state should show suggestions and input bar
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ActionChip), findsWidgets);
  });

  testWidgets('Chat input should update text and send message', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(FakeSharedPreferences()),
          firestoreServiceProvider.overrideWithValue(FakeFirestoreService()),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: ChatScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find the text field
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // Enter text
    await tester.enterText(textField, 'Hello!');
    await tester.pump();

    // Check if text was entered
    expect(find.text('Hello!'), findsOneWidget);

    // Find send button
    final sendButton = find.byIcon(Icons.send_rounded);
    expect(sendButton, findsOneWidget);

    // Tap send
    await tester.tap(sendButton);
    // Pump multiple times to ensure the build cycle completes
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // The text field should be cleared
    final inputField = tester.widget<TextField>(find.byType(TextField));
    expect(inputField.controller?.text, '');
  });
}
