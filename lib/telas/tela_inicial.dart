import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/autenticacao.dart';
import 'feed/feed_inicial.dart';
import 'perfil/perfil_tela.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      const FeedTela(),
      const FeedTela(),
      const FeedTela(),
      const FeedTela(),
      PerfilTela(usuario: Autenticacao.usuario)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: const Icon(FontAwesomeIcons.calendar),
            activeColorPrimary: const Color(0xFF679C8A),
            inactiveColorPrimary: const Color(0xffA3A3A3),
        ),
         PersistentBottomNavBarItem(
            icon: const Icon(FontAwesomeIcons.userGroup),
            activeColorPrimary: const Color(0xFF679C8A),
            inactiveColorPrimary: const Color(0xffA3A3A3),
        ),
         PersistentBottomNavBarItem(
            icon: const Icon(FontAwesomeIcons.houseChimney),
            activeColorPrimary: const Color(0xFF679C8A),
            inactiveColorPrimary: const Color(0xffA3A3A3),
        ),
         PersistentBottomNavBarItem(
            icon: const Icon(FontAwesomeIcons.solidBell),
            activeColorPrimary: const Color(0xFF679C8A),
            inactiveColorPrimary: const Color(0xffA3A3A3),
        ),
         PersistentBottomNavBarItem(
            icon: const Icon(FontAwesomeIcons.solidCircleUser),
            activeColorPrimary: const Color(0xFF679C8A),
            inactiveColorPrimary: const Color(0xffA3A3A3),
        ),
      ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarHeight: 70,
        confineInSafeArea: true,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.white,
          border: Border.all(color: const Color(0xffA3A3A3), width: 0.3),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style1,
        
    );
  }
}