import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/shopping_viewmodel/shopping_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/views/products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/views/btm_nav_view.dart';
import 'components/widgets/header_widget.dart';


class HomeView extends StatefulWidget {
  static const String routeName = '/home';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<ShoppingViewModel>().add(FetchProducts(
        page: currentPage,
        products: const [],
        currentProductIndex: 0,
        cart: CartEntity()
    ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final btmNavigationViewModel = context.read<BottomNavViewModel>();

    return BlocBuilder<ShoppingViewModel, ShoppingState>(
      builder: (context, state) {
        final cartItemCount = state.cart.products.length;

        return Scaffold(
          bottomNavigationBar: BottomNavView(
              viewModel: btmNavigationViewModel,
              cartItemCount: cartItemCount,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  // Header
                  const AppHeader(),

                  // Search
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  // Page Title
                  Hero(
                    tag: 'page_title',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back),
                            const SizedBox(width: 8),
                            Text(AppString.tech, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: width*(1/3)),
                    child: const Text(
                      "Smartphones, Laptops & Accessories",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Product Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: BlocConsumer<ShoppingViewModel, ShoppingState>(
                        listener: (context, state) {
                          // switch (state.runtimeType) {
                          //   case CartCheckedOut:
                          //     final confirmation = (state as CartCheckedOut).confirmation;
                          //     break;
                          //
                          //   case ProductsLoadFailure:
                          //     final message = (state as ProductsLoadFailure).message;
                          //     break;
                          //
                          //   case CartCheckoutFailure:
                          //     final message = (state as CartCheckoutFailure).message;
                          //     break;
                          //
                          //   default:
                          //     break;
                          // }
                        },
                        builder: (context, state) {
                          final products = state.products;
                          final cart = state.cart;
                          final currentProductIndex = state.currentProductIndex;

                          //Show grid shimmer id projects is empty
                          if(products.isEmpty) {
                            return Container();
                          }

                          return ProductGridView(
                            height: height,
                            products: products,
                            onEndReached: () => context.read<ShoppingViewModel>()
                               .add(FetchProducts(
                                  page: ++currentPage,
                                  products: products,
                                  cart: cart,
                                  currentProductIndex: currentProductIndex
                              )),
                          );
                        },
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

}
