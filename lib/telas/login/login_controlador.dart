import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ze_draw/telas/tela_inicial.dart';

import '../../api/autenticacao.dart';
import '../../utilidades/validacoes/email.dart';
import '../rotas.dart';
import 'login_tela.dart';

class LoginControlador extends StatefulWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final ValueNotifier<String?> erroEmail = ValueNotifier(null);
  final ValueNotifier<String?> erroSenha = ValueNotifier(null);

  LoginControlador({super.key});

  @override
  State<LoginControlador> createState() => _LoginControladorState();

  void logar(BuildContext context) async {
    if (!ValidacaoEmail(email.text).valido()) {
      erroEmail.value = 'E-mail inválido';
      return;
    }

    try {
      await Autenticacao.logar(email.text, senha.text);
      // TODO: Ir para tela de feed.
      PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const TelaInicial(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.fade,
      );
    } on AuthException catch (_) {
      erroSenha.value = 'Login inválido. Verifique o e-mail e a senha.';
    } catch (e) {
      log(e.toString());
    }
  }

  void telaCadastro(BuildContext context) {
    Navigator.of(context).pushNamed(Rotas.cadastro);
  }
}

class _LoginControladorState extends State<LoginControlador> {
  @override
  Widget build(BuildContext context) {
    return LoginTela(widget);
  }
}
