import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavIconWidget extends StatelessWidget {
  final String assetPath;
  final bool isActive;
  final double iconSize;
  final int? badgeCount; // null or 0 = no badge

  const BottomNavIconWidget({
    super.key,
    required this.assetPath,
    required this.isActive,
    required this.iconSize,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: isActive ? iconSize * 2 : null,
          decoration: isActive
              ? BoxDecoration(
            color: Colors.blue, // You can replace with AppColor.primaryColor
            borderRadius: BorderRadius.circular(iconSize / 2),
          )
              : null,
          child: SvgPicture.asset(
            assetPath,
            height: iconSize,
            width: iconSize,
            color: isActive ? Colors.white70 : Colors.black54,
          ),
        ),
        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                badgeCount! > 99 ? '99+' : badgeCount!.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
