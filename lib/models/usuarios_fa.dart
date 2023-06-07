// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioFa {
  final int usuarioId;
  final int faId;
  UsuarioFa({
    required this.usuarioId,
    required this.faId,
  });

  UsuarioFa copyWith({
    int? usuarioId,
    int? faId,
  }) {
    return UsuarioFa(
      usuarioId: usuarioId ?? this.usuarioId,
      faId: faId ?? this.faId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario_id': usuarioId,
      'fa_id': faId,
    };
  }

  factory UsuarioFa.fromMap(Map<String, dynamic> map) {
    return UsuarioFa(
      usuarioId: map['usuario_id'] as int,
      faId: map['fa_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioFa.fromJson(String source) => UsuarioFa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UsuarioFa(usuario_id: $usuarioId, fa_id: $faId)';

  @override
  bool operator ==(covariant UsuarioFa other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuarioId == usuarioId &&
      other.faId == faId;
  }

  @override
  int get hashCode => usuarioId.hashCode ^ faId.hashCode;
}
