import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ze_draw/telas/rotas.dart';
import '../api/autenticacao.dart';
import 'feed/feed_inicial.dart';
import 'perfil/perfil_tela.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indexAtual = 2;

  List<Widget> _telas = [
    FeedTela(),
    FeedTela(),
    FeedTela(),
    FeedTela(),
    PerfilTela(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _indexAtual = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    Autenticacao.getUsuario();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(Rotas.login);
          },
        ),
        title: const Text('Feed Inicial', style: TextStyle(fontSize: 18, color: Color(0xFF679C8A), fontWeight: FontWeight.w500)),
        shadowColor: Colors.black12,
        elevation: 10,
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF679C8A)),
      ),
      body: _telas[_indexAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: _indexAtual == 0 ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.calendar)
            )
            : Icon(FontAwesomeIcons.calendar),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _indexAtual == 1 ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.userGroup)
            )
            : Icon(FontAwesomeIcons.userGroup),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _indexAtual == 2 ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.houseChimney)
            )
            : Icon(FontAwesomeIcons.houseChimney),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _indexAtual == 3 ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.solidBell)
            )
            : Icon(FontAwesomeIcons.solidBell),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _indexAtual == 4 ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.solidCircleUser)
            )
            : Icon(FontAwesomeIcons.solidCircleUser),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Color(0xffA3A3A3),
        selectedItemColor: Color(0xFF679C8A),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}