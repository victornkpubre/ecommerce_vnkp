import 'package:ecommerce_vnkp/app/routes.dart';
import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:ecommerce_vnkp/presentation/viewmodel/shopping_viewmodel/shopping_viewmodel.dart';
import 'package:ecommerce_vnkp/presentation/views/home/components/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridView extends StatefulWidget {
  final List<ProductEntity> products;
  final void Function() onEndReached;
  final double height;

  const ProductGridView({
    super.key,
    required this.products,
    required this.onEndReached,
    required this.height,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  late final ScrollController _scrollController;
  bool _hasReachedBottom = false;
  double _previousOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() async {
        final pos = _scrollController.position;

        // Track bottom reach once
        if (pos.pixels >= pos.maxScrollExtent && !pos.outOfRange) {
          if (!_hasReachedBottom) {
            _hasReachedBottom = true;
          }
        } else {
          _hasReachedBottom = false;
        }

        // Detect scroll after bottom has been reached
        if (_hasReachedBottom) {
          final delta = pos.pixels - _previousOffset;
          if (delta != 0) {
            widget.onEndReached();
          }
        }
        _previousOffset = pos.pixels;
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded( // This ensures GridView gets a bounded height
          child: GridView.builder(
            controller: _scrollController,
            itemCount: widget.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: widget.height / 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return ProductCardWidget(
                product: product,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.product,
                    arguments: product,  // pass the selected product here
                  );
                },
              );
            },
          ),
        ),
        BlocBuilder<ShoppingViewModel, ShoppingState>(
          builder: (context, state) {
            bool loading = (state is ProductsLoaded);
            loading = (state is ProductsLoading);

            return Container(
              child: loading?
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Loading...", style: TextStyle(color: Colors.black54, fontSize: 24),),
                ): Container(),
            );
          },
        )

      ],
    );
  }
}
