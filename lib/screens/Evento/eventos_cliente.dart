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
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar evento",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CriarEvento(),
                  ),
                );
              },
            )
          ],
        ),
        drawer: CustomDrawer(),
        body: TabBarView(children: <Widget>[
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                    future: todosEventosCliente(),
                    builder: (context, snapshot) {
                      final List<Evento> eventos =
                          snapshot.data['eventos_abertos'];
                      return ListView.builder(
                          itemCount: eventos.length,
                          itemBuilder: (context, index) {
                            final Evento evento = eventos[index];
                            return Card(
                              child: new InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DescricaoEvento(evento),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(evento.nome),
                                  subtitle: Text(evento.descricao),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            )
          ]),
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                    future: todosEventosCliente(),
                    builder: (context, snapshot) {
                      final List<Evento> eventos =
                          snapshot.data['eventos_fechados'];
                      return ListView.builder(
                          itemCount: eventos.length,
                          itemBuilder: (context, index) {
                            final Evento evento = eventos[index];
                            return Card(
                              child: new InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DescricaoEvento(evento),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(evento.nome),
                                  subtitle: Text(evento.descricao),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            )
          ]),
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                    future: todosEventosCliente(),
                    builder: (context, snapshot) {
                      final List<Evento> eventos =
                          snapshot.data['eventos_finalizados'];
                      // if(eventos)
                      return ListView.builder(
                          itemCount: eventos.length,
                          itemBuilder: (context, index) {
                            final Evento evento = eventos[index];
                            return Card(
                              child: new InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DescricaoEvento(evento),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(evento.nome),
                                  subtitle: Text(evento.descricao),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            )
          ]),
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
