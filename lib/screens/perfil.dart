import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

import 'login.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          Text("Saldo: "),
          Text("Nome: "),
          Text("Email: "),
          RaisedButton(
            onPressed: () {},
            child: Text("Depositar"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Sacar"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Gerencias contas bancarias"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Alterar senha"),
          ),
          RaisedButton(
            onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("autheticated", "true");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
            },
            child: Text("Sair"),
          ),

        ],
      ),
    );
  }
}
