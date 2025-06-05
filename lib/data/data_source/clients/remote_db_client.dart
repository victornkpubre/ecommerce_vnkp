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
  return List.generate(10, (index) {
    final productList = [
      {
        "name": "Sony WH-1000XM5 Headphones",
        "image": "https://m.media-amazon.com/images/I/71o8Q5XJS5L._AC_SL1500_.jpg",
        "description": "Industry-leading noise canceling wireless headphones with up to 30 hours of battery life.",
        "price": 349.99
      },
      {
        "name": "Apple MacBook Air M2",
        "image": "https://m.media-amazon.com/images/I/71vFKBpKakL._AC_SL1500_.jpg",
        "description": "13-inch Apple MacBook Air with M2 chip, ultra-lightweight, and fanless design.",
        "price": 1099.00
      },
      {
        "name": "Samsung Galaxy S23 Ultra",
        "image": "https://m.media-amazon.com/images/I/81VfGqK6S8L._AC_SL1500_.jpg",
        "description": "Flagship smartphone with 200MP camera, S Pen support, and Snapdragon 8 Gen 2 chip.",
        "price": 1199.99
      },
      {
        "name": "Dell XPS 13 Plus",
        "image": "https://m.media-amazon.com/images/I/61Y30DpqRVL._AC_SL1000_.jpg",
        "description": "Ultra-portable 13.4” laptop with 12th Gen Intel processors and InfinityEdge display.",
        "price": 1299.00
      },
      {
        "name": "GoPro HERO12 Black",
        "image": "https://m.media-amazon.com/images/I/61zywAjD9iL._AC_SL1500_.jpg",
        "description": "Rugged 5.3K action camera with improved battery, stabilization, and livestreaming.",
        "price": 399.99
      },
      {
        "name": "Sony PlayStation 5",
        "image": "https://m.media-amazon.com/images/I/619BkvKW35L._AC_SL1500_.jpg",
        "description": "Next-gen gaming console with 4K graphics, fast loading times, and immersive gameplay.",
        "price": 499.00
      },
      {
        "name": "Apple Watch Series 9",
        "image": "https://m.media-amazon.com/images/I/61fwb3pXlDL._AC_SL1500_.jpg",
        "description": "Advanced smartwatch with health tracking, always-on display, and Siri integration.",
        "price": 399.00
      },
      {
        "name": "Anker Soundcore Bluetooth Speaker",
        "image": "https://m.media-amazon.com/images/I/61rEsmzA1IL._AC_SL1500_.jpg",
        "description": "Portable waterproof speaker with 24-hour battery life and BassUp technology.",
        "price": 59.99
      }
    ];

    final product = productList[index % productList.length];

    return ProductModel(
      id: index + 1,
      name: product["name"] as String,
      image: product["image"] as String,
      description: product["description"] as String,
      price: product["price"] as double,
    );
  });
}

