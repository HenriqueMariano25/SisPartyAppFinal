import 'package:flutter/material.dart';
import 'package:sisparty/consultas/eventos_consultas.dart';
import 'package:sisparty/http/webclient.dart';
import 'package:sisparty/http/webclient.dart';
import 'package:sisparty/models/evento_model.dart';
import 'package:sisparty/screens/Evento/descricao_evento.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class EventoListaFornecedor extends StatefulWidget {
  @override
  _EventoListaFornecedorState createState() => _EventoListaFornecedorState();
}

class _EventoListaFornecedorState extends State<EventoListaFornecedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos Fornecedor"),
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<Evento>>(
        future: findAllEventos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
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
              }
          }
        },
      ),
    );
  }
}
