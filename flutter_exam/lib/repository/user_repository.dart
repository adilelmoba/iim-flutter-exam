import 'package:mysql1/mysql1.dart';

import '../data_base/db_helper.dart';
import '../model/user.dart';

class UserRepository {
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  Future<MySqlConnection> get database async => await _databaseConnection.connectionDB;

  Future<void> ensureTableCreated() async {
    final conn = await database;
    await conn.query('''
      CREATE TABLE IF NOT EXISTS users (
        userID INT PRIMARY KEY,
        userName VARCHAR(255) NOT NULL,
        userPassword VARCHAR(255) NOT NULL
      )
    ''');
  }

  Future<void> addUser(User user) async {
    final conn = await database;
    await conn.query(
      'INSERT INTO users (userID, userName, userPassword) VALUES (?, ?, ?)',
      [user.userID, user.userName, user.userPassword],
    );
  }

  Future<List<User>> fetchUsers() async {
    final conn = await database;
    final results = await conn.query('SELECT * FROM users');

    return results.map((row) => User(
      userID: row['userID'],
      userName: row['userName'],
      userPassword: row['userPassword'],
    )).toList();
  }

  Future<void> updateUser(User user, int originalUserID) async {
    final conn = await database;
    await conn.query(
      'UPDATE users SET userID = ?, userName = ?, userPassword = ? WHERE userID = ?',
      [user.userID, user.userName, user.userPassword, originalUserID],
    );
  }

  Future<void> deleteUser(int userID) async {
    final conn = await database;
    await conn.query('DELETE FROM users WHERE userID = ?', [userID]);
  }

  Future<int> getLastUserId() async {
    final conn = await database;
    final results = await conn.query('SELECT userID FROM users ORDER BY userID DESC LIMIT 1');

    if (results.isNotEmpty) {
      return results.first['userID'];
    } else {
      return 1;
    }
  }
}
