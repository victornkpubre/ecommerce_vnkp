import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/cart_viewmodel/cart_bloc.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/products_viewmodel/product_viewmodel.dart';
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
    context.read<ProductViewModel>().add(FetchProducts(
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

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = state.cart;
        final cartItemCount = cart.products.length;

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
                      child: BlocConsumer<ProductViewModel, ProductState>(
                        listener: (context, state) {
                          
                        },
                        builder: (context, state) {
                          final products = state.products;
                          final currentProductIndex = state.currentProductIndex;


                          if(products.isEmpty) {
                            return Container();
                          }

                          return ProductGridView(
                            height: height,
                            products: products,
                            onEndReached: () => context.read<ProductViewModel>()
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
