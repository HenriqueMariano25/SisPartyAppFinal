import 'package:flutter/material.dart';
import 'package:sisparty/http/propostasWebclient.dart';
import 'screens/inicial.dart';
import 'screens/Sessao/login.dart';
import 'screens/Evento/eventos_cliente.dart';
import 'http/webclient.dart';

void main() {
  runApp(new MyApp());
  findAllProposals();
//  findAllEventos().then((eventos) => print('novos eventos $eventos'));
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
