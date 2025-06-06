import 'package:bloc/bloc.dart';
import 'package:ecommerce_vnkp/domain/entities/cart_entity.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductViewModel extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository _productsRepository;

  ProductViewModel(this._productsRepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading(
        products: event.products,
        currentProductIndex: event.currentProductIndex
      ));

      try {
        final response = await _productsRepository.getProducts(event.page);

        response.fold((error) {
          emit(ProductsLoadFailure(
              message: error.message,
              products: event.products,
              currentProductIndex: event.currentProductIndex
          ));
        }, (productsReceived) {
          emit(ProductsLoaded(
              products: [...event.products, ...productsReceived],
              currentProductIndex: event.currentProductIndex
          ));
        });

      } catch (e) {
        emit(ProductsLoadFailure(
            message: "Failed to load products",
            products: event.products,
            currentProductIndex: event.currentProductIndex
        ));
      }
    });

  }
}
