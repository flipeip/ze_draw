// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comentarios {
  final int usuarioId;
  final int postagem;
  final String comentario;
  Comentarios({
    required this.usuarioId,
    required this.postagem,
    required this.comentario,
  });

  Comentarios copyWith({
    int? usuarioId,
    int? postagem,
    String? comentario,
  }) {
    return Comentarios(
      usuarioId: usuarioId ?? this.usuarioId,
      postagem: postagem ?? this.postagem,
      comentario: comentario ?? this.comentario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario_id': usuarioId,
      'postagem': postagem,
      'comentario': comentario,
    };
  }

  factory Comentarios.fromMap(Map<String, dynamic> map) {
    return Comentarios(
      usuarioId: map['usuario_id'] as int,
      postagem: map['postagem'] as int,
      comentario: map['comentario'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comentarios.fromJson(String source) => Comentarios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Comentarios(usuario_id: $usuarioId, postagem: $postagem, comentario: $comentario)';

  @override
  bool operator ==(covariant Comentarios other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuarioId == usuarioId &&
      other.postagem == postagem &&
      other.comentario == comentario;
  }

  @override
  int get hashCode => usuarioId.hashCode ^ postagem.hashCode ^ comentario.hashCode;
}
