import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/campo_pesquisa.dart';
import '../rotas.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/api.dart';
import '../../api/api_post.dart';

class FeedTela extends StatelessWidget {
  const FeedTela({super.key});

  @override
  Widget build(BuildContext context) {

    ApiPost lerPost = ApiPost();

    Future<List<Postagem>> readData() async {
      List<dynamic> response = await lerPost.readData();
      return (response).map((e) => Postagem.fromMap(e)).toList();
    }

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
      body: FutureBuilder(
        future: readData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data! as List<Postagem>).length,
              itemBuilder: ((BuildContext context, int index) {
              Postagem postagem = (snapshot.data! as List<Postagem>)[index];
              return PostagemWidget(postagem: postagem);
              }
            ));
          }
          return const Center(child: CircularProgressIndicator());
        }),
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
        onPressed: (){
          Navigator.of(context).pushNamed(Rotas.novoPost);
        },
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

class PostagemWidget extends StatelessWidget {
  final Postagem postagem;

  DateTime dataAtual = DateTime.now();

  PostagemWidget({required this.postagem});

  Future<List<Arquivo>> getArquivosDaPostagem(int? postagemId) async {
    List<dynamic> response = await api.from('arquivo').select().eq('postagem', postagemId);
    return (response).map((e) => Arquivo.fromMap(e)).toList();
  }

  Future<String> getBucketUrl(String arquivo) async {
    final response = await api.storage.from('arquivos_postagem').getPublicUrl(arquivo);
    return response as String;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.cyan,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(postagem.titulo),
                    Text('${dataAtual.difference(DateTime.parse(postagem.data_publicacao)).inHours} hora(s) atrás'),
                  ],
                ),
              )
            ],
          ),
        ),
        FutureBuilder<List<Arquivo>>(
          future: getArquivosDaPostagem(postagem.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final arquivos = snapshot.data ?? [];
              
              return SizedBox(
                  height: 300,
                  child: Scrollbar(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: arquivos
                        .map(
                          (arquivo) => FutureBuilder<String>(
                            future: getBucketUrl('${postagem.id}/${arquivo.arquivo}'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final imageUrl = snapshot.data!;
                                return Container(
                                    height: 300,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(imageUrl)
                                    ),
                                  );
                              } else {
                                return Text('Imagem indisponível');
                              }
                            },
                          ),
                        )
                        .toList(),
                      ),
                    ),
                );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            children: [
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.solidStar, color: Color(0xFF679C8A)),
                    label: Text('82', style: TextStyle(color: Color(0xFF679C8A))),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)),
                    label: Text('22', style: TextStyle(color: Color(0xFF989898))),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.share),
                    color: Color(0xFF989898),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}