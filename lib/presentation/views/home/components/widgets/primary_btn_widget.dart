import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onTap;

  const PrimaryButtonWidget({super.key, required this.color, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text(
              text,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
      ),
    );
  }
}
