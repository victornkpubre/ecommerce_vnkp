class CartEntity {
  final List<CartItemEntity> products;

  CartEntity({required this.products});

}

class CartItemEntity {
  final int product;
  final int quantity;

  CartItemEntity({required this.product, required this.quantity});

}
