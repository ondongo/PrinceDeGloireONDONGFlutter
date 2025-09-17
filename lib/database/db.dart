import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'test_database.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, lastName TEXT, firstName TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion == 1 && newVersion == 2) {
        return db.execute(
          'ALTER TABLE users'
          'RENAME COLUMN firstName TO firstName',
        );
      }
    },

    version: 2,
  );
}
