import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/telas/tela_inicial.dart';


class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: (){
        }, icon: const Icon(FontAwesomeIcons.ellipsisVertical), color: const Color(0xFF679C8A)),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: TelaInicial(),
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