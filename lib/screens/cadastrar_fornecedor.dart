import 'package:flutter/material.dart';
import 'package:sisparty/screens/escolher_cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class CadastrarFornecedor extends StatefulWidget {
  @override
  _CadastrarFornecedorState createState() => _CadastrarFornecedorState();
}

class _CadastrarFornecedorState extends State<CadastrarFornecedor> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cpfcnpjController = TextEditingController();
  final _dateBirthController = TextEditingController();
  final _addressController = TextEditingController();

  var _email = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar-se como Fornecedor"),
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
          ),
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
                  "Fornecedor de Serviço",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                _buildTextField(
                    "Nome", TextInputType.text, false, _nameController),
                TextFormField(onSaved: (value) => _email = value,decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black54, fontSize: 20.0)),),
                TextFormField(onSaved: (value) => _password = value,decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.black54, fontSize: 20.0)),
                  obscureText: true,),
                _buildTextField("Confirmar Senha", TextInputType.text, true,
                    _confirmPasswordController),
                _buildTextField(
                    "CPF/CNPJ", TextInputType.text, false, _cpfcnpjController),
                _buildTextField("Data de Nascimento", TextInputType.text, false,
                    _dateBirthController),
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
                        _entrar();
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "endereco": _addressController.text,
                          "cpfcnpj": _cpfcnpjController.text,
                          "nascimento": _dateBirthController.text,
                          "tipo": "Fornecedor"
                        };
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
  _entrar() async{
    _formKey.currentState.save();

    try {
      print(_email);
      print(_password);
      await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Login()));
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
        labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 20.0)),
    obscureText: teste,
  );
}
