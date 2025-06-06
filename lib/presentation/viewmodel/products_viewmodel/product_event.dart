part of 'product_viewmodel.dart';

@immutable
sealed class ProductEvent {
  final List<ProductEntity> products;
  final CartEntity cart;
  final int currentProductIndex;

  const ProductEvent({
    required this.cart,
    required this.products,
    required this.currentProductIndex,
  });
}

class FetchProducts extends ProductEvent {
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
