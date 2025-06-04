import 'package:ecommerce_vnkp/data/models/cart_model/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabaseClient {
  static const String cartBoxName = "cartBox";
  static const String cartKey = "cart";

  Future<void> setCart(CartModel? cart) async {
    var box = await Hive.openBox<CartModel>(cartBoxName);
    if (cart == null) {
      await box.delete(cartKey);
    } else {
      await box.put(cartKey, cart);
    }
  }

  Future<CartModel?> getCart() async {
    var box = await Hive.openBox<CartModel>(cartBoxName);
    return box.get(cartKey);
  }
}