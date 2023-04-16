import 'package:flutter/material.dart';

class Tema {
  static final padrao = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ),
  );
}
