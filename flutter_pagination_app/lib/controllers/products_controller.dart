import 'package:flutter_pagination_app/models/product.dart';
import 'package:flutter_pagination_app/utils/api_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs; // Observable list to store products
  var isLoading = false.obs; // Observable for loading state
  var isError = false.obs; // Observable for error state

  // Method to fetch products from the API
  void fetchProducts(int page) async {
    isLoading(true); // Set loading state to true before fetching
    try {
      // Attempt to fetch products from the API
      var fetchedProducts = await ApiService.fetchProducts(page);
      products.addAll(fetchedProducts); // Add fetched products to the list
    } catch (e) {
      // If there's an error, set the error state to true
      isError(true);
    } finally {
      isLoading(false); // Set loading state to false once done
    }
  }
}
