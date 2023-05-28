// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comentarios {
  final int usuario_id;
  final int postagem_id;
  final String comentario;
  Comentarios({
    required this.usuario_id,
    required this.postagem_id,
    required this.comentario,
  });

  Comentarios copyWith({
    int? usuario_id,
    int? postagem_id,
    String? comentario,
  }) {
    return Comentarios(
      usuario_id: usuario_id ?? this.usuario_id,
      postagem_id: postagem_id ?? this.postagem_id,
      comentario: comentario ?? this.comentario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario_id': usuario_id,
      'postagem_id': postagem_id,
      'comentario': comentario,
    };
  }

  factory Comentarios.fromMap(Map<String, dynamic> map) {
    return Comentarios(
      usuario_id: map['usuario_id'] as int,
      postagem_id: map['postagem_id'] as int,
      comentario: map['comentario'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comentarios.fromJson(String source) => Comentarios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Comentarios(usuario_id: $usuario_id, postagem_id: $postagem_id, comentario: $comentario)';

  @override
  bool operator ==(covariant Comentarios other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuario_id == usuario_id &&
      other.postagem_id == postagem_id &&
      other.comentario == comentario;
  }

  @override
  int get hashCode => usuario_id.hashCode ^ postagem_id.hashCode ^ comentario.hashCode;
}
