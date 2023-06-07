// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Postagem {
  final int? id;
  final String titulo;
  final String descricao;
  late final int usuarioId;
  final String dataPublicacao;
  Postagem({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.usuarioId,
    required this.dataPublicacao,
  });

  Postagem copyWith({
    int? id,
    String? titulo,
    String? descricao,
    int? usuarioId,
    String? dataPublicacao,
  }) {
    return Postagem(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      usuarioId: usuarioId ?? this.usuarioId,
      dataPublicacao: dataPublicacao ?? this.dataPublicacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'usuario_id': usuarioId,
      'data_publicacao': dataPublicacao,
    };
  }

  factory Postagem.fromMap(Map<String, dynamic> map) {
    return Postagem(
      id: map['id'] != null ? map['id'] as int : null,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      usuarioId: map['usuario_id'] as int,
      dataPublicacao: map['data_publicacao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Postagem.fromJson(String source) => Postagem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Postagem(id: $id, titulo: $titulo, descricao: $descricao, usuario_id: $usuarioId, data_publicacao: $dataPublicacao)';
  }

  @override
  bool operator ==(covariant Postagem other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.titulo == titulo &&
      other.descricao == descricao &&
      other.usuarioId == usuarioId &&
      other.dataPublicacao == dataPublicacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      titulo.hashCode ^
      descricao.hashCode ^
      usuarioId.hashCode ^
      dataPublicacao.hashCode;
  }
}
