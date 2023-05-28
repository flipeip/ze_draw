// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Postagem {
  final int? id;
  final String titulo;
  final String descricao;
  late final int usuario_id;
  final String data_publicacao;
  Postagem({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.usuario_id,
    required this.data_publicacao,
  });

  Postagem copyWith({
    int? id,
    String? titulo,
    String? descricao,
    int? usuario_id,
    String? data_publicacao,
  }) {
    return Postagem(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      usuario_id: usuario_id ?? this.usuario_id,
      data_publicacao: data_publicacao ?? this.data_publicacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'usuario_id': usuario_id,
      'data_publicacao': data_publicacao,
    };
  }

  factory Postagem.fromMap(Map<String, dynamic> map) {
    return Postagem(
      id: map['id'] != null ? map['id'] as int : null,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      usuario_id: map['usuario_id'] as int,
      data_publicacao: map['data_publicacao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Postagem.fromJson(String source) => Postagem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Postagem(id: $id, titulo: $titulo, descricao: $descricao, usuario_id: $usuario_id, data_publicacao: $data_publicacao)';
  }

  @override
  bool operator ==(covariant Postagem other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.titulo == titulo &&
      other.descricao == descricao &&
      other.usuario_id == usuario_id &&
      other.data_publicacao == data_publicacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      titulo.hashCode ^
      descricao.hashCode ^
      usuario_id.hashCode ^
      data_publicacao.hashCode;
  }
}
