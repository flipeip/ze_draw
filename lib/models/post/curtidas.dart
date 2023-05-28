// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Curtidas {
  final int usuario_id;
  final int postagem_id;
  Curtidas({
    required this.usuario_id,
    required this.postagem_id,
  });

  Curtidas copyWith({
    int? usuario_id,
    int? postagem_id,
  }) {
    return Curtidas(
      usuario_id: usuario_id ?? this.usuario_id,
      postagem_id: postagem_id ?? this.postagem_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario_id': usuario_id,
      'postagem_id': postagem_id,
    };
  }

  factory Curtidas.fromMap(Map<String, dynamic> map) {
    return Curtidas(
      usuario_id: map['usuario_id'] as int,
      postagem_id: map['postagem_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Curtidas.fromJson(String source) => Curtidas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Curtidas(usuario_id: $usuario_id, postagem_id: $postagem_id)';

  @override
  bool operator ==(covariant Curtidas other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuario_id == usuario_id &&
      other.postagem_id == postagem_id;
  }

  @override
  int get hashCode => usuario_id.hashCode ^ postagem_id.hashCode;
}
