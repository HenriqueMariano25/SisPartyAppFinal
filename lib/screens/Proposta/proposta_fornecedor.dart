import 'package:flutter/material.dart';
import 'package:sisparty/http/propostasWebclient.dart';
import 'package:sisparty/models/proposta_model.dart';
import 'package:sisparty/screens/Proposta/descricao_proposta.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class PropostaFornecedor extends StatefulWidget {
  @override
  _PropostaFornecedorState createState() => _PropostaFornecedorState();
}

class _PropostaFornecedorState extends State<PropostaFornecedor> {
  @override
  _carregarPropostas() async {
    Future lista = findAllProposals();
    return lista;
  }

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
              Tab(text: 'Enviadas'),
              Tab(text: 'Aceitas'),
              Tab(text: 'Recusadas'),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                  future: _carregarPropostas(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final List<Proposta> propostas_enviadas =
                        snapshot.data['propostas_enviadas'];
                    return ListView.builder(
                        itemCount: propostas_enviadas.length,
                        itemBuilder: (context, index) {
                          print(context);
                          final Proposta proposta_enviada =
                              propostas_enviadas[index];
                          return Card(
                            child: new InkWell(
                              onTap: () {
                                //                              print(proposta_enviada);
                                print('id: ${proposta_enviada.id}');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DescricaoProposta(proposta_enviada),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(proposta_enviada.service),
                                subtitle:
                                    Text(proposta_enviada.serviceDescription),
                              ),
                            ),
                          );
                        });
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: _carregarPropostas(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final List<Proposta> propostas_enviadas =
                        snapshot.data['propostas_enviadas'];
                    return ListView.builder(itemBuilder: (context, index) {
                      print(context);
                      final Proposta proposta_enviada =
                          propostas_enviadas[index];
                      return Card(
                        child: ListTile(
                          title: Text(proposta_enviada.id.toString()),
                        ),
                      );
                    });
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: _carregarPropostas(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final List<Proposta> propostas_enviadas =
                        snapshot.data['propostas_enviadas'];
                    return ListView.builder(itemBuilder: (context, index) {
                      print(context);
                      final Proposta proposta_enviada =
                          propostas_enviadas[index];
                      return Card(
                        child: ListTile(
                          title: Text(proposta_enviada.id.toString()),
                        ),
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
