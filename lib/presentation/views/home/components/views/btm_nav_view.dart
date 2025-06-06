import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/app/routes.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/bottom_nav_icon_badge_widget.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/bottom_nav_icon_widget.dart';
import 'package:flutter/material.dart';

class BottomNavView extends StatefulWidget {
  final BottomNavViewModel viewModel;
  final int? initialIndex;
  final int cartItemCount;

  const BottomNavView({
    super.key,
    required this.viewModel,
    this.initialIndex,
    this.cartItemCount = 0,
  });

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  static const double iconSize = 32;

  @override
  void initState() {
    print("Building Nav Bar: cart count is ${widget.cartItemCount}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: widget.viewModel.indexStream,
      initialData: widget.viewModel.currentIndex,
      builder: (context, snapshot) {
        final currentIndex = snapshot.data ?? 0;

        return BottomNavigationBar(
          iconSize: iconSize,
          currentIndex: currentIndex,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            widget.viewModel.updateIndex(index);
            navigateToPage(index, context);
          },
          items: [
            BottomNavigationBarItem(
              icon: BottomNavIconWidget(
                assetPath: AppIcons.home,
                isActive: currentIndex == 0,
                iconSize: iconSize,
              ),
              activeIcon: BottomNavIconWidget(
                assetPath: AppIcons.home,
                isActive: true,
                iconSize: iconSize,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CartIconWithBadge(),
              activeIcon: CartIconWithBadge(isActive: true),
              label: 'Cart',
            ),

            BottomNavigationBarItem(
              icon: BottomNavIconWidget(
                assetPath: AppIcons.favorite,
                isActive: currentIndex == 2,
                iconSize: iconSize,
              ),
              activeIcon: BottomNavIconWidget(
                assetPath: AppIcons.favorite,
                isActive: true,
                iconSize: iconSize,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: BottomNavIconWidget(
                assetPath: AppIcons.user,
                isActive: currentIndex == 3,
                iconSize: iconSize,
              ),
              activeIcon: BottomNavIconWidget(
                assetPath: AppIcons.user,
                isActive: true,
                iconSize: iconSize,
              ),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}


void navigateToPage(int index, BuildContext context) {
  switch (index) {
    case 1:
    case 2:
    case 3:
    Navigator.pushNamed(
      context,
      Routes.cart,
    );
    break;
    default:
      Navigator.pushNamed(
        context,
        Routes.home,
      );
  }
}
