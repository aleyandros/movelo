import 'package:flutter/material.dart';

import 'package:movelo/login.dart';
import 'package:movelo/signup.dart';
import 'package:movelo/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
        Index.id: (context) => Index(),
      },
    );
  }
}
