part of 'shopping_viewmodel.dart';

@immutable
sealed class ShoppingState {
  final List<ProductEntity> products;
  final CartEntity cart;
  final int currentProductIndex;

  const ShoppingState({
    required this.products,
    required this.cart,
    required this.currentProductIndex,
  });
}

final class ShoppingInitial extends ShoppingState {
  ShoppingInitial()
      : super(
    products: const [],
    cart: CartEntity(),
    currentProductIndex: 0,
  );
}

final class ProductsLoading extends ShoppingState {
  const ProductsLoading({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class ProductsLoaded extends ShoppingState {
  const ProductsLoaded({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class ProductsLoadFailure extends ShoppingState {
  final String message;

  const ProductsLoadFailure({
    required this.message,
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class CartIncreased extends ShoppingState {
  const CartIncreased({
    required CartEntity cart,
    required List<ProductEntity> products,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class CartReduced extends ShoppingState {
  const CartReduced({
    required CartEntity cart,
    required List<ProductEntity> products,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class CheckingOut extends ShoppingState {
  const CheckingOut({
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class CartCheckoutFailure extends ShoppingState {
  final String message;

  const CartCheckoutFailure({
    required this.message,
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}

final class CartCheckedOut extends ShoppingState {
  final bool confirmation;

  const CartCheckedOut({
    required this.confirmation,
    required List<ProductEntity> products,
    required CartEntity cart,
    required int currentProductIndex,
  }) : super(
    products: products,
    cart: cart,
    currentProductIndex: currentProductIndex,
  );
}
