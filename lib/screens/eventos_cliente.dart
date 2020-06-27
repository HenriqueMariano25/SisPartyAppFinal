import 'package:flutter/material.dart';
import 'package:sisparty/consultas/eventos_consultas.dart';
import 'package:sisparty/http/webclient.dart';
import 'package:sisparty/models/evento_model.dart';

class EventoListaCliente extends StatefulWidget {
  @override
  _EventoListaClienteState createState() => _EventoListaClienteState();
}

class _EventoListaClienteState extends State<EventoListaCliente> {
  List<Evento> _eventos = [];
  final consulta = EventoConsulta();

  @override
  void initState() {
    super.initState();
    _carregarEventos();
    print('oi');
  }

  _carregarEventos() async {
    final lista = await consulta.getEventos();
    setState(() {
      _eventos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eventos"),),
      body: FutureBuilder<List<Evento>>(
        future: findAllEventos(),
        builder: (context, snapshot) {
          final List<Evento> eventos = snapshot.data;
          return ListView.builder(itemBuilder: (context, index){
            final Evento evento = eventos[index];
            return Card(
              child: ListTile(
                title: Text(
                  evento.nome,
                ),
              ),
            );
          });
        },
      ),
    );
  }
}