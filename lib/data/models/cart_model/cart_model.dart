import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final ProductEntity product;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  CartItemEntity toDomain() {
    return CartItemEntity(
      product: product,
      quantity: quantity,
    );
  }
}

@HiveType(typeId: 1)
class CartModel extends HiveObject {
  @HiveField(0)
  final List<CartItemModel> items;

  CartModel({required this.items});

  CartEntity toDomain() {
    return CartEntity(products: items.map((e) => e.toDomain()).toList());
  }
}
