import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/telas/login/login_controlador.dart';
import 'package:ze_draw/telas/tela_inicial.dart';

import '../api/api.dart';


class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton(
          color: Colors.white,
          offset: const Offset(0, 42),
          icon: const Icon(FontAwesomeIcons.ellipsisVertical, color: Color(0xFF679C8A)),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 'sair',
              child: Text('Sair')
            ),
          ],
          onSelected: (value) {
            if (value == 'sair') {
              api.auth.signOut(); // Executa o logout
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: LoginControlador(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
            }
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const TelaInicial(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      title: const Text('Feed Inicial', style: TextStyle(fontSize: 18, color: Color(0xFF679C8A), fontWeight: FontWeight.w500)),
      shadowColor: Colors.black12,
      elevation: 10,
      surfaceTintColor: Colors.white,
      iconTheme: const IconThemeData(color: Color(0xFF679C8A)),
    );
  }
}