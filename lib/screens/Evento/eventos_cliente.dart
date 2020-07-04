import 'package:flutter/material.dart';
import 'package:sisparty/consultas/eventos_consultas.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/http/eventosWebclient.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/Evento/criar_evento.dart';
import 'package:sisparty/screens/Evento/descricao_evento.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class EventosCliente extends StatefulWidget {
  @override
  _EventosClienteState createState() => _EventosClienteState();
}

class _EventosClienteState extends State<EventosCliente> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Eventos"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'Em aberto'),
              Tab(text: 'Fechados'),
              Tab(text: 'Finalizados'),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(children: <Widget>[
          Column(children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CriarEvento(),
                  ),
                );
              },
              child: Text("Criar evento"),
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                    future: todosEventosCliente(),
                    builder: (context, snapshot) {
                      final List<Evento> eventosAbertos =
                          snapshot.data['events_accepts'];
                      return ListView.builder(
                          itemCount: eventosAbertos.length,
                          itemBuilder: (context, index) {
                            final Evento eventoAberto = eventosAbertos[index];
                            return Card(
                              child: new InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DescricaoEvento(eventoAberto),
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
              ),
            )
          ]),
          Container(),
          Container(),
        ]),
      ),
    );
    /* Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<Evento>>(
        future: findAllEventos(),
        builder: (context, snapshot) {
          final List<Evento> eventos = snapshot.data;
          return ListView.builder(itemBuilder: (context, index) {
            final Evento evento = eventos[index];
            return Card(
              child: new InkWell(
                onTap: () {
                  print('clicado: ${evento.nome}');
                  print('id: ${evento.id}');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DescricaoEvento(evento),
                    ),
                  );
                  findEvento(evento.id);
                },
                child: ListTile(
                  title: Text(evento.nome),
                ),
              ),
            );
          });
        },
      ),
    ); */
  }
}
