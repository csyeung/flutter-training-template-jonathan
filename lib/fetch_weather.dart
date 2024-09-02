import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'simple_alert_dialog.dart';

mixin FetchWeather {
  String fetchWeather(BuildContext context) {
    final weather = YumemiWeather();
    late String condition;

    try {
      const jsonString = '''
{
    "area": "tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}''';

      condition = weather.fetchWeather(jsonString);
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
