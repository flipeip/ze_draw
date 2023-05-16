import 'package:flutter/material.dart';

import 'cadastro/cadastro_controlador.dart';
import 'login/login_controlador.dart';
import 'feed/feed_inicial.dart';
import 'post/novo_post.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const feed = '/feed';
  static const novoPost = '/novo_post';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => LoginControlador(),
      feed: (_) => const FeedTela(),
      cadastro: (_) => CadastroControlador(),
      novoPost: (_) => const NovoPostTela(),
    };
  }
}
