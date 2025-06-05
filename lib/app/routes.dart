import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/presentation/views/cart/cart_view.dart';
import 'package:ecommerce_vnkp/presentation/views/home/home_view.dart';
import 'package:ecommerce_vnkp/presentation/views/home/product_view.dart';
import 'package:ecommerce_vnkp/presentation/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = SplashScreen.routeName;
  static const String home = HomeView.routeName;
  static const String cart = CartView.routeName;
  static const String product = ProductView.routeName;
}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      case Routes.splashRoute:
        return MaterialPageRoute(
            builder: ((context) => const SplashScreen()));

      case Routes.home:
        return MaterialPageRoute(
            builder: ((context) => const HomeView()));

      case (Routes.cart):
        return MaterialPageRoute(
            builder: ((context) => const CartView()));

      case (Routes.product):
        final product = routeSettings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (context) => ProductView(product: product),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: ((_) =>
            Scaffold(
              appBar: AppBar(
                title: const Text('Route Error'),
              ),
              body: const Center(child: Text('No Route Found')),
            ))
    );
  }

}