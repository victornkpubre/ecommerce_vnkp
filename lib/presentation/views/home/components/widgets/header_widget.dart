
import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeader extends StatelessWidget{
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.blue[200],
                child: const Center(child: Text('Full Logo')),
              ),
              SvgPicture.asset(AppIcons.notification, height: 32, width: 32),
            ],
          ),
          Center(
            child: Column(
              children: [
                Text(AppString.address, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(AppString.state, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

}