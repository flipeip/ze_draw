import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:ze_draw/telas/post/novo_post.dart';
import '../rotas.dart';

class NovoPostControlador extends StatefulWidget {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descricao = TextEditingController();

  NovoPostControlador({super.key});

  State<NovoPostControlador> createState() => _NovoPostControladorState();

  void createData(BuildContext context) async {
    try {
      Navigator.of(context).pushNamed(Rotas.feed);
      // TODO: Ir para tela de feed.
    } catch (e) {
      log(e.toString());
      // TODO: Checar erros e mostrar na tela.
    }
  }
}

class _NovoPostControladorState extends State<NovoPostControlador> {
  @override
  Widget build(BuildContext context) {
    return const NovoPostTela();
  }
}
