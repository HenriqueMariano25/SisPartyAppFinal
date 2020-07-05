import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/http/sessionWebclient.dart';
import 'package:sisparty/models/usuario_model.dart';
import 'package:sisparty/scoped_model/user_model.dart';
import 'package:sisparty/screens/ContaBancaria/gerenciar_contas.dart';
import 'package:sisparty/screens/Sessao/alterar_senha.dart';
import 'package:sisparty/screens/screen_utils/custom_drawer.dart';

import 'Sessao/login.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (BuildContext context, Widget child, UsuarioModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Perfil"),
          ),
          drawer: CustomDrawer(),
          body: ListView(
            children: <Widget>[
              // Container(
              //   child: _image == null
              //       ? Text("Nenhuma imagem selecionada")
              //       : Image.file(_image),
              // child: (model.currentUser.imagem == null)
              //     ? Image(
              //         image:
              //             NetworkImage(model.currentUser.imagem.toString()),
              //       )
              //     : Image(
              //         image: NetworkImage(
              //             'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              //       )
              // child: Image(
              //   image: NetworkImage(
              //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              // ),
              // ),
              // Image.network(model.currentUser.imagem),
              // RaisedButton(
              //   onPressed: () {
              //     print(model.currentUser.nome);
              //     print("oiiiiiiiiiiiiiiiiii");
              //   },
              //   child: Text("Teste"),
              // ),
              // RaisedButton(
              //   onPressed: () {
              //     getImage();
              //     print(_image);
              //     print("oiiiiiiiiii");
              //   },
              //   child: Text("Selecionar imagem"),
              // ),
              // RaisedButton(
              //   onPressed: () {
              //     _enviarImagem();
              //     // uploadImageUser({"photo": _image.path});
              //   },
              //   child: Text("Alterar imagem"),
              // ),
              Text("Saldo: "),
              Text("Nome: ${model.currentUser.nome}"),
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
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
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
      },
    );
  }

  // void _enviarImagem() {
  //   if (_image == null) return;

  //   final fileName = _image.path.split('/').last;
  //   final photo = MultipartFile.fromFile(_image.path, filename: fileName);

  //   final data = FormData.fromMap({"photo": photo});

  //   // String base64Image = base64Encode(_image.readAsBytesSync());
  //   // String fileName = _image.path.split("/").last;
  //   uploadImageUser(data);
  // }
}
