import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../widgets/botao_default.dart';
import '../../widgets/botao_google.dart';
import '../../widgets/campo_texto.dart';
import 'cadastro_controlador.dart';

class CadastroTela extends StatelessWidget {
  final CadastroControlador controlador;

  const CadastroTela(this.controlador, {super.key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 112),
                  GradientText(
                    'Criar Conta',
                    colors: const [
                      Color(0xFFFF2626),
                      Color(0xFFFFA800),
                      Color(0xFF34D1DB),
                    ],
                    style: const TextStyle(
                        fontSize: 55, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 32),
                  CampoTexto(
                    label: 'Digite um e-mail',
                    controlador: controlador.email,
                  ),
                  // const SizedBox(height: 24),
                  // const CampoTexto(label: 'Digite um usuário'),
                  const SizedBox(height: 24),
                  CampoTexto(
                    label: 'Digite uma senha',
                    controlador: controlador.senha,
                    oculto: true,
                  ),
                  const SizedBox(height: 24),
                  CampoTexto(
                    label: 'Digite a senha novamente',
                    controlador: controlador.senhaRepetir,
                    oculto: true,
                  ),
                  const SizedBox(height: 24),
                  BotaoEntrar(
                    texto: 'Cadastrar-se',
                    aoClicar: () => controlador.criarConta(context),
                  ),
                  const _Divisor(),
                  const EntrarComGoogle(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Color.fromARGB(255, 63, 133, 107),
                )),
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
