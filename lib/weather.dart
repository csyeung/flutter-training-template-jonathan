import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/provider/weather_provider.dart';
import 'package:flutter_training/view/simple_error_view.dart';
import 'package:flutter_training/view/simple_loading_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/data_weather.dart';

class WeatherScreen extends HookConsumerWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(weatherProvider);

    return Scaffold(
      body: Center(
        child: provider.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return _WeatherScreenBody(
              data: data,
              onTap: () => ref.refresh(weatherProvider),
            );
          },
          error: (_, __) => SimpleErrorView(
            onTap: () => ref.refresh(weatherProvider),
          ),
          loading: () => const SimpleLoadingView(),
        ),
      ),
    );
  }
}

class _WeatherScreenBody extends ConsumerWidget {
  const _WeatherScreenBody({
    required this.data,
    required this.onTap,
  });

  final DataWeather? data;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
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
                child: (data != null)
                    ? SvgPicture.asset(
                        semanticsLabel: data!.weatherCondition,
                        '${'assets/${data!.weatherCondition}'}.svg',
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
                        (data == null) ? '** ℃' : '${data!.minTemperature} ℃',
                        textAlign: TextAlign.center,
                        style:
                            themeData.labelLarge!.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: FittedBox(
                      child: Text(
                        (data == null) ? '** ℃' : '${data!.maxTemperature} ℃',
                        textAlign: TextAlign.center,
                        style:
                            themeData.labelLarge!.copyWith(color: Colors.red),
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
                        style:
                            themeData.labelLarge!.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Reload',
                        textAlign: TextAlign.center,
                        style:
                            themeData.labelLarge!.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
