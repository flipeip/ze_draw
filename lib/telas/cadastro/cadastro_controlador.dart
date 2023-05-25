import 'package:flutter/material.dart';
import 'package:ze_draw/api/autenticacao.dart';
import 'package:ze_draw/telas/cadastro/cadastro_tela.dart';
import 'package:ze_draw/utilidades/validacoes/email.dart';
import 'package:ze_draw/utilidades/validacoes/senha.dart';

class CadastroControlador extends StatelessWidget {
  final email = TextEditingController();
  final senha = TextEditingController();
  final senhaRepetir = TextEditingController();
  final erroEmail = ValueNotifier<String?>(null);
  final erroSenha = ValueNotifier<String?>(null);
  final erroSenhaRepetir = ValueNotifier<String?>(null);

  CadastroControlador({super.key});

  @override
  Widget build(BuildContext context) {
    return CadastroTela(this);
  }

  void criarConta(BuildContext context) {
    bool erro = false;
    final validacaoSenha = ValidacaoSenha(
      senha.text,
      comparacao: senhaRepetir.text,
    ).validade();

    switch (validacaoSenha) {
      case ValidadeSenha.ok:
        break;
      case ValidadeSenha.senhaDiferentes:
        erroSenha.value = validacaoSenha.mensagem;
        erroSenhaRepetir.value = validacaoSenha.mensagem;
        erro = true;
        break;
      default:
        erroSenha.value = validacaoSenha.mensagem;
        erro = true;
        break;
    }

    if (!ValidacaoEmail(email.text).valido()) {
      erroEmail.value = 'E-mail inválido';
      erro = true;
    }

    if (erro) return;

    Autenticacao.criarConta(email.text, senha.text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada.')),
      );
      Navigator.of(context).pop();
    });
  }
}
