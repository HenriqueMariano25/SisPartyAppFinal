import 'package:flutter/material.dart';
import 'package:sisparty/http/contasBancariasWebclient.dart';
import 'package:sisparty/models/contaBancaria_model.dart';
import 'package:sisparty/screens/ContaBancaria/adicionar_conta.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class GerenciarContasBancarias extends StatefulWidget {
  @override
  _GerenciarContasBancariasState createState() =>
      _GerenciarContasBancariasState();
}

class _GerenciarContasBancariasState extends State<GerenciarContasBancarias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contas Bancarias"),
          centerTitle: true,
          /* actions: <Widget>[
          FlatButton(
            child: Text(
              "Adicionar conta",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => CriarEvento(),
              //   ),
              // );
            },
          )
        ], */
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AdicionarConta(),
                  ),
                );
              },
              child: Text("Adicionar conta"),
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: contasBancarias(),
                  builder: (context, snapshot) {
                    final List<ContaBancaria> contas =
                        snapshot.data['contasBancarias'];
                    debugPrint(contas.length.toString());
                    debugPrint("oiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                    return ListView.builder(
                      itemCount: contas.length,
                      itemBuilder: (context, index) {
                        final ContaBancaria conta = contas[index];
                        if (contas.length == 0) {
                          return Container(
                            child: Text("Nenhuma conta bancaria cadasrtrada"),
                          );
                        }
                        return Card(
                          child: ListTile(
                            title: Text("Nº Conta: ${conta.account}"),
                            subtitle: Text("Agencia: ${conta.agency}"),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
