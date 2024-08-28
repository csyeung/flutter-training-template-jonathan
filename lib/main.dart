import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  String condition = '';

  void getWeather() {
    final yumemi = YumemiWeather();

    setState(() {
      condition = yumemi.fetchSimpleWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                              '** ℃',
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
                              '** ℃',
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
                          child: Text(
                            'Close',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.blue),
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
      ),
    );
  }
}
