import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/cadastrar_cliente.dart';
import 'eventos_cliente.dart';
import 'eventos_fornecedor.dart';
import 'login.dart';

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
    final token = pref.getString("token");
    final client = pref.getString("client");
    final uid = pref.getString("uid");
    final type_user = pref.getString("type_user");
    print(token);
    print(client);
    print(uid);
    if(token != null && client != null && uid != null){
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
