import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_weather.dart';
import 'package:flutter_training/data/request_weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherProvider = FutureProvider<DataWeather?>((ref) async {
  final weather = YumemiWeather();
  final request =
      RequestWeather(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');

  await Future.delayed(const Duration(seconds: 2), () {
    // Do nothing
  });

  try {
    final result = weather.syncFetchWeather(request.toString());
    return DataWeather.fromJson(
      jsonDecode(result) as Map<String, dynamic>,
    );
  } on Exception catch (_) {
    return null;
  }
});

final weatherConditionProvider = Provider.autoDispose<String?>(
  (ref) => ref.watch(weatherProvider).valueOrNull?.weatherCondition,
);

final minTemperatureProvider = Provider.autoDispose<int?>(
  (ref) => ref.watch(weatherProvider).valueOrNull?.minTemperature,
);

final maxTemperatureProvider = Provider.autoDispose<int?>(
  (ref) => ref.watch(weatherProvider).valueOrNull?.maxTemperature,
);
