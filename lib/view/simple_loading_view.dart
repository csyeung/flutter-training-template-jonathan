import 'package:flutter/material.dart';

class SimpleLoadingView extends StatelessWidget {
  const SimpleLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
