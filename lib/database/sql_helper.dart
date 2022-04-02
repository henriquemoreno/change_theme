import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String databaseName = 'TesteLogin.db';

const String createTables =
    "CREATE TABLE login(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT, email TEXT, password TEXT)";

class SQLHelper {
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(createTables);
      },
      version: 1,
    );
  }
}
