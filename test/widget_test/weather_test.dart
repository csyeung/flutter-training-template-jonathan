import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/provider/weather_provider.dart';
import 'package:flutter_training/weather.dart';
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

  testWidgets('Test Weather Widget (Nothing)', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        weatherProvider
            .overrideWith((ref) async => const AsyncValue.data(null)),
      ],
    );

    final widget = UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: WeatherScreen()),
    );

    // Test setup
    await tester.pumpWidget(widget);

    // Test verification
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Placeholder), findsNothing);
    expect(find.byType(Text), findsNothing);

    // Test teardown
    container.dispose();
  });

  final cloudyPictureFinder = find.byWidgetPredicate(
    (widget) => widget is SvgPicture && widget.semanticsLabel == 'cloudy',
  );

  testWidgets('Test Weather Widget (Cloudy)', (WidgetTester tester) async {
    // Test setup
    final widget = _createProviderScope(DataWeather.fromJson(resultJson));
    await tester.pumpWidget(widget);

    // Test verification
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(cloudyPictureFinder, findsOneWidget);
    expect(find.text('21 ℃'), findsOneWidget);
  });

  final sunnyPictureFinder = find.byWidgetPredicate(
    (widget) => widget is SvgPicture && widget.semanticsLabel == 'sunny',
  );

  testWidgets(
    'Test Weather Widget (Sunny & min temperatuee)',
    (WidgetTester tester) async {
      // Test setup
      final widget =
          _createProviderScope(DataWeather.fromJson(resultJsonSunny));
      await tester.pumpWidget(widget);

      // Test verification
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(sunnyPictureFinder, findsOneWidget);
      expect(find.text('10 ℃'), findsOneWidget);
    },
  );

  final rainyPictureFinder = find.byWidgetPredicate(
    (widget) => widget is SvgPicture && widget.semanticsLabel == 'rainy',
  );

  testWidgets(
    'Test Weather Widget (Rainy && max temperature)',
    (WidgetTester tester) async {
      // Test setup
      final widget =
          _createProviderScope(DataWeather.fromJson(resultJsonRainy));
      await tester.pumpWidget(widget);

      // Test verification
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(rainyPictureFinder, findsOneWidget);
      expect(find.text('25 ℃'), findsOneWidget);
    },
  );

  testWidgets('Test Weather Widget (Empty)', (WidgetTester tester) async {
    // Test setup
    final widget = _createProviderScope(null);
    await tester.pumpWidget(widget);

    // Test verification
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(Placeholder), findsOneWidget);
    expect(find.text('** ℃'), findsExactly(2));
    expect(find.text('Close'), findsOneWidget);
  });

  testWidgets('Test Weather Widget (Error)', (WidgetTester tester) async {
    final widget = ProviderScope(
      overrides: [
        weatherProvider.overrideWith(
          (ref) async => Future.error(
            Exception.new,
            StackTrace.empty,
          ),
        ),
      ],
      child: const MaterialApp(home: WeatherScreen()),
    );

    // Test setup
    await tester.pumpWidget(widget);

    // Test verification
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('エラーが発生しました'), findsOneWidget);
    expect(find.text('Reload'), findsOneWidget);
  });
}

ProviderScope _createProviderScope(DataWeather? mockDataWeather) {
  return ProviderScope(
    overrides: [
      weatherProvider.overrideWith(
        (ref) async => AsyncValue.data(mockDataWeather),
      ),
    ],
    child: const MaterialApp(home: WeatherScreen()),
  );
}
