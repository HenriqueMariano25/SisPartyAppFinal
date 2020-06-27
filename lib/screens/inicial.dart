import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sisparty/screens/cadastrar_cliente.dart';
import 'login.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _navegate();
  }
  _navegate() async{
    await Future.delayed(Duration(seconds: 1));

    final user = await _auth.currentUser();
    if (user != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CadastrarCliente(),
        ),
      );
    } else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
    //    await Future.delayed(Duration(seconds: 3));

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
