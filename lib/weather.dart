import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'fetch_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> with FetchWeather {
  String condition = '';
  int? minWeather;
  int? maxWeather;

  void getWeather() {
    setState(() {
      final baseData = fetchWeather(context);
      final weatherData = jsonDecode(baseData);

      // ignore: avoid_dynamic_calls
      condition = weatherData['weather_condition'] as String;
      // ignore: avoid_dynamic_calls
      minWeather = weatherData['min_temperature'] as int;
      // ignore: avoid_dynamic_calls
      maxWeather = weatherData['max_temperature'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth * 0.5;
            final themeData = Theme.of(context).textTheme;

            return Container(
              constraints: BoxConstraints(
                maxWidth: width,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: width,
                      maxHeight: width,
                    ),
                    child: (condition == '')
                        ? const Placeholder(
                            color: Colors.black12,
                          )
                        : SvgPicture.asset(
                            width: width,
                            height: width,
                            'assets/$condition.svg',
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: FittedBox(
                          child: Text(
                            (minWeather == null) ? '** ℃' : '$minWeather ℃',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: FittedBox(
                          child: Text(
                            (maxWeather == null) ? '** ℃' : '$maxWeather ℃',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: GestureDetector(
                          onTap: getWeather,
                          child: Text(
                            'Reload',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
