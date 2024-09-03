import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import '../data/data_weather.dart';
import '../data/request_weather.dart';
import '../simple_alert_dialog.dart';

mixin FetchWeather {
  DataWeather? fetchWeather(BuildContext context) {
    final weather = YumemiWeather();
    final request =
        RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');

    try {
      final result = weather.fetchWeather(request.toString());
      final condition = DataWeather.fromJson(
        jsonDecode(result) as Map<String, dynamic>,
      );

      return condition;
    } on YumemiWeatherError catch (e) {
      showDialog<void>(
        context: context,
        builder: (_) {
          return SimpleAlertDialog(message: e.name);
        },
      );

      return null;
    }
  }
}
