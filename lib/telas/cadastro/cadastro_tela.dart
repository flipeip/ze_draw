import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../widgets/botao_default.dart';
import '../../widgets/campo_texto.dart';
import 'cadastro_controlador.dart';

class CadastroTela extends StatelessWidget {
  final CadastroControlador controlador;

  const CadastroTela(this.controlador, {super.key});

  @override
  Widget build(BuildContext context) {
    var alturaImagens = MediaQuery.of(context).size.width * 0.32;
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      'Criar Conta',
                      colors: const [
                        Color(0xFFFF2626),
                        Color(0xFFFFA800),
                        Color(0xFF34D1DB),
                      ],
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    CampoTexto(
                      label: 'Digite seu e-mail',
                      controlador: controlador.email,
                      erro: controlador.erroEmail,
                    ),
                    // const SizedBox(height: 24),
                    // const CampoTexto(label: 'Digite um usuário'),
                    const SizedBox(height: 24),
                    CampoTexto(
                      label: 'Digite sua senha',
                      controlador: controlador.senha,
                      erro: controlador.erroSenha,
                      oculto: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
                      child: Text(
                        'Mínimo de 8 caracteres, incluindo letras, '
                        'números e símbolos.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange, fontSize: 12),
                      ),
                    ),
                    CampoTexto(
                      label: 'Confirme sua senha',
                      controlador: controlador.senhaRepetir,
                      erro: controlador.erroSenhaRepetir,
                      oculto: true,
                    ),
                    const SizedBox(height: 28),
                    BotaoPadrao(
                      texto: 'Cadastrar-se',
                      aoClicar: () => controlador.criarConta(context),
                    ),
                    const _Divisor(),
                    BotaoPadrao(
                      texto: 'Voltar ao Login',
                      buttonType: 'lightButton',
                      aoClicar: () => Navigator.of(context).pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 36.0,
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
      padding: const EdgeInsets.symmetric(vertical: 18),
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
