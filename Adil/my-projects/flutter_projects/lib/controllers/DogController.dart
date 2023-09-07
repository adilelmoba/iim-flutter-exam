import 'package:mysql1/mysql1.dart';
import '../models/Dog.dart';

class DogController {
  MySqlConnection? _connection;

  Future<MySqlConnection> get connection async {
    if (_connection == null) {
      final settings = ConnectionSettings(
        host: 'localhost',
        port: 8889,
        user: 'root',
        password: 'root',
        db: 'dogs',
      );
      _connection = await MySqlConnection.connect(settings);
    }
    return _connection!;
  }

  Future<void> insertDog(Dog dog) async {
    final conn = await connection;
    await conn.query(
        'INSERT INTO dogs (name, age) VALUES (?, ?)', [dog.name, dog.age]);
  }

  Future<List<Dog>> fetchDogs() async {
    final conn = await connection;
    final results = await conn.query('SELECT id, name, age FROM dogs');

    List<Dog> dogs = [];
    for (var row in results) {
      dogs.add(Dog(id: row[0] as int, name: row[1] as String, age: row[2] as int));
    }
    return dogs;
  }

  Future<void> updateDog(Dog dog) async {
    if (dog.id == null) return;

    final conn = await connection;
    await conn.query('UPDATE dogs SET name = ?, age = ? WHERE id = ?', [dog.name, dog.age, dog.id]);
  }

  Future<void> deleteDog(int id) async {
    final conn = await connection;
    await conn.query('DELETE FROM dogs WHERE id = ?', [id]);
  }

  Future<void> closeConnection() async {
    await _connection?.close();
  }
}
