import 'package:flutter/material.dart';
import 'package:sisparty/consultas/eventos_consultas.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/Evento/descricao_evento.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class EventosFornecedor extends StatefulWidget {
  @override
  _EventosFornecedorState createState() => _EventosFornecedorState();
}

class _EventosFornecedorState extends State<EventosFornecedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
          future: todosEventosFornecedor(),
          builder: (context, snapshot) {
            final List<Evento> eventosAbertos = snapshot.data['eventos'];
            return ListView.builder(
                itemCount: eventosAbertos.length,
                itemBuilder: (context, index) {
                  final Evento eventoAberto = eventosAbertos[index];
                  return Card(
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DescricaoEvento(eventoAberto),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(eventoAberto.nome),
                        subtitle: Text(eventoAberto.descricao),
                      ),
                    ),
                  );
                });
          }),
      // body: FutureBuilder(
      //   future: todosEventosFornecedor(),
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         break;
      //       case ConnectionState.waiting:
      //         return CircularProgressIndicator();
      //       case ConnectionState.active:
      //         break;
      //       case ConnectionState.done:
      //         if (snapshot.hasData) {
      //           final List<Evento> eventos = snapshot.data;
      //           return ListView.builder(
      //               itemCount: eventos.length,
      //               itemBuilder: (context, index) {
      //                 final Evento evento = eventos[index];
      //                 return Card(
      //                   child: new InkWell(
      //                     onTap: () {
      //                       print('clicado: ${evento.nome}');
      //                       print('id: ${evento.id}');
      //                       Navigator.of(context).pushReplacement(
      //                         MaterialPageRoute(
      //                           builder: (context) => DescricaoEvento(evento),
      //                         ),
      //                       );
      //                       findEvento(evento.id);
      //                     },
      //                     child: ListTile(
      //                       title: Text(evento.nome),
      //                     ),
      //                   ),
      //                 );
      //               });
      //         }
      //     }
      //   },
      // ),
    );
  }
}
