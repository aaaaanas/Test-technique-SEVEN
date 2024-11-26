import 'package:flutter/material.dart';
import 'package:flutter_pagination_app/models/user.dart';
import 'package:flutter_pagination_app/services/api_service.dart'; // Import your API service

class UserDetailScreen extends StatelessWidget {
  final String userId;

  // Constructor to receive userId
  const UserDetailScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: ApiService.fetchUserById(userId), // Fetch user details by ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('User not found'),
            ),
            body: Center(
              child: Text('User not found'),
            ),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.profileImageUrl),
                ),
                SizedBox(height: 16),
                Text(
                  'Name: ${user.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Email: ${user.email}'),
                SizedBox(height: 8),
                Text('Phone: ${user.phone}'),
                SizedBox(height: 8),
                Text('Address: ${user.address}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
