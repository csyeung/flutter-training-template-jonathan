import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'notifier/weather_notifier.dart';

class WeatherScreen extends HookConsumerWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(fetchWeatherProvider);

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
                    child: (weather == null)
                        ? const Placeholder(
                            color: Colors.black12,
                          )
                        : SvgPicture.asset(
                            width: width,
                            height: width,
                            'assets/${weather.weatherCondition}.svg',
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
                            (weather == null)
                                ? '** ℃'
                                : '${weather.minTemperature} ℃',
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
                            (weather == null)
                                ? '** ℃'
                                : '${weather.maxTemperature} ℃',
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
                          onTap: () {
                            ref
                                .read(fetchWeatherProvider.notifier)
                                .fetchWeather(context);
                          },
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
