import 'package:change_theme/database/sql_helper.dart';
import 'package:change_theme/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LoginSqlHelper {
  static Future<Login> getUsersById(int id) async {
    final db = await SQLHelper.getDatabase();

    final maps =
        await db.query('login', where: "id = ?", whereArgs: [id], limit: 1);

    var login = maps.firstWhere((element) => element['id'] == id);

    return Login(
        id: int.parse(login['id'].toString()),
        name: login['name'].toString(),
        email: login['email'].toString(),
        password: login['password'].toString());
  }

  static Future<void> updateLogin(Login login) async {
    final db = await SQLHelper.getDatabase();

    await db.update(
      'login',
      login.toMap(),
      where: 'id = ?',
      whereArgs: [login.id],
    );
  }

  static Future<void> deleteLogin(int id) async {
    final db = await SQLHelper.getDatabase();
    try {
      await db.delete("login", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future insertlogin(Login login) async {
    final db = await SQLHelper.getDatabase();

    await db.insert(
      'login',
      login.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Login>> getUsers() async {
    final db = await SQLHelper.getDatabase();

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM login');

    return List.generate(
      maps.length,
      (i) {
        return Login(
            id: maps[i]['id'],
            name: maps[i]['name'],
            email: maps[i]['email'],
            password: maps[i]['password']);
      },
    );
  }

  //Migué para não criar dois email de teste
  static Future<int> getCountByEmail() async {
    final db = await SQLHelper.getDatabase();

    var result = await db
        .rawQuery('SELECT * FROM login where email=?', ['teste@teste.com.br']);

    return result.length;
  }

  static Future<bool> getByEmailPassword(String email, String password) async {
    final db = await SQLHelper.getDatabase();

    var result = await db.rawQuery(
        'SELECT * FROM login where email=? and password=?', [email, password]);

    return result.isNotEmpty ? true : false;
  }
}
