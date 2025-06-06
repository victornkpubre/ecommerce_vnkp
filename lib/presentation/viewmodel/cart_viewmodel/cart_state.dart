part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  final CartEntity cart;

  const CartState({
    required this.cart,
  });
}

final class CartInitial extends CartState {
  const CartInitial({
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

final class CartIncreased extends CartState {
  const CartIncreased({
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

final class CartReduced extends CartState {
  const CartReduced({
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}

final class CartCheckedOut extends CartState {
  final bool confirmation;

  const CartCheckedOut({
    required this.confirmation,
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}


final class CartLoading extends CartState {
  const CartLoading({
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}
final class CartLoadingFailure extends CartState {
  final String message;

  const CartLoadingFailure({
    required this.message,
    required CartEntity cart,
  }) : super(
    cart: cart,
  );
}