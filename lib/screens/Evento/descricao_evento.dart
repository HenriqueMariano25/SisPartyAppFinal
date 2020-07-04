import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/Evento/eventos.dart';
import 'package:sisparty/screens/Evento/eventos_cliente.dart';
import 'package:sisparty/screens/Proposta/evento_propostas.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

import '../Proposta/criar_proposta.dart';
//import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class DescricaoEvento extends StatefulWidget {
  final Evento evento;

  DescricaoEvento(this.evento);

  @override
  _DescricaoEventoState createState() => _DescricaoEventoState();
}

class _DescricaoEventoState extends State<DescricaoEvento> {
  @override
  void initState() {
    super.initState();
    _verificar_fornecedor().then((value) => _is_fornecedor = value);
  }

  bool _is_fornecedor = false;

  Future<dynamic> _verificar_fornecedor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final type_user = pref.getString("type_user");
//    print(type_user);
//    print(type_user == "Fornecedor");
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
          title: Text("Evento"),
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
                    builder: (context) => EventosCliente(),
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
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => EventoPropostas(widget.evento.id),
                    ),
                  );
                },
                child: Text("Ver propostas"),
              ),
              Text(
                widget.evento.nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Data de realização: ${widget.evento.dataRealizacao}'),
              Text('Tipo de evento: ${widget.evento.tipoEventoId}'),
              Text('Já tem local do evento ? ${widget.evento.local}'),
              Text('Região:'),
              Text('Descriçao: ${widget.evento.descricao}'),
              FutureBuilder(
                future: _verificar_fornecedor(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == true) {
                    return RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CriarProposta(widget.evento),
                          ),
                        );
                      },
                      child: Text("Criar proposta"),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            closedEvent(widget.evento.id);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Eventos(),
                              ),
                            );
                          },
                          child: Text("Fechar evento"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CriarProposta(widget.evento),
                              ),
                            );
                          },
                          child: Text("Excluir evento"),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
