import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/app/routes.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/shopping_viewmodel/shopping_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/views/common/toast.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/primary_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/widgets/header_widget.dart';

class ProductView extends StatelessWidget {
  static const String routeName = '/products';
  final ProductEntity product;

  const ProductView({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocListener<ShoppingViewModel, ShoppingState>(
      listener: (context, state) {
        if(state is CartIncreased) {
          AppToast.show(
            context: context,
            message: "Item has been added to cart",
          );
        }

      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Header
                    const AppHeader(),

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
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  Routes.home,
                                ),
                                child: Text(
                                  AppString.back,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Image and details Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'product_image_${product.id}',
                          child: Image.network(
                            product.image,
                            height: height / 3,
                            width: height / 3,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Hero(
                            tag: 'product_title_${product.id}',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(product.name, style: const TextStyle(fontSize: 26)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Hero(
                            tag: 'product_price_${product.id}',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppString.about, style: AppTextStyle.details),
                        ),
                        const SizedBox(height: 6),

                        Text(product.description, style: AppTextStyle.details),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),

                // Add to cart button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder<ShoppingViewModel, ShoppingState>(
                    builder: (context, state) {
                      final loading = state is CheckingOut;
                      return Column(
                        children: [
                          PrimaryButtonWidget(
                            onTap: () {
                              context.read<ShoppingViewModel>().add(
                                AddProductToCart(
                                  currentProductIndex: product.id,
                                  cart: state.cart,
                                  products: state.products,
                                ),
                              );
                            },
                            text: AppString.add,
                            color: loading ? AppColor.secondaryColor : AppColor.primaryColor,
                          ),
                          const SizedBox(height: 36)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

