import 'package:sqflite/sqflite.dart';

import '../models/User.dart';

class UserProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table user ( 
  id integer primary key autoincrement, 
  lastname text not null,
  age integer not null)
''');
      },
    );
    print('Database opened at path: $path');
  }

  Future<User> insert(User user) async {
    user.id = await db.insert("user", user.toMap());

    return user;
  }

  Future<List<User>> getAllUsers() async {
    List<Map<String, dynamic>> maps = await db.query('user');
    // Methode 2
    return maps.map(User.fromMap).toList();
    // Methode 3
    return maps.map((e) => User.fromMap(e)).toList();
    // Méthode 1
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future close() async => db.close();
}
