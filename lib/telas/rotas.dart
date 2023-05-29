import 'package:flutter/material.dart';

import 'package:ze_draw/telas/perfil/perfil_novo.dart';
import 'package:ze_draw/telas/tela_inicial.dart';

import 'cadastro/cadastro_controlador.dart';
import 'feed/feed_inicial.dart';
import 'login/login_controlador.dart';
import 'perfil/perfil_novo.dart';
import 'perfil/perfil_tela.dart';
import 'post/novo_post.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const telaIncial = '/tela_incial';
  static const feed = '/feed';
  static const novoPost = '/novo_post';
  static const novoPerfil = '/novo_perfil';
  static const perfil = '/perfil';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => LoginControlador(),
      feed: (_) => const FeedTela(),
      telaIncial: (_) => const TelaInicial(),
      cadastro: (_) => CadastroControlador(),
      novoPost: (_) => const NovoPostTela(),
      novoPerfil: (_) => const NovoPerfilTela(),
      perfil: (_) => const PerfilTela(),
    };
  }
}
