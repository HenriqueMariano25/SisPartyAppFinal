import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/Evento/eventos.dart';
import 'package:sisparty/screens/Proposta/propostas.dart';

import '../Evento/eventos_cliente.dart';
import '../Evento/eventos_fornecedor.dart';
import '../perfil.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 255, 192, 203), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
        );

    return Drawer(
        child: Stack(
      children: <Widget>[
        _buildDrawerBack(),
        ListView(
          padding: EdgeInsets.only(left: 32.0, top: 32.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
              height: 170.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 8.0,
                    left: 10.0,
                    child: Text(
                      "Sisparty",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Eventos',
                style: TextStyle(fontSize: 24.0),
              ),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                final type_user = pref.getString('type_user');
                if (type_user == "Cliente") {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Eventos(),
                    ),
                  );
                } else if (type_user == "Fornecedor") {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Eventos(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: Text('Propostas', style: TextStyle(fontSize: 24.0)),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Propostas(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil', style: TextStyle(fontSize: 24.0)),
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
      ],
    ));
  }
}
