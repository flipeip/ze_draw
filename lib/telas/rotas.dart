import 'package:flutter/material.dart';
import 'package:ze_draw/telas/perfil/perfil_novo.dart';
import 'package:ze_draw/telas/tela_inicial.dart';
import 'cadastro/cadastro_controlador.dart';
import 'feed/feed_inicial.dart';
import 'feed/post_aberto.dart';
import 'login/login_controlador.dart';
import 'perfil/perfil_tela.dart';
import 'post/novo_post.dart';

class Rotas {
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const telaIncial = '/';
  static const feed = '/feed';
  static const postAberto = '/post';
  static const novoPost = '/novo_post';
  static const novoPerfil = '/novo_perfil';
  static const perfil = '/perfil';

  static Map<String, Widget Function(BuildContext)> get rotas {
    return {
      login: (_) => LoginControlador(),
      feed: (_) => const FeedTela(),
      postAberto: (BuildContext context) {
        final post = ModalRoute.of(context)?.settings.arguments as int;
        return PostAbertoTela(post: post);
      },
      telaIncial: (_) => const TelaInicial(),
      cadastro: (_) => CadastroControlador(),
      novoPost: (_) => const NovoPostTela(),
      novoPerfil: (_) => const NovoPerfilTela(),
      perfil: (BuildContext context) {
        final usuario = ModalRoute.of(context)?.settings.arguments as int;
        return PerfilTela(usuario: usuario);
      },
  };
}}