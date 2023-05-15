import 'package:flutter_test/flutter_test.dart';
import 'package:ze_draw/utilidades/validacoes/email.dart';
import 'package:ze_draw/utilidades/validacoes/senha.dart';
import 'package:ze_draw/utilidades/validacoes/usuario.dart';

main() {
  group('Validação de senha:', () {
    test('Válida', () {
      const senha = 'Teste!123@\$!%*#?&_=+-()/';
      var validade = const ValidacaoSenha(
        senha,
        comparacao: senha,
      ).validade();
      expect(validade, ValidadeSenha.ok);
    });

    test('Senhas diferentes', () {
      const senha = 'Teste!123';
      var validade = const ValidacaoSenha(
        senha,
        comparacao: '$senha?',
      ).validade();
      expect(validade, ValidadeSenha.senhaDiferentes);
    });

    test('Sem número', () {
      const senha = 'Teste!Teste';
      var validade = const ValidacaoSenha(
        senha,
        comparacao: senha,
      ).validade();
      expect(validade, ValidadeSenha.semNumero);
    });

    test('Sem letras', () {
      const senha = '1234567!';
      var validade = const ValidacaoSenha(
        senha,
        comparacao: senha,
      ).validade();
      expect(validade, ValidadeSenha.semLetra);
    });

    test('Sem símbolos', () {
      const senha = '1234567A';
      var validade = const ValidacaoSenha(
        senha,
        comparacao: senha,
      ).validade();
      expect(validade, ValidadeSenha.semEspecial);
    });

    group('Pequena', () {
      test('com caracteres válidos', () {
        const senha = 'T!1@/';
        var validade = const ValidacaoSenha(
          senha,
          comparacao: senha,
        ).validade();
        expect(validade, ValidadeSenha.pequena);
      });

      test('sem número', () {
        const senha = 'T!T';
        var validade = const ValidacaoSenha(
          senha,
          comparacao: senha,
        ).validade();
        expect(validade, ValidadeSenha.pequena);
      });

      test('sem letra', () {
        const senha = '123!';
        var validade = const ValidacaoSenha(
          senha,
          comparacao: senha,
        ).validade();
        expect(validade, ValidadeSenha.pequena);
      });

      test('sem caractere especial', () {
        const senha = '123A';
        var validade = const ValidacaoSenha(
          senha,
          comparacao: senha,
        ).validade();
        expect(validade, ValidadeSenha.pequena);
      });
    });
  });

  group('Validação de email:', () {
    test('Válido', () {
      const email = 'email@exemplo.com';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, true);
    });
    test('Sem dominio', () {
      const email = 'email@';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, false);
    });

    test('Sem usuário', () {
      const email = '@exemplo.com';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, false);
    });

    test('Vazio', () {
      const email = '';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, false);
    });

    test('Sem ponto do domínio', () {
      const email = 'email@exemplocom';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, false);
    });

    test('Sem arroba', () {
      const email = 'emailexemplo.com';
      final validade = const ValidacaoEmail(email).valido();
      expect(validade, false);
    });
  });

  group('Validação de nome de usuário:', () {
    test('Válido', () {
      const usuario = 'usuario_25';
      final validacao = const ValidacaoUsuario(usuario).valido();
      expect(validacao, ValidadeUsuario.ok);
    });

    test('Iniciando com underline', () {
      const usuario = '_usuario_25';
      final validacao = const ValidacaoUsuario(usuario).valido();
      expect(validacao, ValidadeUsuario.comecaComUnderline);
    });

    test('Com caracteres inválidos', () {
      const usuario = 'usuario*25';
      final validacao = const ValidacaoUsuario(usuario).valido();
      expect(validacao, ValidadeUsuario.caracteresInvalidos);
    });

    test('Com menos de 4 caracteres', () {
      const usuario = 'e_2';
      final validacao = const ValidacaoUsuario(usuario).valido();
      expect(validacao, ValidadeUsuario.pequeno);
    });

    test('Com letras maiúsculas', () {
      const usuario = 'Usuario_25';
      final validacao = const ValidacaoUsuario(usuario).valido();
      expect(validacao, ValidadeUsuario.letrasMaiusculas);
    });
  });
}
