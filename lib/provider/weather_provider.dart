import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/data/request_weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherProvider =
    FutureProvider.autoDispose<AsyncValue<DataWeather?>>((ref) {
  final request =
      RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');

  try {
    final result = YumemiWeather().syncFetchWeather(request.toString());
    return AsyncValue.data(
      DataWeather.fromJson(
        jsonDecode(result) as Map<String, dynamic>,
      ),
    );
  } on Exception catch (_) {
    throw Exception('Failed to fetch weather data.');
  }
});
