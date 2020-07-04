import 'package:flutter/material.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/screens/Evento/eventos.dart';

class CriarEvento extends StatefulWidget {
  @override
  _CriarEventoState createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  final _formKey = GlobalKey<FormState>();

  final _nomeEventoController = TextEditingController();
  final _dataRealizacaoController = TextEditingController();
  final _descricaoEventoController = TextEditingController();
  final _tipoEventoController = TextEditingController();
  final _localController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar proposta",
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Eventos(),
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
                    "Criar evento",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _nomeEventoController,
                    decoration: InputDecoration(
                      labelText: "Nome do evento",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _dataRealizacaoController,
                    decoration: InputDecoration(
                      labelText: "Data de realização",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextField(
                    controller: _descricaoEventoController,
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Descrição do evento",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _tipoEventoController,
                    decoration: InputDecoration(
                      labelText: "Tipo do evento",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _localController,
                    decoration: InputDecoration(
                      labelText: "Tem local ?",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var userData = {
                          "name": _nomeEventoController.text,
                          "description": _dataRealizacaoController.text,
                          "realization_date": _descricaoEventoController.text,
                          "type": _tipoEventoController.text,
                          "local": _localController.text,
                          "situation": "Em aberto"
                        };
                        _criarEvento(userData);
                      }
                    },
                    child: Text("Criar"),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  _criarEvento(data) async {
    try {
      criarEvento(data);
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
