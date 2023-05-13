class ValidacaoEmail {
  const ValidacaoEmail(this.email);

  final String email;

  bool valido() {
    return email.contains(
      RegExp(
        r'^[_]*([a-z0-9]+(\.|_*)?)+@([a-z][a-z0-9-]+(\.|-*\.))+[a-z]{2,6}$',
      ),
    );
  }
}
