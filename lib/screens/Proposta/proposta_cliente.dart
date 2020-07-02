import 'package:flutter/material.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class PropostaCliente extends StatefulWidget {
  @override
  _PropostaClienteState createState() => _PropostaClienteState();
}

class _PropostaClienteState extends State<PropostaCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Propostas"),),
      drawer: CustomDrawer(),
        body: Column(),
    );
  }
}
