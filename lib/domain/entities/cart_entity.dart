import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';

class CartEntity {
  List<CartItemEntity> products;

  CartEntity({this.products = const []});

  CartEntity add(ProductEntity product) {
    final index = products.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      products[index].quantity++;
    } else {
      products.add(CartItemEntity(product: product, quantity: 1));
    }

    return CartEntity(products: products);
  }

  CartEntity remove(ProductEntity product) {
    final index = products.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      } else {
        products.removeAt(index);
      }
    }

    return CartEntity(products: products);
  }

  CartEntity removeProduct(ProductEntity product) {
    final index = products.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      products.removeAt(index);
    }
    return CartEntity(products: products);
  }

  CartEntity clear() {
    products.clear();
    return CartEntity(products: products);
  }

  @override
  String toString() {
    if (products.isEmpty) return 'Cart is empty';

    return 'Cart contents:\n' +
        products.map((item) => '- ${item.product.name} (ID: ${item.product
            .id}): Quantity = ${item.quantity}').join('\n');
  }
}

class CartItemEntity {
  final ProductEntity product;
  int quantity;

  CartItemEntity({required this.product, required this.quantity});

}
