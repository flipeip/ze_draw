// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usuario {
  final String? nome;
  final String? foto;
  final bool? status;
  final String? celular;
  final String userId;
  final String? dataNascimento;
  final String? usuario;
  final String? capa;
  Usuario({
    this.nome,
    this.foto,
    this.status,
    this.celular,
    required this.userId,
    this.dataNascimento,
    this.usuario,
    this.capa,
  });

  Usuario copyWith({
    String? nome,
    String? foto,
    bool? status,
    String? celular,
    String? userId,
    String? dataNascimento,
    String? usuario,
    String? capa,
  }) {
    return Usuario(
      nome: nome ?? this.nome,
      foto: foto ?? this.foto,
      status: status ?? this.status,
      celular: celular ?? this.celular,
      userId: userId ?? this.userId,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      usuario: usuario ?? this.usuario,
      capa: capa ?? this.capa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'foto': foto,
      'status': status,
      'celular': celular,
      'user_id': userId,
      'data_nascimento': dataNascimento,
      'usuario': usuario,
      'capa': capa,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] != null ? map['nome'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
      userId: map['user_id'] as String,
      dataNascimento: map['data_nascimento'] != null ? map['data_nascimento'] as String : null,
      usuario: map['usuario'] != null ? map['usuario'] as String : null,
      capa: map['capa'] != null ? map['capa'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, foto: $foto, status: $status, celular: $celular, user_id: $userId, data_nascimento: $dataNascimento, usuario: $usuario, capa: $capa)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.foto == foto &&
      other.status == status &&
      other.celular == celular &&
      other.userId == userId &&
      other.dataNascimento == dataNascimento &&
      other.usuario == usuario &&
      other.capa == capa;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
      foto.hashCode ^
      status.hashCode ^
      celular.hashCode ^
      userId.hashCode ^
      dataNascimento.hashCode ^
      usuario.hashCode ^
      capa.hashCode;
  }
}
