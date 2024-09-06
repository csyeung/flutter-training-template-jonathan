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
              child: weather.when(
                data: (data) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: width,
                          maxHeight: width,
                        ),
                        child: (data != null)
                            ? SvgPicture.asset(
                                '${'assets/${data.weatherCondition}'}.svg',
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
                                (data == null)
                                    ? '** ℃'
                                    : '${data.minTemperature} ℃',
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
                                (data == null)
                                    ? '** ℃'
                                    : '${data.maxTemperature} ℃',
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
                  );
                },
                error: (e, _) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog<void>(
                      context: context,
                      builder: (_) => SimpleAlertDialog(
                        message: e.toString(),
                        callback: () {
                          ref.invalidate(weatherProvider);
                        },
                      ),
                    );
                  });
                  return null;
                },
                loading: () => const CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
