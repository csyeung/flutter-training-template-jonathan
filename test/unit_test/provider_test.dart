import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/notifier/weather_notifier.dart';

import '../mock/mock_classes.dart';
import '../mock/mock_data.dart';

ProviderContainer _createContainer(bool hasError) {
  final container = ProviderContainer(
    overrides: [
      fetchWeatherProvider.overrideWith(
        (ref) => MockWeatherNotifier(
          hasError: false,
          resultJson: resultJson,
        ),
      ),
    ],
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  late MockBuildContext mockContext;

  setUp(() {
    mockContext = MockBuildContext();
  });

  group('notifier', () {
    test('notifier simple test (no error)', () async {
      final container = _createContainer(false);
      final notifier = container.read(fetchWeatherProvider.notifier);

      expect(notifier, isA<WeatherNotifier>());

      await notifier.fetchWeather(mockContext);

      container.listen<DataWeather?>(
        fetchWeatherProvider,
        (state, _) {
          expect(state, isA<DataWeather>());
          expect(state?.weatherCondition, 'cloudy');
          expect(state?.minTemperature, 20);
          expect(state?.maxTemperature, 20);
          expect(state?.requestDate, '2020-04-01T12:00:00+09:00');
        },
      );
    });

    test('notifier simple test (error)', () async {
      final container = _createContainer(true);
      final notifier = container.read(fetchWeatherProvider.notifier);

      expect(notifier, isA<WeatherNotifier>());

      await notifier.fetchWeather(mockContext);

      container.listen<DataWeather?>(
        fetchWeatherProvider,
        (state, _) {
          expect(state, isNull);
        },
      );
    });
  });
}
