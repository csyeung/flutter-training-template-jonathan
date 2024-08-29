import 'package:flutter/material.dart';
import 'weather.dart';

mixin NavigateWeather<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        if (mounted) {
          await Navigator.push(
            context,
            MaterialPageRoute<WeatherScreen>(
              builder: (context) => const WeatherScreen(),
            ),
          );
        }
      });
    });
  }
}
