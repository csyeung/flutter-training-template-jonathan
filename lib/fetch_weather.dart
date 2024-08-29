import 'package:yumemi_weather/yumemi_weather.dart';

mixin FetchWeather {
  String fetchWeather() {
    return YumemiWeather().fetchSimpleWeather();
  }
}
