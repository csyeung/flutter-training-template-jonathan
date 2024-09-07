import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import '../data/data_weather.dart';
import '../data/request_weather.dart';
import '../view/simple_alert_dialog.dart';

final fetchWeatherProvider =
    StateNotifierProvider<WeatherNotifier, DataWeather?>((ref) {
  return WeatherNotifier();
});

class WeatherNotifier extends StateNotifier<DataWeather?> {
  WeatherNotifier() : super(null);

  Future<void> fetchWeather(BuildContext context) async {
    final weather = YumemiWeather();
    final request =
        RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');

    try {
      final result = weather.fetchWeather(request.toString());
      final condition = DataWeather.fromJson(
        jsonDecode(result) as Map<String, dynamic>,
      );

      state = condition;
    } on YumemiWeatherError catch (e) {
      await showDialog<void>(
        context: context,
        builder: (_) {
          return SimpleAlertDialog(message: e.name, callback: () {});
        },
      );
    }
  }
}
