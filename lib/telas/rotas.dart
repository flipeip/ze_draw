import 'package:flutter/material.dart';

import 'login/login.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => const LoginTela(),
    };
  }
}
