import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/models/proposta_model.dart';
import 'package:sisparty/screens/Proposta/proposta_fornecedor.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';
import 'package:sisparty/http/propostasWebclient.dart';

class DescricaoPropostaSimples extends StatefulWidget {
  final Proposta proposta;

  DescricaoPropostaSimples(this.proposta);

  @override
  _DescricaoPropostaSimplesState createState() =>
      _DescricaoPropostaSimplesState();
}

class _DescricaoPropostaSimplesState extends State<DescricaoPropostaSimples> {
  var _heightEvent = 0.0;

  @override
  void initState() {
    super.initState();
    _verificarPropostas().then((value) => _isAceita = value);
  }

  bool _isAceita = false;

  Future _verificarPropostas() async {
    if (widget.proposta.situation == "Aceita") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Descrição da proposta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Voltar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PropostaFornecedor(),
                ),
              );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text(
              widget.proposta.service,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Descrição geral: ${widget.proposta.description}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Descrição do serviço: ${widget.proposta.serviceDescription}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Valor: ${widget.proposta.value}",
              style: TextStyle(fontSize: 20.0),
            ),
            FutureBuilder(
              future: _verificarPropostas(),
              // ignore: missing_return
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.data == true) {
                  return Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          acceptProposal(widget.proposta.id);
                        },
                        child: Text("Aceitar proposta"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          declinedProposal(widget.proposta.id);
                        },
                        child: Text("Recusar proposta"),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _aceitarProposta(id) {
    acceptProposal(id);
  }
}
