import 'package:flutter/material.dart';

import '../controllers/DogController.dart';
import '../models/Dog.dart';

class AddDogPage extends StatefulWidget {
  @override
  _AddDogPageState createState() => _AddDogPageState();
}

class _AddDogPageState extends State<AddDogPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text('Add Dog'),
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _ageController.text.isNotEmpty) {
                  var dog = Dog(
                      name: _nameController.text,
                      age: int.parse(_ageController.text));
                  await DogController().insertDog(dog);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
