import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/api.dart';
import '../../api/post/api_arq_post.dart';
import '../../api/post/api_post.dart';
import '../login/login_controlador.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            color: Colors.white,
            offset: const Offset(0, 42),
            icon: const Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.white),
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
            Navigator.of(context).pop(context);
          },
        ),
        title: const Text('Feed Inicial', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
      )
    );
  }
}