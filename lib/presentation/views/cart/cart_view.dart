import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/shopping_viewmodel/shopping_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  static const String routeName = '/cart';
  const CartView({super.key,});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ShoppingViewModel, ShoppingState>(
          listener: (context, state) {

          },
          builder: (context, state) {

            final cart = CartEntity(
              products: [

              ]
            );
            print(cart.products.length);
            final subtotal = cart.products.fold(0.0, (prev, p) {
              double aggregate = prev + p.quantity*p.product.price;
              return aggregate;
            });

            final shipping = AppConstants.shippingFee;
            final total = subtotal + shipping;

            return Column(
              children: [
                // Header
                AppHeader(),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      context.read<BottomNavViewModel>().updateIndex(0);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 12),
                        Text("Your Cart", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                // Cart items
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: cart.products.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final cartItem = cart.products[index];

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Image.network(cartItem.product.image, height: 80, width: 80),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.product.name, style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text("\$${cartItem.product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  const Text("In stock", style: TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey[300],
                                      child: const Icon(Icons.remove, size: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Text("${cartItem.quantity}"),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: const Icon(Icons.add, size: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                  child: const Icon(Icons.delete_outline),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Order Summary
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Order Info", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text("Subtotal"),
                        Text("\$$subtotal"),
                      ]),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text("Shipping"),
                        Text("\$$shipping"),
                      ]),
                      const SizedBox(height: 4),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("\$$total", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Checkout (\$$total)", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
