import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:ze_draw/telas/perfil/perfil_novo.dart';
import '../rotas.dart';

class NovoPerfilControlador extends StatefulWidget {
  final TextEditingController usuario = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController celular = TextEditingController();
  final TextEditingController dataNascimento = TextEditingController();

  NovoPerfilControlador({super.key});

  State<NovoPerfilControlador> createState() => _NovoPerfilControladorState();

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

class _NovoPerfilControladorState extends State<NovoPerfilControlador> {
  @override
  Widget build(BuildContext context) {
    return const NovoPerfilTela();
  }
}
