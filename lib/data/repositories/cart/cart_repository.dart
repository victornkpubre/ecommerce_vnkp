import 'package:dartz/dartz.dart';
import 'package:ecommerce_vnkp/data/data_source/clients/remote_db_client.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/failure_entity.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';

class CartRepositoryImplementation extends CartRepository {
  final RemoteDataBaseClient _dataBaseApiClient;

  CartRepositoryImplementation(this._dataBaseApiClient);

  @override
  Future<Either<Failure, bool>> checkout(CartEntity cart) async {
    final response = await _dataBaseApiClient.checkout(cart);
    if (response.status == 200) {
      return Right(response.toDomain());
    } else {
      return Left(Failure(response.status ?? 500, response.message ?? 'Error occurred'));
    }
  }

}



