// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Curtidas {
  final int usuarioId;
  final int postagemId;
  Curtidas({
    required this.usuarioId,
    required this.postagemId,
  });

  Curtidas copyWith({
    int? usuarioId,
    int? postagemId,
  }) {
    return Curtidas(
      usuarioId: usuarioId ?? this.usuarioId,
      postagemId: postagemId ?? this.postagemId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario_id': usuarioId,
      'postagem_id': postagemId,
    };
  }

  factory Curtidas.fromMap(Map<String, dynamic> map) {
    return Curtidas(
      usuarioId: map['usuario_id'] as int,
      postagemId: map['postagem_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Curtidas.fromJson(String source) => Curtidas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Curtidas(usuario_id: $usuarioId, postagem_id: $postagemId)';

  @override
  bool operator ==(covariant Curtidas other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuarioId == usuarioId &&
      other.postagemId == postagemId;
  }

  @override
  int get hashCode => usuarioId.hashCode ^ postagemId.hashCode;
}
