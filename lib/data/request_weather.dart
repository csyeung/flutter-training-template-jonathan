import 'package:json_annotation/json_annotation.dart';

part 'request_weather.g.dart';

@JsonSerializable()
class RequestWeather {
  RequestWeather({
    required this.area,
    required this.date,
  });

  factory RequestWeather.fromJson(Map<String, dynamic> json) =>
      _$RequestWeatherFromJson(json);

  final String area;
  final String date;

  Map<String, dynamic> toJson() => _$RequestWeatherToJson(this);

  @override
  String toString() => '{ "area": "$area", "date": "$date" }';
}
