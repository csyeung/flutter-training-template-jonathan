// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestWeather _$RequestWeatherFromJson(Map<String, dynamic> json) =>
    RequestWeather(
      area: json['area'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$RequestWeatherToJson(RequestWeather instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date,
    };
