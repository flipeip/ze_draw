// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Conquista {
  final String conquista;
  final String icon;
  Conquista({
    required this.conquista,
    required this.icon,
  });

  Conquista copyWith({
    String? conquista,
    String? icon,
  }) {
    return Conquista(
      conquista: conquista ?? this.conquista,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conquista': conquista,
      'icon': icon,
    };
  }

  factory Conquista.fromMap(Map<String, dynamic> map) {
    return Conquista(
      conquista: map['conquista'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conquista.fromJson(String source) => Conquista.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Conquista(conquista: $conquista, icon: $icon)';

  @override
  bool operator ==(covariant Conquista other) {
    if (identical(this, other)) return true;
  
    return 
      other.conquista == conquista &&
      other.icon == icon;
  }

  @override
  int get hashCode => conquista.hashCode ^ icon.hashCode;
}
