import 'package:ecommerce_vnkp/data/data_source/reponses/base.dart';
import 'package:ecommerce_vnkp/data/models/product_model/product_model.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';

class ProductsResponse  implements BaseResponse<List<ProductModel>> {
  final int? _status;
  final String? _message;
  final List<ProductModel> _products;

  ProductsResponse({
    required int? status,
    required String? message,
    required List<ProductModel> products
  }) : _status = status, _message = message, _products = products;

  @override
  List<ProductModel> get body => _products;
  @override
  String? get message => _message;
  @override
  int? get status => _status;

  List<ProductEntity> toDomain() {
    return _products.map((p) => p.toDomain()).toList();
  }

}
