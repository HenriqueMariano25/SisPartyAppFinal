import 'package:flutter/material.dart';
import 'package:sisparty/http/contasBancariasWebclient.dart';
import 'package:sisparty/screens/ContaBancaria/gerenciar_contas.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class AdicionarConta extends StatefulWidget {
  @override
  _AdicionarContaState createState() => _AdicionarContaState();
}

class _AdicionarContaState extends State<AdicionarConta> {
  final _nomeResposavelController = TextEditingController();
  final _agenciaController = TextEditingController();
  final _contaController = TextEditingController();
  final _cpfcnpjController = TextEditingController();
  final _bancoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar conta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => CriarEvento(),
              //   ),
              // );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _textField("Nome do responsavel", _nomeResposavelController),
            _textField("Agencia", _agenciaController),
            _textField("Conta", _contaController),
            _textField("CPF/CNPJ", _cpfcnpjController),
            _textField("Banco", _bancoController),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  var userData = {
                    "agency": _agenciaController.text,
                    "account": _contaController.text,
                    "bank": _bancoController.text,
                    "responsible_name": _nomeResposavelController.text,
                    "cpfcpnj": _cpfcnpjController.text,
                  };
                  _adicionarConta(userData);
                }
              },
              child: Text("Adicionar"),
            )
          ],
        ),
      ),
    );
  }

  _adicionarConta(data) {
    addBankAccount(data);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GerenciarContasBancarias(),
      ),
    );
  }
}

Widget _textField(String labelText, TextEditingController cont) {
  return TextFormField(
    controller: cont,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black54, fontSize: 20.0)),
  );
}
