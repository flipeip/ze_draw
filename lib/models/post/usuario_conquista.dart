// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioConquista {
  final int conquistaId;
  final int usuarioId;
  UsuarioConquista({
    required this.conquistaId,
    required this.usuarioId,
  });

  UsuarioConquista copyWith({
    int? conquistaId,
    int? usuarioId,
  }) {
    return UsuarioConquista(
      conquistaId: conquistaId ?? this.conquistaId,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conquista_id': conquistaId,
      'usuario_id': usuarioId,
    };
  }

  factory UsuarioConquista.fromMap(Map<String, dynamic> map) {
    return UsuarioConquista(
      conquistaId: map['conquista_id'] as int,
      usuarioId: map['usuario_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioConquista.fromJson(String source) => UsuarioConquista.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UsuarioConquista(conquista_id: $conquistaId, usuario_id: $usuarioId)';

  @override
  bool operator ==(covariant UsuarioConquista other) {
    if (identical(this, other)) return true;
  
    return 
      other.conquistaId == conquistaId &&
      other.usuarioId == usuarioId;
  }

  @override
  int get hashCode => conquistaId.hashCode ^ usuarioId.hashCode;
}
