import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/Sessao/cadastrar_cliente.dart';
import 'Evento/eventos_cliente.dart';
import 'Evento/eventos_fornecedor.dart';
import 'Sessao/login.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  @override
  void initState(){
    super.initState();
    _authenticated();
  }

  _authenticated() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final type_user = pref.getString("type_user");
    final authenticated = pref.getString("authenticated");
    if(authenticated == "true"){
      if(type_user == "Cliente"){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EventoListaCliente(),
          ),
        );
      }else{
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EventoListaFornecedor(),
          ),
        );

      }
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
