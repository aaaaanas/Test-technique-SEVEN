import 'package:flutter_pagination_app/models/user.dart';
import 'package:flutter_pagination_app/utils/api_service.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var users = <User>[].obs; // Observable list to store users
  var isLoading = false.obs; // Observable for loading state
  var isError = false.obs; // Observable for error state

  // Method to fetch users from the API
  void fetchUsers(int page) async {
    isLoading(true); // Set loading state to true before fetching
    try {
      // Attempt to fetch users from the API
      var fetchedUsers = await ApiService.fetchUsers(page);
      users.addAll(fetchedUsers); // Add fetched users to the list
    } catch (e) {
      // If there's an error, set the error state to true
      isError(true);
    } finally {
      isLoading(false); // Set loading state to false once done
    }
  }
}
