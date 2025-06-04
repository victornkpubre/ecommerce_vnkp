import 'package:dartz/dartz.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/failure_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts(int page);
}

abstract class CartRepository {
  Future<Either<Failure, bool>> checkout(CartEntity cart);
}
