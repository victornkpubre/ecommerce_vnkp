import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/cart_viewmodel/cart_bloc.dart';
import 'package:ecommerce_vnkp/presentation/views/common/toast.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/header_widget.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/primary_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartView extends StatelessWidget {
  static const String routeName = '/cart';
  const CartView({super.key,});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if(state is CartCheckedOut) {
              AppToast.show(
                context: context,
                message: "Checkout was successful",
              );
            }
          },
          builder: (context, state) {
            final cart = state.cart;

            print(cart.toString());

            final subtotal = cart.products.fold(0.0, (prev, p) {
              double aggregate = prev + p.quantity*p.product.price;
              return aggregate;
            });

            final shipping = AppConstants.shippingFee;
            final total = subtotal + shipping;

            return Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Header
                  AppHeader(),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: cart.products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final cartItem = cart.products[index];

                        print("Cart Item");
                        print(cartItem.toString());

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [

                              //Product Image
                              Image.network(
                                  cartItem.product.image,
                                  width: width/4,
                                  fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 16),

                              //Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartItem.product.name, style: const TextStyle(fontSize: 22)),
                                    const SizedBox(height: 8),

                                    Text("\$${cartItem.product.price.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),

                                    const Text("In stock", style: TextStyle(fontSize: 20, color: Colors.green)),
                                    const SizedBox(height: 8),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 32,
                                              backgroundColor: Colors.grey[300],
                                              child: GestureDetector(
                                                onTap: () => context.read<CartBloc>()
                                                    .add(RemoveProductFromCart(
                                                    products: [cartItem.product],
                                                    currentProductIndex: 0,
                                                    cart: cart
                                                )),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(14.0),
                                                  child: SvgPicture.asset(
                                                    AppIcons.minus,
                                                    width: double.infinity,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 32),

                                            SizedBox(
                                              width: 32,
                                              child: Center(
                                                child: Text("${cartItem.quantity}",
                                                    style: TextStyle(fontSize: 20)
                                                ),
                                              )
                                            ),
                                            const SizedBox(width: 32),

                                            CircleAvatar(
                                              radius: 32,
                                              backgroundColor: Colors.white,
                                              child: GestureDetector(
                                                onTap: () => context.read<CartBloc>()
                                                    .add(AddProductToCart(
                                                    products: [cartItem.product],
                                                    currentProductIndex: 0,
                                                    cart: cart
                                                )),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(14.0),
                                                  child: SvgPicture.asset(
                                                      AppIcons.add,
                                                      width: double.infinity,
                                                      color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        CircleAvatar(
                                          radius: 32,
                                          backgroundColor: Colors.white,
                                          child: GestureDetector(
                                            onTap: () => context.read<CartBloc>()
                                                .add(ClearProductFromCart(
                                                products: [cartItem.product],
                                                currentProductIndex: 0,
                                                  cart: cart
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(
                                                AppIcons.delete,
                                                width: double.infinity,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

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
                        const Text("Order Info", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text("Subtotal", style: TextStyle(fontSize: 22)),
                          Text("\$$subtotal", style: TextStyle(fontSize: 22)),
                        ]),
                        const SizedBox(height: 16),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text("Shipping", style: TextStyle(fontSize: 22)),
                          Text("\$$shipping", style: TextStyle(fontSize: 22)),
                        ]),
                        const SizedBox(height: 16),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text("Total", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Text("\$$total", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ]),
                        const SizedBox(height: 16),

                        PrimaryButtonWidget(
                            color: AppColor.primaryColor,
                            text: "Checkout (\$$total)",
                            onTap: () {
                              context.read<CartBloc>().add(
                                CheckoutCart(cart: cart)
                              );
                            }
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
