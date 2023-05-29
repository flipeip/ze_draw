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
  
  static get user => api.auth.currentUser;

  static get sessao => api.auth.currentSession;

  static int? usuario;

  static Future<void> getUsuario() async {
    List<dynamic> res = await api.from('usuario').select('id').eq('user_id', api.auth.currentUser?.id);
    usuario = res[0]['id'];
  }
}
