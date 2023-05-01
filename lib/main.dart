import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'utilidades/api_config.dart';
import 'telas/rotas.dart';
import 'utilidades/tema.dart';

void main() async {
  await iniciarDependencias();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema.padrao,
      initialRoute: Rotas.login,
      routes: Rotas.rotas,
    );
  }
}
