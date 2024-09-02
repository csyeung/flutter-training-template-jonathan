import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'simple_alert_dialog.dart';

mixin FetchWeather {
  String fetchWeather(BuildContext context) {
    final weather = YumemiWeather();
    late String condition;

    try {
      condition = weather.fetchThrowsWeather('tokyo');
    } on YumemiWeatherError catch (e) {
      condition = '';
      showDialog<void>(
        context: context,
        builder: (_) {
          return SimpleAlertDialog(message: e.name);
        },
      );
    }
    return condition;
  }
}
