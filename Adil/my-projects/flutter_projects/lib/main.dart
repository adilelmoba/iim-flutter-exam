import 'package:flutter/material.dart';

import 'models/Dog.dart';
import 'controllers/DogController.dart';

import 'views/AddDogPage.dart';
import 'views/EditDogPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dogs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogsPage(),
    );
  }
}

class DogsPage extends StatefulWidget {
  @override
  _DogsPageState createState() => _DogsPageState();
}

class _DogsPageState extends State<DogsPage> {
  DogController _controller = DogController();
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
        title: Text('Dogs App'),
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
                  icon: Icon(Icons.edit),
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
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _controller.deleteDog(dog.id!); // Assuming ID is non-null for fetched dogs
                    _loadDogs();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
