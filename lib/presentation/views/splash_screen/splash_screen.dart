import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/home';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}