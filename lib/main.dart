import 'package:flutter/material.dart';
import 'package:passwrd/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: passwrd()));
}

class passwrd extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Passwrd', theme: ThemeData(), home: Home());
  }
}
