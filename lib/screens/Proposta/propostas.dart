import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/Proposta/proposta_cliente.dart';
import 'package:sisparty/screens/Proposta/proposta_fornecedor.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class Propostas extends StatefulWidget {
  @override
  _PropostasState createState() => _PropostasState();
}

class _PropostasState extends State<Propostas> {
  _authenticated() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final type_user = pref.getString("type_user");
    if (type_user == "Cliente") {
      return PropostaCliente();
    } else {
      return PropostaFornecedor();
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
                  title: Text("Propostas"),
                ),
                drawer: CustomDrawer(),
                body: CircularProgressIndicator());
          }
          return snapshot.data;
        },
      );
      //  _authenticated(
  }

  
}
