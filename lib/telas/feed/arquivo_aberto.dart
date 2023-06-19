import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/telas/post/novo_post.dart';
import 'package:ze_draw/widgets/app_bar_default.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/post/api_arq_post.dart';
import '../../api/post/api_post.dart';

class ArquivoAbertoTela extends StatefulWidget {
  final int? post;

  const ArquivoAbertoTela({Key? key, required this.post}): super(key: key);

  @override
  State<ArquivoAbertoTela> createState() => _ArquivoAbertoTelaState();
}

class _ArquivoAbertoTelaState extends State<ArquivoAbertoTela> {

  @override
  Widget build(BuildContext context) {
    ApiPost lerPost = ApiPost();

    Future<List<Postagem>> readPost(int? postagem) async {
      List<dynamic> response = await lerPost.readPost(postagem);
      return (response).map((e) => Postagem.fromMap(e)).toList();
    }

    ApiArquivoPost lerArquivos = ApiArquivoPost();

    return Scaffold(
      appBar: const AppBarDefault(),
      body: FutureBuilder(
        future: readPost(widget.post),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            Postagem postagem = snapshot.data![0];
            return FutureBuilder<List<Arquivo>>(
              future: lerArquivos.getArquivosDaPostagem(postagem.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: const Center(
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  final arquivos = snapshot.data ?? [];
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          color: const Color(0xFF242424),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                                begin: const FractionalOffset(0.5, 0.2),
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcATop,
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: arquivos
                                .map(
                                  (arquivo) => FutureBuilder<String>(
                                    future: lerArquivos.getArquivoBucketUrl('${postagem.id}/${arquivo.arquivo}'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final imageUrl = snapshot.data!;
                                        return FittedBox(
                                          fit: BoxFit.contain,
                                          child: Image.network(imageUrl)
                                        );
                                      } else {
                                        return const Text('Imagem indisponível');
                                      }
                                    },
                                  ),
                                )
                                .toList(),
                              ),
                            ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postagem.titulo, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400)),
                              Text(postagem.descricao, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                            ],
                          )
                        )
                      ]
                    );
                }
              },
            );
            }
            return const Center(child: CircularProgressIndicator(color: Color(0xFF679C8A)));
          }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const NovoPostTela(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        shape: const CircleBorder(),
        child: 
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0XFFFF2626), Color(0XFFFFA800), Color(0XFF34D1DB)]),
            ),
            child: const Icon(FontAwesomeIcons.paintbrush, color: Colors.white,),
          ),
        ),
    );
  }
}