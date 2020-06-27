import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sisparty/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/http/sessionWebclient.dart';

import 'escolher_cadastro.dart';
import 'eventos_cliente.dart';
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
  final _auth = FirebaseAuth.instance;

  var _email = "";
  var _password = "";

  Future<bool>to() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString("teste", "valueteste");
  }

  Future<String>load() async{
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
                _buildTextField("Email", TextInputType.text, false,
                    _emailController),
                _buildTextField("Senha", TextInputType.text, true,
                    _passwordController),
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
                          "password_confirmation": _confirmPasswordController
                              .text,
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
    try{
      criarUsuario(data);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EventoListaCliente(),
        ),
      );
    }catch(e){
      print(e);
    }
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    print(pref.getString("teste"));
//    print(load().toString());
//    final _dio = Dio(BaseOptions(baseUrl: BASEURL));
//
//    _dio.options.headers['Accept'] = "application/vnd.api+json";
//    _dio.options.headers['Content-Type'] = "application/json";
//    var response = await _dio.post('auth', data: data);
//    print(response.headers["access-token"]);
  }
//    responseInterceptor(Response response) {
//      dynamic responseInterceptor(Response options) async {
//        if (options.headers.value("verifyToken") != null) {
//          //if the header is present, then compare it with the Shared Prefs key
//          SharedPreferences prefs = await SharedPreferences.getInstance();
//          var verifyToken = prefs.get("VerifyToken");
//
//          // if the value is the same as the header, continue with the request
//          if (options.headers.value("verifyToken") == verifyToken) {
//            return options;
//          }
//        }
//
//      }

//    _dio.options.headers['Accept'] = "application/vnd.api+json";
//    final resp = await  _dio.get('/events');
//
//    _formKey.currentState.save();
//
//    try {
//      print(_email);
//      print(_password);
//      await _auth.createUserWithEmailAndPassword(
//          email: _email,
//          password: _password);
//      Navigator.of(context).pushReplacement(
//          MaterialPageRoute(
//              builder: (context) => Login()));
//    } catch (e) {
//      print(e);
//    }
//  }
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