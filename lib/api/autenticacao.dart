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

  // static Future<PostgrestResponse<dynamic>> usuarioUser() async{
  //   PostgrestResponse<dynamic> data = await api.from('usuario').select('id').eq('user_id', api.auth.currentUser?.id);
  //   return data;
  // }
  
  static get user => api.auth.currentUser;

  static get sessao => api.auth.currentSession;

  // static get usuario => usuarioUser();
}
