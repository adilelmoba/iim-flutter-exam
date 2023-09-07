import 'package:flutter/material.dart';

import 'models/Dog.dart';
import 'controllers/DogController.dart';

import 'views/AddDogPage.dart';
import 'views/EditDogPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dogs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DogsPage(),
    );
  }
}

class DogsPage extends StatefulWidget {
  const DogsPage({super.key});

  @override
  _DogsPageState createState() => _DogsPageState();
}

class _DogsPageState extends State<DogsPage> {
  final DogController _controller = DogController();
  List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    List<Dog> dogs = await _controller.fetchDogs();
    setState(() {
      _dogs = dogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dogs App'),
      ),
      body: ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          Dog dog = _dogs[index];
          return ListTile(
            title: Text(dog.name),
            subtitle: Text('Age: ${dog.age}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDogPage(dog: dog),
                      ),
                    ).then((_) {
                      _loadDogs();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _controller.deleteDog(dog.id!);
                    _loadDogs();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDogPage()),
          ).then((_) {
            _loadDogs();
          });
        },
      ),
    );
  }
}
