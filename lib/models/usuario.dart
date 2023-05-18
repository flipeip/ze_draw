// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usuario {
  final String nome;
  final String foto;
  final bool status;
  final String celular;
  final String user_id;
  Usuario({
    required this.nome,
    required this.foto,
    required this.status,
    required this.celular,
    required this.user_id,
  });

  Usuario copyWith({
    String? nome,
    String? foto,
    bool? status,
    String? celular,
    String? user_id,
  }) {
    return Usuario(
      nome: nome ?? this.nome,
      foto: foto ?? this.foto,
      status: status ?? this.status,
      celular: celular ?? this.celular,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'foto': foto,
      'status': status,
      'celular': celular,
      'user_id': user_id,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] as String,
      foto: map['foto'] as String,
      status: map['status'] as bool,
      celular: map['celular'] as String,
      user_id: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, foto: $foto, status: $status, celular: $celular, user_id: $user_id)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.foto == foto &&
      other.status == status &&
      other.celular == celular &&
      other.user_id == user_id;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
      foto.hashCode ^
      status.hashCode ^
      celular.hashCode ^
      user_id.hashCode;
  }
}
