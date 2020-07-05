import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sisparty/http/propostasWebclient.dart';
import 'package:sisparty/scoped_model/user_model.dart';
import 'screens/inicial.dart';
import 'screens/Sessao/login.dart';
import 'screens/Evento/eventos_cliente.dart';
import 'http/eventosWebclient.dart';

void main() {
  runApp(new MyApp());
//  findAllEventos().then((eventos) => print('novos eventos $eventos'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(
      model: UsuarioModel(),
      child: MaterialApp(
        title: "SysParty",
        theme: ThemeData(
//      primarySwatch: Colors.blue,
          primaryColor: Colors.pink,
          backgroundColor: Colors.white,
        ),
        home: Login(),
      ),
    );
  }
}
