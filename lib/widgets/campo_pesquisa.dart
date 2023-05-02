import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class CampoPesquisa extends StatefulWidget {
  final String label;

  const CampoPesquisa({
    required this.label,
    super.key,
  });

  @override
  State<CampoPesquisa> createState() => _CampoPesquisaState();
}

class _CampoPesquisaState extends State<CampoPesquisa> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0XFFF1F1F1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
          hintText: widget.label,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(FontAwesomeIcons.magnifyingGlass, color: Color(0xFF679C8A), size: 18,),
          ),
      ),
    );
  }
}