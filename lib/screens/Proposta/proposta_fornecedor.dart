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
              child: propostaFuture('propostas_enviadas'),
            ),
            Container(
              child: propostaFuture('proposta_aceita'),
            ),
            Container(
              child: propostaFuture('propostas_recusadas'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget propostaFuture(snapshotData) {
  return FutureBuilder(
      future: propostasFornecedor(),
      // ignore: missing_return
      builder: (context, snapshot) {
        final List<Proposta> propostas = snapshot.data[snapshotData];
        return ListView.builder(
            itemCount: propostas.length,
            itemBuilder: (context, index) {
              print(context);
              final Proposta proposta = propostas[index];
              return Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DescricaoProposta(proposta),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(proposta.service),
                    subtitle: Text(proposta.serviceDescription),
                  ),
                ),
              );
            });
      });
}
