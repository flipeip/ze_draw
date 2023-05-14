import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../widgets/botao_default.dart';
import '../../widgets/botao_google.dart';
import '../../widgets/campo_texto.dart';
import '../rotas.dart';
import 'login_controlador.dart';

class LoginTela extends StatelessWidget {
  final LoginControlador controlador;

  const LoginTela(
    this.controlador, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const alturaImagens = 150.0;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/topo-direita.svg',
              height: alturaImagens,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              'assets/images/topo-esquerda.svg',
              height: alturaImagens,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              'assets/images/baixo-direita.svg',
              height: alturaImagens,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              'assets/images/baixo-esquerda.svg',
              height: alturaImagens,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 112),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  CampoTexto(
                    label: 'E-mail',
                    controlador: controlador.email,
                    erro: controlador.erroEmail,
                  ),
                  const SizedBox(height: 30),
                  CampoTexto(
                    label: 'Senha',
                    oculto: true,
                    controlador: controlador.senha,
                    erro: controlador.erroSenha,
                  ),
                  const _EsqueceuSenha(),
                  const SizedBox(height: 32),
                  BotaoEntrar(
                    texto: 'Entrar',
                    aoClicar: controlador.logar,
                  ),
                  const _Divisor(),
                  const EntrarComGoogle(),
                  const _CriarConta(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO: Adicionar mais espaço para clicar no botão de cadastrar
class _CriarConta extends StatelessWidget {
  const _CriarConta();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 2,
        spacing: 2,
        children: [
          const Text('Não possui uma conta?'),
          InkWell(
            radius: 90,
            borderRadius: BorderRadius.circular(90),
            onTap: () {
              Navigator.of(context).pushNamed(Rotas.cadastro);
            },
            child: GradientText(
              'Cadastre-se',
              colors: [
                Colors.orange.shade300,
                Colors.orange.shade900,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Divisor extends StatelessWidget {
  const _Divisor();

  @override
  Widget build(BuildContext context) {
    final cor = Theme.of(context).colorScheme.outline.withOpacity(0.5);
    final divisor = Expanded(child: Divider(color: cor));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          divisor,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ou',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cor,
                  ),
            ),
          ),
          divisor,
        ],
      ),
    );
  }
}

// TODO: Adicionar sublinhado
class _EsqueceuSenha extends StatelessWidget {
  const _EsqueceuSenha();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Esqueceu sua Senha?',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
