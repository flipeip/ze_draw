import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BotaoPadrao extends StatelessWidget {
  final String texto;
  final void Function() aoClicar;

  const BotaoPadrao({
    required this.texto,
    required this.aoClicar,
    this.buttonType = 'default',
    super.key,
  });

  final String buttonType;
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(90);
  
    if (buttonType == 'lightButton') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Colors.redAccent,
              Colors.orange,
              Colors.orange,
              Colors.cyan]),
            width: 1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 5),
              color: Colors.blueGrey.shade500.withOpacity(0.3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            borderRadius: borderRadius,
            onTap: aoClicar,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    texto,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.orange,
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
      );
    }else{
      return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: const LinearGradient(colors: [
            Colors.redAccent,
            Colors.orange,
            Colors.orange,
            Colors.cyan,
          ], stops: [
            0,
            0.3,
            0.6,
            1,
          ]),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 5),
              color: Colors.blueGrey.shade500.withOpacity(0.3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            borderRadius: borderRadius,
            onTap: aoClicar,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    texto,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }  
    
  }
}
