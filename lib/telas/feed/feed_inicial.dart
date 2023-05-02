import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/campo_pesquisa.dart';

class FeedTela extends StatelessWidget {
  const FeedTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CampoPesquisa(label: 'Pesquisar'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.ellipsisVertical), color: Color(0xFF679C8A)),
        ],
        shadowColor: Colors.black12,
        elevation: 10,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
            Post(),
            const Divider(color: Color(0XFFF1F1F1),thickness: 10),
            Post(),
          ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFD9F4EB),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(FontAwesomeIcons.calendar)
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userGroup),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimney),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidBell),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCircleUser),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Color(0xffA3A3A3),
        selectedItemColor: Color(0xFF679C8A),
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: 
          Container(
            width: 60,
            height: 60,
            child: Icon(FontAwesomeIcons.paintbrush, color: Colors.white,),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0XFFFF2626), Color(0XFFFFA800), Color(0XFF34D1DB)]),
            ),
          ),
          shape: CircleBorder(),
        ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
              CircleAvatar(backgroundColor: Colors.cyan,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(children: [ 
                  Text('Mickey Mouse'),
                  Text('12 min atrás'),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ]
        ),
      ),
      Placeholder(),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child:
          Row(
            children: [
              Row(
                children: [
                TextButton.icon(onPressed: (){}, icon: Icon(FontAwesomeIcons.solidStar, color: Color(0xFF679C8A)), label: Text('82', style: TextStyle(color: Color(0xFF679C8A))),),
                TextButton.icon(onPressed: (){}, icon: Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)), label: Text('22', style: TextStyle(color: Color(0xFF989898))),),
                IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.share), color: Color(0xFF989898)),
              ],)
            ]
        )
      )
    ]);
  }
}


