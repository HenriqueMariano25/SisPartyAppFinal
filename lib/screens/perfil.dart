import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/screens/ContaBancaria/gerenciar_contas.dart';
import 'package:sisparty/screens/Sessao/alterar_senha.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

import 'Sessao/login.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
          ),
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => GerenciarContasBancarias(),
                ),
              );
            },
            child: Text("Gerencias contas bancarias"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AlterarSenha(),
                ),
              );
            },
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
