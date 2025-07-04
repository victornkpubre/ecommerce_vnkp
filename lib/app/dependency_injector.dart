import 'package:ecommerce_vnkp/data/data_source/clients/local_db_client.dart';
import 'package:ecommerce_vnkp/data/data_source/clients/remote_db_client.dart';
import 'package:ecommerce_vnkp/data/repositories/cart/cart_repository.dart';
import 'package:ecommerce_vnkp/data/repositories/products/products_repository.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/btm_navigation_viewmodel/btm_nav_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/cart_viewmodel/cart_bloc.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/products_viewmodel/product_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DependencyInjector {
  late ProductsRepository _productsRepository;
  late CartRepository _cartRepository;
  late RemoteDataBaseClient _remoteDataBaseClient;
  late LocalDatabaseClient _localDatabaseClient;


  DependencyInjector();

  initPref() async {
    _remoteDataBaseClient = RemoteDataBaseClient();
    _localDatabaseClient = LocalDatabaseClient();
    _productsRepository = ProductsRepositoryImplementation(_remoteDataBaseClient);
    _cartRepository = CartRepositoryImplementation(_remoteDataBaseClient, _localDatabaseClient);
  }

  List<SingleChildWidget> inject() {
    return [
      BlocProvider<ProductViewModel>(
        create: (context) => ProductViewModel(
          _productsRepository
        )
      ),
      BlocProvider<CartBloc>(
          create: (context) => CartBloc(
              _cartRepository
          )
      ),
      Provider<BottomNavViewModel>(
          create: (context) => BottomNavViewModel()
      ),
    ];
  }
}
