// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Arquivo {
  // final int? id;
  final int? postagem;
  final String arquivo;
  Arquivo({
    // this.id,
    this.postagem,
    required this.arquivo,
  });

  Arquivo copyWith({
    // int? id,
    int? postagem,
    String? arquivo,
  }) {
    return Arquivo(
      // id: id ?? this.id,
      postagem: postagem ?? this.postagem,
      arquivo: arquivo ?? this.arquivo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'postagem': postagem,
      'arquivo': arquivo,
    };
  }

  factory Arquivo.fromMap(Map<String, dynamic> map) {
    return Arquivo(
      // id: map['id'] != null ? map['id'] as int : null,
      postagem: map['postagem'] != null ? map['postagem'] as int : null,
      arquivo: map['arquivo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Arquivo.fromJson(String source) => Arquivo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Arquivo(ipostagem: $postagem, arquivo: $arquivo)';
  // String toString() => 'Arquivo(id: $id, postagem: $postagem, arquivo: $arquivo)';

  @override
  bool operator ==(covariant Arquivo other) {
    if (identical(this, other)) return true;
  
    return 
      // other.id == id &&
      other.postagem == postagem &&
      other.arquivo == arquivo;
  }

  @override
  int get hashCode => postagem.hashCode ^ arquivo.hashCode;
  // int get hashCode => id.hashCode ^ postagem.hashCode ^ arquivo.hashCode;
}
