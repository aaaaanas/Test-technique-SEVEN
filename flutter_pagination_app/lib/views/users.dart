import 'package:flutter/material.dart';
import 'package:flutter_pagination_app/models/user.dart';
import 'package:flutter_pagination_app/services/api_service.dart';
import 'package:flutter_pagination_app/widgets/user_tile.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final List<User> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchUsers();
      }
    });
  }

  void _fetchUsers() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    try {
      final users = await ApiService.fetchUsers(_page);
      setState(() {
        _users.addAll(users);
        _page++;
        _hasMore = users.isNotEmpty;
      });
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UserSearch(_users));
            },
          ),
        ],
      ),
      body: _isLoading && _users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _users.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _users.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return UserTile(user: _users[index]);
              },
            ),
    );
  }
}

class UserSearch extends SearchDelegate<User?> {
  final List<User> users;
  UserSearch(this.users);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = users.where((user) {
      final queryLower = query.toLowerCase();
      return user.name.toLowerCase().contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return ListTile(
          leading: Image.network(user.profileImageUrl),
          title: Text(user.name),
          subtitle: Text(user.email),
          onTap: () => close(context, user),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = users.where((user) {
      final queryLower = query.toLowerCase();
      return user.name.toLowerCase().contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final user = suggestions[index];
        return ListTile(
          leading: Image.network(user.profileImageUrl),
          title: Text(user.name),
          subtitle: Text(user.email),
          onTap: () => close(context, user),
        );
      },
    );
  }
}

