import 'api.dart';

class Autenticacao {
  criarConta(String email, String senha) async {
    await api.auth.signUp(
      email: email,
      password: senha,
    );
  }

  logar(String email, String senha) {
    return api.auth.signInWithPassword(
      email: email,
      password: senha,
    );
  }

  get usuario => api.auth.currentUser;

  get sessao => api.auth.currentSession;
}
