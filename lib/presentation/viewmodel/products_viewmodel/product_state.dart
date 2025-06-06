part of 'product_viewmodel.dart';

@immutable
sealed class ProductState {
  final List<ProductEntity> products;
  final int currentProductIndex;

  const ProductState({
    required this.products,
    required this.currentProductIndex,
  });
}

final class ProductInitial extends ProductState {
  ProductInitial()
      : super(
    products: const [],
    currentProductIndex: 0,
  );
}

final class ProductsLoading extends ProductState {
  const ProductsLoading({
    required List<ProductEntity> products,
    required int currentProductIndex,
  }) : super(
    products: products,
    currentProductIndex: currentProductIndex,
  );
}

final class ProductsLoaded extends ProductState {
  const ProductsLoaded({
    required List<ProductEntity> products,
    required int currentProductIndex,
  }) : super(
    products: products,
    currentProductIndex: currentProductIndex,
  );
}

final class ProductsLoadFailure extends ProductState {
  final String message;

  const ProductsLoadFailure({
    required this.message,
    required List<ProductEntity> products,
    required int currentProductIndex,
  }) : super(
    products: products,
    currentProductIndex: currentProductIndex,
  );
}
