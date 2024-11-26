// lib/widgets/user_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_pagination_app/models/user.dart';
import 'package:go_router/go_router.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(user.profileImageUrl),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () => context.go('/user/${user.id}', extra: user),
    );
  }
}
