import 'package:flutter/material.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';

import '../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_app_bar.dart';

class user_information_page extends StatefulWidget {
  final User user;

  user_information_page({super.key, required this.user});

  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<user_information_page> {
  late int originalUserID;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    originalUserID = widget.user.userID!;
    _idController = TextEditingController(text: widget.user.userID.toString());
    _nameController = TextEditingController(text: widget.user.userName);
    _passwordController = TextEditingController(text: widget.user.userPassword);
  }

  void _updateUserInfo() async {
    UserRepository userRepository = UserRepository();

    User updatedUser = User(
      userID: int.parse(_idController.text),
      userName: _nameController.text,
      userPassword: _passwordController.text,
    );

    await userRepository.updateUser(updatedUser, originalUserID);

    // Montrer un message à l'utilisateur
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informations de l\'utilisateur mises à jour !'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Bonjour ${_nameController.text} !"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: "UserID"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "UserName"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "User Password"),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: _updateUserInfo,
                    text: 'Enregistrer',
                    textStyle: kButtonTextStyle,
                  ),
                ),
                SizedBox(width: 20), // Espacement entre les boutons
                Expanded(
                  child: CustomButton(
                    onPressed: _updateUserInfo,
                    text: 'Modifier',
                    textStyle: kButtonTextStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
