import 'package:flutter/material.dart';
import 'package:shop_flutter/model/product.dart';

class ProductView extends StatelessWidget {
  final Product product;

  const ProductView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(product.price.toString()),
            ],
          ),
        )
      ],
    );
  }
}