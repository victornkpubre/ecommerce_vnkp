import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String message;

  const ErrorWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}