import 'package:flutter/material.dart';
import 'dart:io';

import 'package:mobile_dtr_prototype/constants/routes.dart';
import 'package:mobile_dtr_prototype/http/base_client.dart';
import 'package:mobile_dtr_prototype/http/http_routes.dart';
import 'package:mobile_dtr_prototype/models/login_credentials.dart';
import 'dart:developer' as devtools show log;

import 'package:mobile_dtr_prototype/ui/alert_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();

  Future logIn() async {
    final username = _username.text;
    final password = _password.text;

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var loginCredentials =
        LoginCredentials(username: username, password: password);

    var response = await BaseClient(context)
        .loginUser(loginCredentials)
        .catchError((err) {});

    if (_formKey.currentState!.validate()) {
      devtools.log(response.toString());
      switch (response) {
        case null:
          Navigator.of(context).pop();
          return showAlertDialog(
              context,
              "Login Error",
              'Wrong username or password. Please check you have typed your correct username and password',
              loginRoute);
        case "Error":
          Navigator.of(context).pop();
          return showAlertDialog(
              context,
              "Connection Error",
              "Currently not connected to the internet. \n\n Please check your internet connection",
              loginRoute);
        case "Timeout":
          Navigator.of(context).pop();
          return showAlertDialog(
              context,
              "Server Unreachable",
              "Response from the server took too long. \n\n Server may be currently down",
              loginRoute);
        default:
          Navigator.of(context).pop();
          return showAlertDialog(
              context, "Login", "Successfully logged in!", homePageRoute);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        // appBar: AppBar(
        //   title: const Text('Login', style: TextStyle(color: Colors.white)),
        //   backgroundColor: Colors.blue,
        // ),
        body: Container(
          margin: EdgeInsets.only(top:20),
          width:double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                //This is the main container for the login
                children: <Widget>[
                  const SizedBox(height: 40), //I used SizedBox for spacing
                  Card(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.50),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/DOH_icon.jpg'))),
                    ),
                  ),
                  const Text(
                    'Mobile DTR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), //I used SizedBox for spacing
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please type your username';
                        }
                        return null;
                      },
                      controller:
                          _username, //I used the _email from the TextEditingController to manually control the input
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'Enter your username',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), //I used SizedBox for spacing
                  SizedBox(
                    width:300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please type your password';
                        }
                        return null;
                      },
                      controller:
                          _password, //I used the _password from the TextEditingController to manually control the input
                      obscureText: _hidePassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(_hidePassword
                                ? Icons.visibility
                                : Icons
                                    .visibility_off), //If _hidePassword is false, it will show the open-eye icon, if true instead, it will show the closed-eye icon
                            onPressed: () {
                              setState(() {
                                _hidePassword =
                                    !_hidePassword; //To set the _hidePassword variable to change it to change the visibility icon's appearance
                              });
                            },
                          )),
                    ),
                  ),
                  const SizedBox(height: 10), //SizedBox for spacing
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.transparent),
                        shadowColor: Colors.black,
                        backgroundColor: Colors.blue[500],
                        padding: const EdgeInsets.symmetric(horizontal: 60.0)),
                    onPressed: () => logIn(),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
