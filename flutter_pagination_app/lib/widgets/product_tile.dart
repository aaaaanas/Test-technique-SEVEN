import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      onTap: () => context.go('/product/${product.id}'),
    );
  }
}
