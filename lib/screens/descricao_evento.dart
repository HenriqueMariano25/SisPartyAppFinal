import 'package:flutter/material.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/eventos_cliente.dart';

class DescricaoEvento extends StatelessWidget {
  final Evento evento;

  DescricaoEvento(this.evento);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Evento"),
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
                    builder: (context) => EventoListaCliente(),
                  ),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Text(
                evento.nome,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
              ),
              Text('Data de realização: ${evento.dataRealizacao}'),
              Text('Tipo de evento: ${evento.tipoEventoId}'),
              Text('Já tem local do evento ? ${evento.local}'),
              Text('Região:'),
              Text('Descriçao: ${evento.descricao}')
            ],
          ),
        ));
  }
}
