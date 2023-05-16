// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Postagem {
  final String titulo;
  final String descricao;
  final int usuario_id;
  Postagem({
    required this.titulo,
    required this.descricao,
    required this.usuario_id,
  });

  Postagem copyWith({
    String? titulo,
    String? descricao,
    int? usuario_id,
  }) {
    return Postagem(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      usuario_id: usuario_id ?? this.usuario_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descricao': descricao,
      'usuario_id': usuario_id,
    };
  }

  factory Postagem.fromMap(Map<String, dynamic> map) {
    return Postagem(
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      usuario_id: map['usuario_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Postagem.fromJson(String source) => Postagem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Postagem(titulo: $titulo, descricao: $descricao, usuario_id: $usuario_id)';

  @override
  bool operator ==(covariant Postagem other) {
    if (identical(this, other)) return true;
  
    return 
      other.titulo == titulo &&
      other.descricao == descricao &&
      other.usuario_id == usuario_id;
  }

  @override
  int get hashCode => titulo.hashCode ^ descricao.hashCode ^ usuario_id.hashCode;
}
