import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  MySqlConnection? _connectionDB;

  Future<MySqlConnection> get connectionDB async {
    if (_connectionDB == null) {
      final settings = ConnectionSettings(
        host: 'localhost',
        port: 8889,
        user: 'root',
        password: 'root',
        db: 'users_examen_flutter',
      );
      _connectionDB = await MySqlConnection.connect(settings);
    }
    return _connectionDB!;
  }
}