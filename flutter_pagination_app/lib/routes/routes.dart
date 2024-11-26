import 'package:flutter_pagination_app/views/dashboard.dart';
import 'package:flutter_pagination_app/views/product_detail.dart';
import 'package:flutter_pagination_app/views/products.dart';
import 'package:flutter_pagination_app/views/user_detail.dart';
import 'package:flutter_pagination_app/views/users.dart';
import 'package:go_router/go_router.dart';

// Define the router
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Dashboard(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => UsersScreen(),
    ),
    GoRoute(
      path: '/user/:id',
      builder: (context, state) {
        final id = state.params['id']; // Extract user ID from params
        return UserDetailScreen(userId: id!); // Pass the userId
      },
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => ProductsScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.params['id']; // Extract product ID from params
        return ProductDetailScreen(productId: id!); // Pass the productId
  },
),
  ],
);
