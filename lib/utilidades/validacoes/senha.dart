enum ValidadeSenha {
  ok('A senha é válida'),
  pequena('A senha precisa de pelo menos 8 caracteres.'),
  semLetra('A senha precisa de pelo menos uma letra.'),
  semNumero('A senha precisa de pelo menos um número.'),
  semEspecial('A senha precisa de pelo menos um caractere especial.'),
  senhaDiferentes('As senhas não são iguais. Tente novamente.');

  const ValidadeSenha(this.mensagem);

  final String mensagem;
}

class ValidacaoSenha {
  const ValidacaoSenha(this.senha, {this.comparacao});

  static const tamanhoMinimo = 8;

  final String senha;
  final String? comparacao;

  bool _temMinimoDeCaracteres() => senha.length >= tamanhoMinimo;

  bool _temLetras() => senha.contains(RegExp(r'[a-zA-Z]'));

  bool _temNumeros() => senha.contains(RegExp(r'[0-9]'));

  bool _temCaractereEspecial() {
    return senha.contains(RegExp(r'[^a-zA-Z0-9]'));
  }

  bool _temSenhasIguais() {
    return comparacao != null ? senha == comparacao : true;
  }

  ValidadeSenha validade() {
    if (!_temMinimoDeCaracteres()) return ValidadeSenha.pequena;
    if (!_temLetras()) return ValidadeSenha.semLetra;
    if (!_temNumeros()) return ValidadeSenha.semNumero;
    if (!_temCaractereEspecial()) return ValidadeSenha.semEspecial;
    if (!_temSenhasIguais()) return ValidadeSenha.senhaDiferentes;
    return ValidadeSenha.ok;
  }
}
