import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/notifier/weather_notifier.dart';
import 'package:flutter_training/weather.dart';
import '../mock/mock_classes.dart';
import '../mock/mock_data.dart';

void main() {
  testWidgets('Initial Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MainApp(),
        ),
      ),
    );

    await tester.pump(
      const Duration(seconds: 10),
    );
  });

  testWidgets('Test Weather Widget (Initial)', (WidgetTester tester) async {
    final container = UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const MaterialApp(home: WeatherScreen()),
    );

    // Test setup
    await tester.pumpWidget(container);

    // Test verification
    expect(find.byType(Placeholder), findsOneWidget);
    expect(find.text('** ℃'), findsNWidgets(2));

    // Test teardown
    container.container.dispose();
  });

  testWidgets(
    'Test Weather Widget (Cloudy)',
    (WidgetTester tester) async {},
  );

  testWidgets(
    'Test Weather Widget (Sunny & min temperatuee)',
    (WidgetTester tester) async {},
  );

  testWidgets(
    'Test Weather Widget (Rainy && max temperature)',
    (WidgetTester tester) async {},
  );

  testWidgets(
    'Test Weather Widget (Cloudy)',
    (WidgetTester tester) async {},
  );

  testWidgets(
    'Test Weather Widget (Cloudy)',
    (WidgetTester tester) async {},
  );
}

UncontrolledProviderScope _createProviderScope(
  MockWeatherNotifier mockWeatherNotifier,
) {
  return UncontrolledProviderScope(
    container: ProviderContainer(),
    child: const MaterialApp(home: WeatherScreen()),
  );
}
