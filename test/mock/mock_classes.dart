import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/notifier/weather_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MockWeatherNotifier extends Mock implements WeatherNotifier {
  MockWeatherNotifier({
    required this.hasError,
    required this.resultJson,
  }) : super();

  final bool hasError;
  final Map<String, dynamic> resultJson;

  @override
  Future<void> fetchWeather(BuildContext context) async {
    final weather = MockYumemiWeather(
      hasError: hasError,
      resultJson: resultJson,
    );
    final result = weather.fetchWeather('');

    if (!hasError) {
      state = DataWeather.fromJson(
        jsonDecode(result) as Map<String, dynamic>,
      );
    }
  }
}

class MockBuildContext extends Mock implements BuildContext {}

class MockYumemiWeather extends Mock implements YumemiWeather {
  MockYumemiWeather({
    required this.hasError,
    required this.resultJson,
  }) : super();

  final bool hasError;
  final Map<String, dynamic> resultJson;

  @override
  String fetchWeather(String request) {
    if (hasError) {
      return '';
    }

    return jsonEncode(resultJson);
  }
}
