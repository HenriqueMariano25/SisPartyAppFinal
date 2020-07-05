import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/Evento/eventos.dart';
import 'package:sisparty/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/http/sessionWebclient.dart';

import 'escolher_cadastro.dart';
import '../Evento/eventos_cliente.dart';
import 'login.dart';

class CadastrarCliente extends StatefulWidget {
  @override
  _CadastrarClienteState createState() => _CadastrarClienteState();
}

class _CadastrarClienteState extends State<CadastrarCliente> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cpfcnpjController = TextEditingController();
  final _dateBirthController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> to() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString("teste", "valueteste");
  }

  Future<String> load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("teste");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar-se como Cliente"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => EscolherCadastro(),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10.0, top: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Cadastrar-se como",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Cliente",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                _buildTextField(
                    "Nome", TextInputType.text, false, _nameController),
                _buildTextField(
                    "Email", TextInputType.text, false, _emailController),
                _buildTextField(
                    "Senha", TextInputType.text, true, _passwordController),
                _buildTextField("Confirmar Senha", TextInputType.text, true,
                    _confirmPasswordController),
                _buildTextField(
                    "CPF/CNPJ", TextInputType.text, false, _cpfcnpjController),
                _buildTextField(
                    "Endereço", TextInputType.text, false, _addressController),
                Divider(),
                Container(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() &&
                          _passwordController.text ==
                              _confirmPasswordController.text) {
                        var userData = {
                          "email": _emailController.text,
                          "name": _nameController.text,
                          "password": _passwordController.text,
                          "password_confirmation":
                              _confirmPasswordController.text,
//                          "address": _addressController.text,
//                          "cpfcnpj": _cpfcnpjController.text,
                          "type_user": "Cliente"
                        };
                        _entrar(userData);
                      }
                    },
                    color: Colors.pink,
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _entrar(data) async {
    try {
      criarUsuario(data);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Eventos(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

Widget _buildTextField(String labelText, TextInputType keyBoard, bool teste,
    TextEditingController cont) {
  return TextFormField(
    controller: cont,
    keyboardType: keyBoard,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black54, fontSize: 20.0)),
    obscureText: teste,
  );
}
