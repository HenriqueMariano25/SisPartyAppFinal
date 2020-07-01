import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/Proposta/propostas.dart';

import '../Evento/eventos_cliente.dart';
import '../Evento/eventos_fornecedor.dart';
import '../perfil.dart';
import '../Proposta/proposta_fornecedor.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Eventos'),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              final type_user = pref.getString('type_user');
              if(type_user == "Cliente"){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EventoListaCliente(),
                  ),
                );
              }else if(type_user == "Fornecedor"){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EventoListaFornecedor(),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: Text('Propostas'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PropostaFornecedor(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Perfil(),
                ),
              );
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
