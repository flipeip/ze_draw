import 'package:supabase_flutter/supabase_flutter.dart';

import 'api.dart';

class Autenticacao {
  static Future<AuthResponse> criarConta(String email, String senha) {
    return api.auth.signUp(
      email: email,
      password: senha,
    );
  }

  static Future<AuthResponse> logar(String email, String senha) {
    return api.auth.signInWithPassword(
      email: email,
      password: senha,
    );
  }

  static get usuario => api.auth.currentUser;

  static get sessao => api.auth.currentSession;
}
