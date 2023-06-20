// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostagemCreate {
  final String titulo;
  final String descricao;
  final int usuarioId;
  final int? evento;
  PostagemCreate({
    required this.titulo,
    required this.descricao,
    required this.usuarioId,
    this.evento,
  });

  PostagemCreate copyWith({
    String? titulo,
    String? descricao,
    int? usuarioId,
    int? evento,
  }) {
    return PostagemCreate(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      usuarioId: usuarioId ?? this.usuarioId,
      evento: evento ?? this.evento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descricao': descricao,
      'usuario_id': usuarioId,
      'evento': evento,
    };
  }

  factory PostagemCreate.fromMap(Map<String, dynamic> map) {
    return PostagemCreate(
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      usuarioId: map['usuario_id'] as int,
      evento: map['evento'] != null ? map['evento'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostagemCreate.fromJson(String source) => PostagemCreate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostagemCreate(titulo: $titulo, descricao: $descricao, usuario_id: $usuarioId, evento: $evento)';
  }

  @override
  bool operator ==(covariant PostagemCreate other) {
    if (identical(this, other)) return true;
  
    return 
      other.titulo == titulo &&
      other.descricao == descricao &&
      other.usuarioId == usuarioId &&
      other.evento == evento;
  }

  @override
  int get hashCode {
    return titulo.hashCode ^
      descricao.hashCode ^
      usuarioId.hashCode ^
      evento.hashCode;
  }
}
