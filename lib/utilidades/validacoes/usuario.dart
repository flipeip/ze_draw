enum ValidadeUsuario {
  ok(''),
  pequeno('O nome de usuário precisa ter pelo menos 4 caracteres.'),
  comecaComUnderline('O nome de usuário não pode iniciar com underline'),
  letrasMaiusculas('O nome de usuário não pode conter letras maiúsculas'),
  caracteresInvalidos('O nome de usuário aceita apenas letras minúsculas, '
      'números, "-" e "_".');

  const ValidadeUsuario(this.mensagem);

  final String mensagem;
}

class ValidacaoUsuario {
  const ValidacaoUsuario(this.usuario);

  static const tamanhoMinimo = 4;

  final String usuario;

  bool _pequeno() => usuario.length <= tamanhoMinimo;

  bool _comecaComUnderline() => usuario.startsWith('_');

  bool _temLetrasMaiusculas() => usuario.contains(RegExp(r'[A-Z]'));

  bool _temCaracteresInvalidos() => usuario.contains(RegExp(r'[^a-z0-9-_]'));

  ValidadeUsuario valido() {
    if (_pequeno()) return ValidadeUsuario.pequeno;
    if (_comecaComUnderline()) return ValidadeUsuario.comecaComUnderline;
    if (_temLetrasMaiusculas()) return ValidadeUsuario.letrasMaiusculas;
    if (_temCaracteresInvalidos()) return ValidadeUsuario.caracteresInvalidos;
    return ValidadeUsuario.ok;
  }
}
