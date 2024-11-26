// lib/views/dashboard.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Users'),
              onTap: () => context.go('/users'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Products'),
              onTap: () => context.go('/products'),
            ),
          ],
        ),
      ),
    );
  }
}
