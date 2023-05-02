import 'package:flutter/material.dart';

import 'cadastro/cadastro_controlador.dart';
import 'login/login_controlador.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => LoginControlador(),
      cadastro: (_) => CadastroControlador(),
    };
  }
}
