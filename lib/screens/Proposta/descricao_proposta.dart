import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/models/proposta_model.dart';
import 'package:sisparty/screens/Proposta/proposta_fornecedor.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

import '../Evento/eventos_cliente.dart';

class DescricaoProposta extends StatefulWidget {
  final Proposta proposta;

  DescricaoProposta(this.proposta);

  @override
  _DescricaoPropostasState createState() => _DescricaoPropostasState();
}

class _DescricaoPropostasState extends State<DescricaoProposta> {
  @override
  void initState() {
    super.initState();
    _verificar_fornecedor().then((value) => _is_fornecedor = value);
  }

  bool _is_fornecedor = false;

  Future<dynamic> _verificar_fornecedor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final type_user = pref.getString("type_user");
    if (type_user == "Fornecedor") {
      return true;
    } else {
      return false;
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
              future: _verificar_fornecedor(),
              // ignore: missing_return
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.data == true) {
                  return RaisedButton(
                    onPressed: () {
                      print("Deletar");
                    },
                    child: Text("Cancelar proposta"),
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
}
