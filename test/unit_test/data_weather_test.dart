import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/data/request_weather.dart';
import '../mock/mock_data.dart';

void main() {
  group('data', () {
    test('Data Weather (to JSON)', () {
      final data = DataWeather(
        requestDate: '2020-04-01T12:00:00+09:00',
        weatherCondition: 'cloudy',
        minTemperature: 20,
        maxTemperature: 20,
      );

      expect(data.toJson(), resultJson);
    });

    test('Data Weather (from JSON)', () {
      final data = DataWeather.fromJson(resultJson);

      expect(data.requestDate, '2020-04-01T12:00:00+09:00');
      expect(data.weatherCondition, 'cloudy');
      expect(data.minTemperature, 20);
      expect(data.maxTemperature, 20);
    });

    test('Data Response', () {
      final data =
          RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');
      const result = '{ "area": "tokyo", "date": "2020-04-01T12:00:00+09:00" }';

      expect(data.toString(), result);
    });
  });
}
