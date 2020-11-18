import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movelo/index.dart';
import 'package:movelo/login.dart';
import 'package:movelo/signup.dart';
import 'DirectionProvider.dart';
import 'package:movelo/panico.dart';
import 'package:movelo/plants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => DirectionProvider(),
      child: MaterialApp(
        initialRoute: Index.id,
        routes: {
          Login.id: (context) => Login(),
          Signup.id: (context) => Signup(),
          Index.id: (context) => Index(),
          Panico.id: (context) => Panico(),
          Plants.id: (context) => Plants(),
        },
      ),
    );
  }
}

class AskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fasty - Delivery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Desde: Pizzeria',
            ),
            Text(
              'Hasta: Roca 123',
            ),
            FlatButton(
              child: Text("Aceptar Viaje"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
