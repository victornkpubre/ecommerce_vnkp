import 'package:bloc/bloc.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartInitial(cart: CartEntity())) {

    on<AddProductToCart>((event, emit) {
      CartEntity currentCart = CartEntity(products: [...event.cart.products]);
      currentCart.add(event.products[event.currentProductIndex]);

      emit(CartIncreased(
          cart: currentCart,
      ));
    });

    on<RemoveProductFromCart>((event, emit) {
      CartEntity currentCart = CartEntity(products: [...event.cart.products]);
      currentCart.remove(event.products[event.currentProductIndex]);

      emit(CartReduced(
        cart: currentCart,
      ));
    });

    on<ClearProductFromCart>((event, emit) {
      CartEntity currentCart = CartEntity(products: [...event.cart.products]);
      currentCart.removeProduct(event.products[event.currentProductIndex]);

      emit(CartReduced(
        cart: currentCart,
      ));
    });

    on<CheckoutCart>((event, emit) async {
      try {
        final response = await _cartRepository.checkout(event.cart);

        response.fold((error) {
          emit(CartLoadingFailure(
              message: error.message,
              cart: event.cart,
          ));
        }, (confirmation) {
          event.cart.clear();
          emit(CartCheckedOut(
              confirmation: confirmation,
              cart: event.cart,
          ));
        });

      } catch (e) {
        emit(CartLoadingFailure(
            message: "Failed to Checkout. Try Again Later",
            cart: event.cart,
        ));
      }

    });
  }
}
