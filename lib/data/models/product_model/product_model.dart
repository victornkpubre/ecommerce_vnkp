import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  ProductModel({
    required this.price,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      name: name,
      image: image,
      description: description,
      price: price,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, image: $image, description: $description, price: $price)';
  }
}
