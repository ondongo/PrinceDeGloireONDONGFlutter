import 'package:flutter/material.dart';
import 'package:mon_premier_projet/models/User.dart';
import 'package:mon_premier_projet/repositories/user_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    super.initState();
    //    usersFuture = _initializeDatabaseAndGetUsers();
  }

  Future<List<User>> _initializeDatabaseAndGetUsers() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    UserProvider userProvider = UserProvider();
    await userProvider.open(path);
    return userProvider.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: FutureBuilder<List<User>>(
        future: _initializeDatabaseAndGetUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            print("nb User ${snapshot.data!.length}");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.lastname),
                  subtitle: Text('Age: ${user.age}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
