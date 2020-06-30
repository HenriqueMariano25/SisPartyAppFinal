import 'package:flutter/material.dart';
import 'package:sisparty/http/propostasWebclient.dart';
import 'package:sisparty/models/evento_model.dart';

import 'descricao_evento.dart';

class CriarProposta extends StatefulWidget {
  final Evento evento;

  CriarProposta(this.evento);

  @override
  _CriarPropostaState createState() => _CriarPropostaState();
}

class _CriarPropostaState extends State<CriarProposta> {
  final _formKey = GlobalKey<FormState>();

  final _descricaoGeralController = TextEditingController();

  final _servicoPrestadoController = TextEditingController();

  final _descricaoServicoController = TextEditingController();

  final _valorController = TextEditingController();

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
                  builder: (context) => DescricaoEvento(widget.evento),
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
                    "Criar proposta",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _descricaoGeralController,
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Descrição geral",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _servicoPrestadoController,
                    decoration: InputDecoration(
                      labelText: "Serviço Prestado",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _descricaoServicoController,
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: "Descrição do serviço",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextFormField(
                    controller: _valorController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Valor",
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var userData = {
                          "description": _descricaoGeralController.text,
                          "service": _servicoPrestadoController.text,
                          "service_description":
                              _descricaoServicoController.text,
                          "value": _valorController.text,
                          "event": widget.evento.id.toString()
                        };
                        _enviar_proposta(userData);
                      }
                    },
                    child: Text("Enviar proposta"),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  _enviar_proposta(data) async {
    try {
      createProposals(data);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DescricaoEvento(widget.evento),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
