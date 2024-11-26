// lib/views/products.dart
import 'package:flutter/material.dart';
import 'package:flutter_pagination_app/models/product.dart';
import 'package:flutter_pagination_app/services/api_service.dart';
import 'package:flutter_pagination_app/widgets/product_tile.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Product> _products = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchProducts();
      }
    });
  }

  void _fetchProducts() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    try {
      final products = await ApiService.fetchProducts(_page);
      setState(() {
        _products.addAll(products);
        _page++;
        _hasMore = products.isNotEmpty;
      });
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: _isLoading && _products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _products.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _products.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return ProductTile(product: _products[index]);
              },
            ),
    );
  }
}
