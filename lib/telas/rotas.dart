import 'package:flutter/material.dart';

import 'login/login_controlador.dart';
import 'cadastro/cadastro.dart';
import 'feed/feed_inicial.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const feed = '/feed';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => LoginControlador(),
      cadastro: (_) => const CadastroTela(),
      feed: (_) => FeedTela(),
    };
  }
}
