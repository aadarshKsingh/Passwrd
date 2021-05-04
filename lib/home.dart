import 'package:flutter/material.dart';
import 'package:passwrd/generatePassword.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Passwrd",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: generatePassword());
  }
}
