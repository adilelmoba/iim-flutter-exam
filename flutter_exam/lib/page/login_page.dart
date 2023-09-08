import 'package:flutter/material.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';
import '../utils/user_id_generator.dart';

import './user_information_page.dart';

import '../utils/styles.dart';
import '../widgets/custom_button.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ensureDatabaseTable();
  }

  void _ensureDatabaseTable() async {
    UserRepository userRepository = UserRepository();
    await userRepository.ensureTableCreated();
  }

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      int userID = await generateUserID();
      User newUser = User(
        userID: userID,
        userName: userNameController.text,
        userPassword: passwordController.text,
      );

      // Insérer l'utilisateur dans la base de données
      UserRepository userRepository = UserRepository();
      await userRepository.addUser(newUser);

      // Réinitialisez les données du formulaire
      userNameController.clear();
      passwordController.clear();

      // Naviguer vers la page d'information de l'utilisateur
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => user_information_page(user: newUser)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Let\'s sign you in!'
                  ,textAlign: TextAlign.center
                  ,style: kTitleTextStyle),
              const Text('Welcome back! \n You\'ve been missed!'
                  ,textAlign: TextAlign.center
                  ,style: kSubtitleTextStyle),
              Image.asset(
                'assets/login_page_img.png',
                height: 200,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Your username should be more than 5 characters";
                        } else if (value != null && value.isEmpty) {
                          return "Please type your username";
                        }
                        return null;
                      },
                      controller: userNameController,
                      decoration: const InputDecoration(
                          hintText: 'Add your username',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Please type your password";
                        } else if (value != null && value.length < 8) {
                          return "Password should be at least 8 characters long";
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Type your password',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: loginUser,
                text: 'Login',
                textStyle: kButtonTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to browser or do something else
                  print('Link clicked!');
                },
                child: const Column(
                  children: [
                    Text('Find us on'),
                    Text('https://poojabhaumik.com'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}