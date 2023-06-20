import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'api/autenticacao.dart';
import 'telas/rotas.dart';
import 'utilidades/api_config.dart';
import 'utilidades/tema.dart';

void main() async {
  await iniciarDependencias();
  if (Autenticacao.sessao != null){
    await Autenticacao.getUsuario();
  }
  runApp(const MainApp());
}

Future<void> iniciarDependencias() async {
  await Supabase.initialize(
    url: apiUrl,
    anonKey: apiKey,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var rotaInicial = Rotas.login;
    if (Autenticacao.sessao != null){
      rotaInicial = Rotas.telaIncial;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema.padrao,
      initialRoute: rotaInicial,
      routes: Rotas.rotas,
    );
  }
}
