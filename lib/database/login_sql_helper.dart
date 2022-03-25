import 'package:change_theme/models/login_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String databaseName = 'TesteLogin.db';

const String createTables =
    "CREATE TABLE login(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT, email TEXT, password TEXT)";

class LoginSqlHelper {
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(createTables);
      },
      version: 1,
    );
  }

  // Define a function that inserts logins into the database
  static Future insertlogin(Login login) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Insert the login into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same login is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'login',
      login.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
