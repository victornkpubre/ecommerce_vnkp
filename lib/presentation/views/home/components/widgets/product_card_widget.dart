import 'package:ecommerce_vnkp/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCardWidget({
    required this.product,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Hero(
                  tag: 'product_image_${product.id}',
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40, // Enough for 2 lines of text at normal font size
              child: Hero(
                tag: 'product_title_${product.id}',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Hero(
              tag: 'product_price_${product.id}',
              child: Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
