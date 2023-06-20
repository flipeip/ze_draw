import 'package:flutter_test/flutter_test.dart';
import 'package:ze_draw/models/usuario.dart';

void main() {
  group('Testes de conversão de JSON para model de usuário', () {
    const json = '{'
        '  "nome": "Mickey Mouse",'
        '  "foto": "https://servidor.com/media/foto.png",'
        '  "status": false,'
        '  "celular": "+5583987654321",'
        '  "user_id": "s0987t498h4t8w9",'
        '  "data_nascimento": "18-12-2005",'
        '  "usuario": "mmouse",'
        '  "capa": "https://servidor.com/media/capa.png"'
        '}';
    late Usuario usuario;

    setUp(() => usuario = Usuario.fromJson(json));

    test(
      'Igualdade de nome',
      () => expect(usuario.nome, 'Mickey Mouse'),
    );

    test(
      'Igualdade de foto',
      () => expect(usuario.foto, 'https://servidor.com/media/foto.png'),
    );

    test(
      'Igualdade de status',
      () => expect(usuario.status, false),
    );

    test(
      'Igualdade de celular',
      () => expect(usuario.celular, '+5583987654321'),
    );

    test(
      'Igualdade de id',
      () => expect(usuario.userId, 's0987t498h4t8w9'),
    );

    test(
      'Igualdade de data de nascimento',
      () => expect(usuario.dataNascimento, '18-12-2005'),
    );
    test(
      'Igualdade de nome de usuário',
      () => expect(usuario.usuario, 'mmouse'),
    );

    test(
      'Igualdade de capa',
      () => expect(usuario.capa, 'https://servidor.com/media/capa.png'),
    );
  });
}
