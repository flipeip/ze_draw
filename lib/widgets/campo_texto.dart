import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CampoTexto extends StatefulWidget {
  final String label;
  final bool oculto;
  final TextEditingController? controlador;
  final ValueNotifier<String?>? erro;

  const CampoTexto({
    required this.label,
    this.controlador,
    this.oculto = false,
    this.erro,
    super.key,
  });

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  bool _ocultarTexto = false;
  String? _erro;

  @override
  void initState() {
    if (widget.oculto) _ocultarTexto = true;
    super.initState();

    widget.erro?.addListener(() {
      setState(() => _erro = widget.erro?.value);
    });
  }

  @override
  void dispose() {
    widget.erro?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(90),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 5),
                color: Colors.blueGrey.shade500.withOpacity(0.3),
              )
            ],
          ),
          child: TextFormField(
            controller: widget.controlador,
            obscureText: _ocultarTexto,
            onChanged: _campoAlterado,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.label,
              hintStyle: Theme.of(context)
                  .inputDecorationTheme
                  .hintStyle
                  ?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
              suffixIcon: widget.oculto
                  ? IconButton(
                      icon: Icon(_ocultarTexto
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: toggleSenha,
                    )
                  : null,
            ),
          ),
        ),
        if (_erro != null)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              _erro!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.red.shade700),
            ),
          ),
      ],
    );
  }

  void _campoAlterado(String value) {
    widget.erro?.value = null;
  }

  void toggleSenha() {
    setState(() {
      _ocultarTexto = !_ocultarTexto;
    });
  }
}
