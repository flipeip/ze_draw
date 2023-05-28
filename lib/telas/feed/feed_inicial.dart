import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api/autenticacao.dart';
import '../../api/post/api_curtidas.dart';
import '../rotas.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/api.dart';
import '../../api/post/api_post.dart';

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
      body: FutureBuilder(
        future: readData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data!).length,
              itemBuilder: ((BuildContext context, int index) {
              Postagem postagem = (snapshot.data!)[index];
              return PostagemWidget(postagem: postagem);
              }
            ));
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(Rotas.novoPost);
        },
        child: 
          Container(
            width: 60,
            height: 60,
            child: const Icon(FontAwesomeIcons.paintbrush, color: Colors.white,),
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

class PostagemWidget extends StatefulWidget {
  final Postagem postagem;

  PostagemWidget({required this.postagem});

  @override
  State<PostagemWidget> createState() => _PostagemWidgetState();
}

class _PostagemWidgetState extends State<PostagemWidget> {
  DateTime dataAtual = DateTime.now();

  ApiCurtidasPost curtir = ApiCurtidasPost();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Usuario>>(
            future: getUsuarioPostagem(widget.postagem.usuario_id),
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final usuario = snapshot.data ?? null;
              return Row(
              children: [
                FutureBuilder<String>(
                  future: getUsuarioBucketUrl('${usuario?[0].foto}'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData && usuario?[0].foto != null) {
                      final imageUrl = snapshot.data!;
                      return CircleAvatar(
                        backgroundImage: Image.network(imageUrl).image,
                      );
                    } else {
                      return Container(
                        width: 42,
                        height: 42,
                        child: Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 197, 197, 197),
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      usuario?[0].nome != null 
                      ? Text(usuario?[0].nome as String)
                      : Text('nouser'),
                      Text('${dataAtual.difference(DateTime.parse(widget.postagem.data_publicacao)).inHours} hora(s) atrás'),
                    ],
                  ),
                )
              ],
            );
            }}
          ),
        ),
        FutureBuilder<List<Arquivo>>(
          future: getArquivosDaPostagem(widget.postagem.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final arquivos = snapshot.data ?? [];
              return SizedBox(
                  height: 300,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: arquivos
                      .map(
                        (arquivo) => FutureBuilder<String>(
                          future: getArquivoBucketUrl('${widget.postagem.id}/${arquivo.arquivo}'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final imageUrl = snapshot.data!;
                              return SizedBox(
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
                );
            }
          },
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: const Color.fromARGB(255, 218, 218, 218)))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    FutureBuilder<List<dynamic>>(
                    future: getCurtidasPostagem(widget.postagem.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        final curtidas = snapshot.data!.length;
                        var curtido = false;
                        try {
                          if ('${Autenticacao.usuario}' == '${snapshot.data![0]['usuario_id']}'){
                            curtido = true;
                          }
                        }catch (error){
                          curtido = false;
                        }
                        return TextButton.icon(
                          onPressed: () => _curtirPost(widget.postagem.id),
                          icon: Icon(FontAwesomeIcons.solidStar, color: curtido == true ? Color(0xFF679C8A): Color(0xFF989898)),
                          label: Text('${curtidas}', style: TextStyle(color: curtido == true ? Color(0xFF679C8A): Color(0xFF989898))),
                        );
                      } else {
                          return Text('Error');
                        }
                      },
                    ),
                    FutureBuilder<List<dynamic>>(
                    future: getComentariosPostagem(widget.postagem.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final comentarios = snapshot.data!.length;
                        return TextButton.icon(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)),
                          label: Text('${comentarios}', style: TextStyle(color: Color(0xFF989898))),
                        );
                      } else {
                          return Text('Error');
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.share),
                      color: Color(0xFF989898),
                    ),
                  ],
                ),
              
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Usuario>> getUsuarioPostagem(int? usuarioId) async {
    List<dynamic> usuarioPostagem = await api.from('usuario').select().eq('id', usuarioId);
    return (usuarioPostagem).map((e) => Usuario.fromMap(e)).toList();
  }

  Future<List<Arquivo>> getArquivosDaPostagem(int? postagemId) async {
    List<dynamic> arquivosPostagem = await api.from('arquivo').select().eq('postagem', postagemId);
    return (arquivosPostagem).map((e) => Arquivo.fromMap(e)).toList();
  }

  Future<String> getArquivoBucketUrl(String arquivo) async {
    final arquivoBucket = await api.storage.from('arquivos_postagem').getPublicUrl(arquivo);
    return arquivoBucket as String;
  }

  Future<String> getUsuarioBucketUrl(String arquivo) async {
    final usuarioBucket = await api.storage.from('fotos_usuario').getPublicUrl(arquivo);
    return usuarioBucket as String;
  }

  Future<List<dynamic>> getCurtidasPostagem(int? postagemId) async {
    List<dynamic> curtidasPost = await api.from('curtidas').select().eq('postagem_id', postagemId);
    return curtidasPost;
  }
  
  Future<List<dynamic>> getComentariosPostagem(int? postagemId) async {
    List<dynamic> comentariosPost = await api.from('comentario').select().eq('postagem', postagemId);
    return comentariosPost;
  }


  Future _curtirPost(postagemId) async {
    int usuario = int.parse(Autenticacao.usuario ?? '');

    Curtidas curtida = Curtidas(postagem_id: postagemId, usuario_id: usuario);
    try {
      await curtir.createData(curtida);
    } catch(error){
      await curtir.deleteData('${postagemId}', '${usuario}');
    }

    setState(() {
      getCurtidasPostagem(postagemId);
    });
    
  }
  
}