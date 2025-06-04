import 'package:ecommerce_vnkp/app/app.dart';
import 'package:ecommerce_vnkp/data/models/cart_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(CartModelAdapter());

  runApp(const ECommerceApp());
}
