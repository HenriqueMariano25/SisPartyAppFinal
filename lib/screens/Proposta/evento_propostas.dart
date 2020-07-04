import 'package:flutter/material.dart';
import 'package:sisparty/models/proposta_model.dart';
import 'package:sisparty/screens/Proposta/descricao_proposta.dart';
import 'package:sisparty/screens/Proposta/descricao_proposta_simples.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';
import 'package:sisparty/http/propostasWebclient.dart';

class EventoPropostas extends StatefulWidget {
  final int id;

  EventoPropostas(this.id);

  @override
  _EventoPropostasState createState() => _EventoPropostasState();
}

class _EventoPropostasState extends State<EventoPropostas> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Propostas"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'Recebidas'),
              Tab(text: 'Aceitas'),
              Tab(text: 'Recusadas'),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(children: <Widget>[
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: eventoPropostas(widget.id),
                  builder: (context, snapshot) {
                    final List<Proposta> propostas =
                        snapshot.data['propostas_recebidas'];
                    debugPrint(propostas.length.toString());
                    if (propostas.length == 0) {
                      return Column(
                        children: <Widget>[Text("Sem propostas recebidas")],
                      );
                    }
                    return ListView.builder(
                      itemCount: propostas.length,
                      itemBuilder: (context, index) {
                        final Proposta proposta = propostas[index];
                        return Card(
                          child: new InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DescricaoPropostaSimples(proposta),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(proposta.serviceDescription),
                              subtitle: Text(proposta.description),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ]),
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: eventoPropostas(widget.id),
                  builder: (context, snapshot) {
                    final List<Proposta> propostas =
                        snapshot.data['propostas_aceitas'];
                    if (propostas.length == 0) {
                      return Column(
                        children: <Widget>[Text("Sem propostas aceitas")],
                      );
                    }
                    return ListView.builder(
                      itemCount: propostas.length,
                      itemBuilder: (context, index) {
                        final Proposta proposta = propostas[index];
                        return Card(
                          child: new InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DescricaoPropostaSimples(proposta),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(proposta.serviceDescription),
                              subtitle: Text(proposta.description),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ]),
          Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: eventoPropostas(widget.id),
                  builder: (context, snapshot) {
                    final List<Proposta> propostas =
                        snapshot.data['propostas_recusadas'];
                    if (propostas.length == 0) {
                      return Column(
                        children: <Widget>[Text("Sem propostas recusadas")],
                      );
                    }
                    return ListView.builder(
                      itemCount: propostas.length,
                      itemBuilder: (context, index) {
                        final Proposta proposta = propostas[index];
                        return Card(
                          child: new InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DescricaoPropostaSimples(proposta),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(proposta.serviceDescription),
                              subtitle: Text(proposta.description),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
