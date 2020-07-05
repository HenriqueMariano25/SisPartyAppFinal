import 'package:flutter/material.dart';
import 'package:sisparty/screens/perfil.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class AlterarSenha extends StatefulWidget {
  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
  final _senhaAntigaController = TextEditingController();
  final _senhaNovaController = TextEditingController();
  final _confirmarSenhaNovaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar senha"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Perfil(),
                ),
              );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _passwordField("Senha atual", _senhaAntigaController),
            _passwordField("Nova senha", _senhaAntigaController),
            _passwordField("Confirmar nova senha", _senhaAntigaController),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate() &&
                    _senhaNovaController.text ==
                        _confirmarSenhaNovaController.text) {
                  var data = {
                    "senha_atual": _senhaAntigaController.text,
                    "nova_senha": _senhaNovaController.text,
                  };
                }
              },
              child: Text("Alterar"),
            )
          ],
        ),
      ),
    );
  }

  _alterarSenha(data) {}
}

Widget _passwordField(String labelText, TextEditingController cont) {
  return TextFormField(
    controller: cont,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black54, fontSize: 20.0)),
    obscureText: true,
  );
}
