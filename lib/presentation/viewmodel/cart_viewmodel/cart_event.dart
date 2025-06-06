part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  final CartEntity cart;

  const CartEvent({
    required this.cart,
  });
}


class AddProductToCart extends CartEvent {
  final List<ProductEntity> products;
  final int currentProductIndex;

  const AddProductToCart({
    required this.products,
    required this.currentProductIndex,
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

class RemoveProductFromCart extends CartEvent {
  final List<ProductEntity> products;
  final int currentProductIndex;

  const RemoveProductFromCart({
    required this.products,
    required this.currentProductIndex,
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

class ClearProductFromCart extends CartEvent {
  final List<ProductEntity> products;
  final int currentProductIndex;

  const ClearProductFromCart({
    required this.products,
    required this.currentProductIndex,
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

class CheckoutCart extends CartEvent {
  const CheckoutCart({
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}
