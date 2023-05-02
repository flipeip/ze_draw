import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ze_draw/widgets/botao_default.dart';
import 'package:ze_draw/widgets/campo_texto.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';
// import 'package:email_validator/email_validator.dart';

class RecuperarSenha extends StatelessWidget {
  const RecuperarSenha({super.key});

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
                  const SizedBox(height: 64),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 30, 16, 50),
                    child: SvgPicture.asset('assets/images/cadeado.svg',
                        height: alturaImagens),
                  ),
                  const Text(
                    "Redefinição de Senha",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Leckerli_One'
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // GradientText(
                  //   'Redefinição de Senha',
                  //   colors: const [
                  //     Color(0xFFFF2626),
                  //     Color(0xFFFFA800),
                  //     Color(0xFF34D1DB),
                  //   ],
                  //   style: const TextStyle(
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //       fontFamily: 'Leckerli_One'),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 30),
                  const Text(
                      "Para recuperar a sua senha, informe o e-mail vinculado a sua conta. Lhe enviaremos um link com as instruções",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  const CampoTexto(label: 'Informe seu e-mail'),
                  const SizedBox(height: 30),
                  BotaoEntrar(texto: 'Enviar', aoClicar: () {})
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Color.fromARGB(255, 63, 133, 107),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
