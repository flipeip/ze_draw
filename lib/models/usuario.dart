// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usuario {
  final String? nome;
  final String? foto;
  final bool? status;
  final String? celular;
  final String user_id;
  final String? data_nascimento;
  final String? usuario;
  Usuario({
    this.nome,
    this.foto,
    this.status,
    this.celular,
    required this.user_id,
    this.data_nascimento,
    this.usuario,
  });

  Usuario copyWith({
    String? nome,
    String? foto,
    bool? status,
    String? celular,
    String? user_id,
    String? data_nascimento,
    String? usuario,
  }) {
    return Usuario(
      nome: nome ?? this.nome,
      foto: foto ?? this.foto,
      status: status ?? this.status,
      celular: celular ?? this.celular,
      user_id: user_id ?? this.user_id,
      data_nascimento: data_nascimento ?? this.data_nascimento,
      usuario: usuario ?? this.usuario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'foto': foto,
      'status': status,
      'celular': celular,
      'user_id': user_id,
      'data_nascimento': data_nascimento,
      'usuario': usuario,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] != null ? map['nome'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
      user_id: map['user_id'] as String,
      data_nascimento: map['data_nascimento'] != null ? map['data_nascimento'] as String : null,
      usuario: map['usuario'] != null ? map['usuario'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, foto: $foto, status: $status, celular: $celular, user_id: $user_id, data_nascimento: $data_nascimento, usuario: $usuario)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.foto == foto &&
      other.status == status &&
      other.celular == celular &&
      other.user_id == user_id &&
      other.data_nascimento == data_nascimento &&
      other.usuario == usuario;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
      foto.hashCode ^
      status.hashCode ^
      celular.hashCode ^
      user_id.hashCode ^
      data_nascimento.hashCode ^
      usuario.hashCode;
  }
}
