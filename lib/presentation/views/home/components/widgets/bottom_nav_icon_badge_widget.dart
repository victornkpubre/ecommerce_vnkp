import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/cart_viewmodel/cart_bloc.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/bottom_nav_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconWithBadge extends StatelessWidget {
  final bool isActive;

  const CartIconWithBadge({this.isActive = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int count = state.cart.products.length;
        print("State: ${state.runtimeType} count: $count");

        return Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavIconWidget(
              assetPath: AppIcons.cart,
              isActive: isActive,
              iconSize: 32,
            ),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

