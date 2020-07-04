import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/Evento/eventos_cliente.dart';
import 'package:sisparty/screens/Evento/eventos_fornecedor.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  _authenticated() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final typeUser = pref.getString("type_user");
    if (typeUser == "Cliente") {
      return EventosCliente();
    } else {
      return EventosFornecedor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _authenticated(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Eventos"),
              ),
              drawer: CustomDrawer(),
              body: CircularProgressIndicator());
        }
        return snapshot.data;
      },
    );
  }
}
