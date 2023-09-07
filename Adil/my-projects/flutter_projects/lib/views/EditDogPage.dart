import 'package:flutter/material.dart';

import '../controllers/DogController.dart';
import '../models/Dog.dart';

class EditDogPage extends StatefulWidget {
  final Dog dog;

  EditDogPage({required this.dog});

  @override
  _EditDogPageState createState() => _EditDogPageState();
}

class _EditDogPageState extends State<EditDogPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.dog.name;
    _ageController.text = widget.dog.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Dog'),
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
              child: Text('Update Dog'),
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _ageController.text.isNotEmpty) {
                  var dog = Dog(
                      id: widget.dog.id,
                      name: _nameController.text,
                      age: int.parse(_ageController.text));
                  await DogController().updateDog(dog);
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
