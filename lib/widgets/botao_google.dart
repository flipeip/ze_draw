import 'package:flutter/material.dart';

class EntrarComGoogle extends StatelessWidget {
  const EntrarComGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(90);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: Colors.blueGrey.shade500.withOpacity(0.3),
          )
        ],
      ),
      child: Material(
        borderRadius: borderRadius,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: borderRadius,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 4,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/google.png'),
                ),
                Text(
                  'Entrar com Google',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}