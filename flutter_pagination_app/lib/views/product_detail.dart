import 'package:flutter/material.dart';
import 'package:flutter_pagination_app/models/product.dart';
import 'package:flutter_pagination_app/services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId; // Accept productId as a parameter

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: ApiService.fetchProductById(productId), // Fetch product details by productId
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Loading...')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Product not found')),
            body: Center(child: Text('Product not found')),
          );
        }

        final product = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text(product.name)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.imageUrl),
                SizedBox(height: 8),
                Text('Name: ${product.name}'),
                Text('Price: \$${product.price}'),
                Text('Description: ${product.description}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
