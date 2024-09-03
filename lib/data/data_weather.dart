import 'package:json_annotation/json_annotation.dart';

part 'data_weather.g.dart';

@JsonSerializable()
class DataWeather {
  DataWeather({
    required this.weatherCondition,
    required this.minTemperature,
    required this.maxTemperature,
    required this.requestDate,
  });

  factory DataWeather.fromJson(Map<String, dynamic> json) =>
      _$DataWeatherFromJson(json);

  @JsonKey(name: 'weather_condition')
  final String weatherCondition;

  @JsonKey(name: 'min_temperature')
  final int minTemperature;

  @JsonKey(name: 'max_temperature')
  final int maxTemperature;

  @JsonKey(name: 'date')
  final String requestDate;

  Map<String, dynamic> toJson() => _$DataWeatherToJson(this);
}
