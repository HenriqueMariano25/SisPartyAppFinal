import 'package:flutter/material.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

class PropostaCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Propostas"),),
      drawer: CustomDrawer(),
        body: Column(),
    );
  }
}
