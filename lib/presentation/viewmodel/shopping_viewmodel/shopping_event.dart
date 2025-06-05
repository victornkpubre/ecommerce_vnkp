part of 'shopping_viewmodel.dart';

@immutable
sealed class ShoppingEvent {
  final List<ProductEntity> products;
  final CartEntity cart;
  final int currentProductIndex;

  const ShoppingEvent({
    required this.cart,
    required this.products,
    required this.currentProductIndex,
  });
}

class FetchProducts extends ShoppingEvent {
  final int page;

  const FetchProducts({
    required this.page,
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

class AddProductToCart extends ShoppingEvent {
  const AddProductToCart({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

class RemoveProductFromCart extends ShoppingEvent {
  const RemoveProductFromCart({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

class CheckoutCart extends ShoppingEvent {
  const CheckoutCart({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}
