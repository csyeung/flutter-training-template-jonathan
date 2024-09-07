import 'dart:convert';
import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/data/request_weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherProvider = FutureProvider.autoDispose<DataWeather?>((ref) async {
  final request =
      RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');

  final result = await Isolate.run(
    () => YumemiWeather().syncFetchWeather(request.toString()),
  );

  return DataWeather.fromJson(
    jsonDecode(result) as Map<String, dynamic>,
  );
});
