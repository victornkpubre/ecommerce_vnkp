import 'package:bloc/bloc.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingViewModel extends Bloc<ShoppingEvent, ShoppingState> {
  final ProductsRepository _productsRepository;
  final CartRepository _cartRepository;

  ShoppingViewModel(this._productsRepository, this._cartRepository) : super(ShoppingInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading(
        products: event.products,
        cart: event.cart,
        currentProductIndex: event.currentProductIndex
      ));

      try {
        final response = await _productsRepository.getProducts(event.page);

        response.fold((error) {
          emit(ProductsLoadFailure(
              message: error.message,
              products: event.products,
              cart: event.cart,
              currentProductIndex: event.currentProductIndex
          ));
        }, (productsReceived) {
          emit(ProductsLoaded(
              products: [...event.products, ...productsReceived],
              cart: event.cart,
              currentProductIndex: event.currentProductIndex
          ));
        });

      } catch (e) {
        emit(ProductsLoadFailure(
            message: "Failed to load products",
            products: event.products,
            cart: event.cart,
            currentProductIndex: event.currentProductIndex
        ));
      }
    });

    on<AddProductToCart>((event, emit) {
      CartEntity currentCart = CartEntity(products: [...event.cart.products]);
      final updatedCart = currentCart.add(event.products[event.currentProductIndex]);

      emit(CartIncreased(
          cart: updatedCart,
          products: event.products,
          currentProductIndex: event.currentProductIndex
      ));
    });

    on<RemoveProductFromCart>((event, emit) {
      CartEntity currentCart = CartEntity(products: [...event.cart.products]);
      final updatedCart = currentCart.remove(event.products[event.currentProductIndex]);

      emit(CartReduced(
          cart: updatedCart,
          products: event.products,
          currentProductIndex: event.currentProductIndex
      ));
    });

    on<CheckoutCart>((event, emit) async {
      try {
        final response = await _cartRepository.checkout(event.cart);

        response.fold((error) {
          emit(CartCheckoutFailure(
              message: error.message,
              products: event.products,
              cart: event.cart,
              currentProductIndex: event.currentProductIndex
          ));
        }, (confirmation) {
          event.cart.clear();
          emit(CartCheckedOut(
              confirmation: confirmation,
              products: event.products,
              cart: event.cart,
              currentProductIndex: event.currentProductIndex
          ));
        });

      } catch (e) {
        emit(CartCheckoutFailure(
            message: "Failed to Checkout. Try Again Later",
            products: event.products,
            cart: event.cart,
            currentProductIndex: event.currentProductIndex
        ));
      }

    });
  }
}
