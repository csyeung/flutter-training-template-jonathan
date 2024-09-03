// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataWeather _$DataWeatherFromJson(Map<String, dynamic> json) => DataWeather(
      weatherCondition: json['weather_condition'] as String,
      minTemperature: (json['min_temperature'] as num).toInt(),
      maxTemperature: (json['max_temperature'] as num).toInt(),
      requestDate: json['date'] as String,
    );

Map<String, dynamic> _$DataWeatherToJson(DataWeather instance) =>
    <String, dynamic>{
      'weather_condition': instance.weatherCondition,
      'min_temperature': instance.minTemperature,
      'max_temperature': instance.maxTemperature,
      'date': instance.requestDate,
    };
