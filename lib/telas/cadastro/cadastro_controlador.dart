import 'package:flutter/material.dart';
import 'package:ze_draw/api/autenticacao.dart';
import 'package:ze_draw/api/api.dart';
import 'package:ze_draw/telas/cadastro/cadastro_tela.dart';

class CadastroControlador extends StatelessWidget {
  final email = TextEditingController();
  final senha = TextEditingController();
  final senhaRepetir = TextEditingController();

  CadastroControlador({super.key});

  @override
  Widget build(BuildContext context) {
    return CadastroTela(this);
  }

  void criarConta(BuildContext context) {
    String? mensagem;
    if (senha.text != senhaRepetir.text) {
      mensagem = 'Senha não corresponde';
    }
    if (senha.text.length < 8) {
      mensagem = 'Senha com menos de 8 caracteres';
    }
    if (mensagem != null) {
      final snackBar = SnackBar(content: Text(mensagem));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    Autenticacao.criarConta(email.text, senha.text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada.')),
      );
    });
  }
}
