import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:ze_draw/telas/feed/post_aberto.dart';

class ComentarioControlador extends StatefulWidget {
  final TextEditingController postagem = TextEditingController();
  final TextEditingController usuario = TextEditingController();
  final TextEditingController comentario = TextEditingController();

  ComentarioControlador({super.key});

  @override
  State<ComentarioControlador> createState() => _ComentarioControladorState();

  void createData(BuildContext context) async {
    try {
      // TODO:
    } catch (e) {
      log(e.toString());
      // TODO: Checar erros e mostrar na tela.
    }
  }
}

class _ComentarioControladorState extends State<ComentarioControlador> {
  @override
  Widget build(BuildContext context) {
    return const PostAbertoTela(post: null);
  }
}
