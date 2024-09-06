import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/provider/weather_provider.dart';
import 'package:flutter_training/simple_alert_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherScreen extends HookConsumerWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    final condition = ref.watch(weatherConditionProvider);
    final minTemperature = ref.watch(minTemperatureProvider);
    final maxTemperature = ref.watch(maxTemperatureProvider);

    return RefreshIndicator(
      onRefresh: () =>
          ref.refresh(weatherProvider as Refreshable<Future<void>>),
      child: Scaffold(
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
                      child: weather.when(
                        data: (data) {
                          return null;
                        },
                        error: (e, _) {
                          return const SimpleAlertDialog(
                            message: 'Failed to fetch weather data.',
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: width,
                        maxHeight: width,
                      ),
                      child: (condition != null)
                          ? SvgPicture.asset(
                              '${'assets/$condition'}.svg',
                              width: width,
                              height: width,
                            )
                          : const Placeholder(
                              color: Colors.black12,
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
                              (minTemperature == null)
                                  ? '** ℃'
                                  : '$minTemperature ℃',
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
                              (maxTemperature == null)
                                  ? '** ℃'
                                  : '$maxTemperature ℃',
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
                              ref.invalidate(weatherProvider);
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
      ),
    );
  }
}
