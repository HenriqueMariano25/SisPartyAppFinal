import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/http/sessionWebclient.dart';
import 'package:sisparty/screens/Evento/eventos.dart';
import 'package:sisparty/screens/Sessao/escolher_cadastro.dart';
import 'package:sisparty/screens/Evento/eventos_cliente.dart';

import '../Evento/eventos_fornecedor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || text.contains("@"))
                    return "E-mail invalido";
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                child: Text(
                  "Logar-se",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.pink,
                onPressed: () {
                  var userData = {
                    "email": _emailController.text,
                    "password": _passwordController.text,
                  };
                  _entrar(userData);
                },
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text(
                    "Não tem conta ? Cadastrar-se",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => EscolherCadastro(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _entrar(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final res_return = entrar(data);
      res_return.then((result) {
        if (result['result'] == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Eventos(),
            ),
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
