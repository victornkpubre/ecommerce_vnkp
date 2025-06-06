import 'package:ecommerce_vnkp/app/constants.dart';
import 'package:ecommerce_vnkp/data/data_source/reponses/confirmation.dart';
import 'package:ecommerce_vnkp/data/models/product_model/product_model.dart';
import 'package:ecommerce_vnkp/data/data_source/reponses/products.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';

class RemoteDataBaseClient {

  Future<ConfirmationResponse> checkout(CartEntity cart) async {
    await Future.delayed(const Duration(seconds: 2));
    return ConfirmationResponse(
        status: 200,
        message: 'successful',
        confirmation: true
    ); // Assuming `body` is a boolean
  }

  Future<ProductsResponse> getProducts(int page) async {
    await Future.delayed(const Duration(seconds: 2));

    final products = paginatedResponse(page, AppConstants.pageSize);
    return ProductsResponse(
        status: 200,
        message: 'successful',
        products: products
    );
  }

  List<ProductModel> paginatedResponse(int page, int size) {
    final generatedProducts = generateProducts();
    final startIndex = (page - 1) * size;
    final endIndex = (startIndex + size).clamp(0, generatedProducts.length);

    final paginated = generatedProducts.sublist(
      startIndex,
      endIndex,
    );

    return paginated;
  }
}

List<ProductModel> generateProducts() {
  return List.generate(5, (index) {
    final productList = [
      {
        "id": 1,
        "name": "Sony WH-1000XM5 Headphones",
        "image": "https://m.media-amazon.com/images/I/71o8Q5XJS5L._AC_SL1500_.jpg",
        "description": "Industry-leading noise canceling wireless headphones with up to 30 hours of battery life.",
        "price": 349.99
      },
      {
        "id": 2,
        "name": "Apple MacBook Air M2",
        "image": "https://m.media-amazon.com/images/I/71vFKBpKakL._AC_SL1500_.jpg",
        "description": "13-inch Apple MacBook Air with M2 chip, ultra-lightweight, and fanless design.",
        "price": 1099.00
      },
      {
        "id": 3,
        "name": "Dell XPS 13 Plus",
        "image": "https://m.media-amazon.com/images/I/61Y30DpqRVL._AC_SL1000_.jpg",
        "description": "Ultra-portable 13.4” laptop with 12th Gen Intel processors and InfinityEdge display.",
        "price": 1299.00
      },
      {
        "id": 4,
        "name": "Sony PlayStation 5",
        "image": "https://m.media-amazon.com/images/I/619BkvKW35L._AC_SL1500_.jpg",
        "description": "Next-gen gaming console with 4K graphics, fast loading times, and immersive gameplay.",
        "price": 499.00
      },
      {
        "id": 5,
        "name": "Nikon Z6 II Mirrorless Camera",
        "image": "https://static.bhphoto.com/images/images500x500/nikon_z6_ii_mirrorless_digital_camera_1621807448000_1589557.jpg",
        "description": "Reliable full‑frame mirrorless camera with 24.5 MP sensor, 4K video, and dual card slots.",
        "price": 1996.95
      }
    ];

    final product = productList[index % productList.length];

    return ProductModel(
      id: product["id"] as int,
      name: product["name"] as String,
      image: product["image"] as String,
      description: product["description"] as String,
      price: product["price"] as double,
    );
  });
}

