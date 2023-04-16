import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/campo_texto.dart';

class LoginTela extends StatelessWidget {
  const LoginTela({
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
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 112),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  const CampoTexto(label: 'E-mail ou Usuário'),
                  const SizedBox(height: 30),
                  const CampoTexto(
                    label: 'Senha',
                    senha: true,
                  ),
                  const _EsqueceuSenha(),
                  const SizedBox(height: 32),
                  const _BotaoEntrar(),
                  const _Divisor(),
                  const _EntrarComGoogle(),
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
            onTap: () {},
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

class _BotaoEntrar extends StatelessWidget {
  const _BotaoEntrar();

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(90);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: const LinearGradient(colors: [
          Colors.redAccent,
          Colors.orange,
          Colors.orange,
          Colors.cyan,
        ], stops: [
          0,
          0.3,
          0.6,
          1,
        ]),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: Colors.blueGrey.shade500.withOpacity(0.3),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          borderRadius: borderRadius,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 4,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Entrar',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EntrarComGoogle extends StatelessWidget {
  const _EntrarComGoogle();

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(90);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: Colors.blueGrey.shade500.withOpacity(0.3),
          )
        ],
      ),
      child: Material(
        borderRadius: borderRadius,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: borderRadius,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 4,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/google.png'),
                ),
                Text(
                  'Entrar com Google',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
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
