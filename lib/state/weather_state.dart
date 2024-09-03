class WeatherState {
  WeatherState({
    required this.condition,
    required this.minWeather,
    required this.maxWeather,
  });

  final String condition;
  final int minWeather;
  final int maxWeather;
}
