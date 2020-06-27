import 'package:flutter/material.dart';
import 'screens/inicial.dart';
import 'screens/login.dart';
import 'screens/eventos_cliente.dart';
import 'http/webclient.dart';

void main() {
  runApp(new MyApp());
  findAllEventos().then((eventos) => print('novos eventos $eventos'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SysParty",
      theme: ThemeData(
//      primarySwatch: Colors.blue,
        primaryColor: Colors.pink,
        backgroundColor: Colors.white,
      ),
      home: Login(),
    );
  }
}
