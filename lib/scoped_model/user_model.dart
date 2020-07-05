import 'package:scoped_model/scoped_model.dart';

import 'package:sisparty/models/usuario_model.dart';

class UsuarioModel extends Model {
  Usuario _currentUser;

  void login(Usuario user) {
    _currentUser = user;
  }

  Usuario get currentUser {
    return _currentUser;
  }
}
