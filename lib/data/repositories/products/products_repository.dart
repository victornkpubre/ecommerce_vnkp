import 'package:dartz/dartz.dart';
import 'package:ecommerce_vnkp/data/data_source/clients/remote_db_client.dart';
import 'package:ecommerce_vnkp/domain/entities/failure_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';

class ProductsRepositoryImplementation extends ProductsRepository {
  final RemoteDataBaseClient _dataBaseApiClient;

  ProductsRepositoryImplementation(this._dataBaseApiClient);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(int page) async {
    final response = await _dataBaseApiClient.getProducts(page);
    if (response.status == 200) {
      return Right(response.toDomain());
    } else {
      return Left(Failure(response.status ?? 500, response.message ?? 'Error occurred'));
    }
  }

}



