import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
                      child: const Placeholder(
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
                          child: Text(
                            'Reload',
                            textAlign: TextAlign.center,
                            style: themeData.labelLarge!
                                .copyWith(color: Colors.blue),
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
