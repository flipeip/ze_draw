// ignore_for_file: sort_child_properties_last

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/api/post/api_arq_post.dart';
import 'package:ze_draw/telas/perfil/perfil_tela.dart';
import 'package:ze_draw/widgets/app_bar_default.dart';
import '../../api/api_perfil.dart';
import '../../api/autenticacao.dart';
import '../../api/post/api_comentarios.dart';
import '../../api/post/api_curtidas.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/post/api_post.dart';
import 'arquivo_aberto.dart';
import 'comentar_controlador.dart';

class PostAbertoTela extends StatefulWidget {
  final int? post;

  const PostAbertoTela({Key? key, required this.post}): super(key: key);

  @override
  State<PostAbertoTela> createState() => _PostAbertoTelaState();
}

class _PostAbertoTelaState extends State<PostAbertoTela> {

  @override
  Widget build(BuildContext context) {
    ApiPost lerPost = ApiPost();

    Future<List<Postagem>> readPost(int? postagem) async {
      List<dynamic> response = await lerPost.readPost(postagem);
      return (response).map((e) => Postagem.fromMap(e)).toList();
    }

    return Scaffold(
      appBar: const AppBarDefault(),
      body: FutureBuilder(
        future: readPost(widget.post),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            Postagem postagem = snapshot.data![0];
           return PostagemUnicaWidget(postagem: postagem);
          }
          return const Center(child: CircularProgressIndicator(color: Color(0xFF679C8A)));
        }),
      ),
    );
  }
}

class PostagemUnicaWidget extends StatefulWidget {
  final Postagem postagem;

  const PostagemUnicaWidget({super.key, required this.postagem});

  @override
  State<PostagemUnicaWidget> createState() => _PostagemUnicaWidgetState();
}

class _PostagemUnicaWidgetState extends State<PostagemUnicaWidget> {
  DateTime dataAtual = DateTime.now();

  ApiPost lerPost = ApiPost();
  ApiArquivoPost lerArquivos = ApiArquivoPost();
  ApiPerfil lerPerfil = ApiPerfil();
  ApiComentariosPost lerComentarios = ApiComentariosPost();

  ComentarioControlador controlador = ComentarioControlador();

  final PageController _pageController = PageController();

  String formatoHora(Duration duration) {
    if (duration.inDays > 1) {
      int dias = duration.inDays;
      return '$dias dias atrás';
    }else if (duration.inDays == 1) {
      int dias = duration.inDays;
      return '$dias dia atrás';
    } else if (duration.inHours > 1) {
      int horas = duration.inHours;
      return '$horas horas atrás';
    } else if (duration.inHours == 1) {
      int horas = duration.inHours;
      return '$horas hora atrás';
    } else if (duration.inHours < 1 && duration.inMinutes > 1 ){
      int minutos = duration.inMinutes;
      return '$minutos minutos atrás';
    } else {
      int minutos = duration.inMinutes;
      return '$minutos minuto atrás';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<List<Usuario>>(
              future: lerPost.getUsuarioPostagem(widget.postagem.usuarioId),
              builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                final usuario = snapshot.data;
                return Row(
                children: [
                  FutureBuilder<String>(
                    future: lerPerfil.getUsuarioBucketUrl('${usuario?[0].foto}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 42,
                          height: 42,
                          child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 197, 197, 197),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                        );
                      } else if (snapshot.hasData && usuario?[0].foto != null) {
                        final imageUrl = snapshot.data!;
                        return GestureDetector(
                          onTap: (){
                             PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: PerfilTela(usuario: widget.postagem.usuarioId),
                                withNavBar: true,
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: Image.network(imageUrl).image,
                          ),
                        );
                      } else {
                        return Container(
                          width: 42,
                          height: 42,
                          child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                          decoration: const BoxDecoration(
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
                        ? Text(usuario?[0].nome as String, style: const TextStyle(fontWeight: FontWeight.w600),)
                        : const Text('...'),
                        Text(formatoHora(dataAtual.difference(DateTime.parse(widget.postagem.dataPublicacao))), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),),
                      ],
                    ),
                  )
                ],
              );
              }}
            ),
          ),
          FutureBuilder<List<Arquivo>>(
            future: lerArquivos.getArquivosDaPostagem(widget.postagem.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 300,
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
                  return SizedBox(
                  height: 300,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: arquivos
                      .map(
                        (arquivo) => FutureBuilder<String>(
                          future: lerArquivos.getArquivoBucketUrl('${widget.postagem.id}/${arquivo.arquivo}'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final imageUrl = snapshot.data!;
                              int currentPage = _pageController.page?.round() ?? 0;
                              return GestureDetector(
                                onTap: (){
                                  PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: ArquivoAbertoTela(post: widget.postagem.id),
                                      withNavBar: false,
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: 300,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(imageUrl)
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      child: DotsIndicator(
                                        dotsCount: arquivos.length,
                                        position: currentPage.toDouble(),
                                        decorator: const DotsDecorator(
                                          activeColor: Colors.white, // Cor dos pontos ativos
                                          color: Colors.grey, // Cor dos pontos inativos
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: 
                                        Container(
                                          decoration: const BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.all(Radius.circular(6))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                  child: Text('${arquivos.length}', style: const TextStyle(color:Colors.white, fontSize: 14)),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 4.0),
                                                  child: Icon(FontAwesomeIcons.solidClone, color: Colors.white, size: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return const Text('Imagem indisponível');
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(widget.postagem.titulo, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
                Text(widget.postagem.descricao)
              ],),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(255, 218, 218, 218)))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AcoesWidget(postagem: widget.postagem),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.365,
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(color: Color(0xFFF1F1F1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical:16.0),
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.80,
                        child: TextFormField(
                          controller: controlador.comentario,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                              hintText: 'Faça um novo comentário!',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          onPressed: () => _comentarPost(widget.postagem.id),
                          icon: const Icon(FontAwesomeIcons.paperPlane, size: 18),
                          color: Colors.white,
                          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF679C8A))),
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder<List<Comentarios>>(
                  future: lerComentarios.getComentariosPostagem(widget.postagem.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal:8.0, vertical:16.0),
                        child: Text('Carregando comentários...', style: TextStyle(color: Color(0xFF989898))
                      ));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final comentarios = snapshot.data!;
                      return Column(
                        children: comentarios.map(
                          (comentario) => ComentariosWidget(postComent: widget.postagem, comentario: comentario)
                        ).toList()
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal:8.0, vertical:16.0),
                        child: Text('Não há comentários', style: TextStyle(color: Color(0xFF989898))
                      ));
                    }
                  }
                ),
              ])
          )),
          ],
      ),
    );
  }

  Future _comentarPost(postagemId) async {
    int? usuario = Autenticacao.usuario;

    Comentarios comentario = Comentarios(postagem: postagemId, usuarioId: usuario!, comentario: controlador.comentario.text);
    await lerComentarios.createData(comentario);

    setState(() {
      controlador.comentario.text = '';
      lerComentarios.getComentariosPostagem(postagemId);
    });
    
  }
  
}

class ComentariosWidget extends StatefulWidget{
  final Postagem postComent;
  final Comentarios comentario;
  const ComentariosWidget({super.key, required this.postComent, required this.comentario});

  @override
    State<ComentariosWidget> createState() => _ComentariosWidgetState();
  }

  class _ComentariosWidgetState extends State<ComentariosWidget> {
  
  ApiPerfil lerPerfil = ApiPerfil();
  ApiPost lerPost = ApiPost();
  ApiComentariosPost lerComentarios = ApiComentariosPost();
  final int? usuario = Autenticacao.usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF1F1F1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
        future: lerPost.getUsuarioPostagem(widget.comentario.usuarioId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Carregando...', style: TextStyle(color: Color(0xFF989898))));
          } else if (snapshot.hasData) {
            return Row(
              children: [
                FutureBuilder<String>(
                  future: lerPerfil.getUsuarioBucketUrl('${snapshot.data![0].foto}'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 42,
                        height: 42,
                        child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 197, 197, 197),
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      );
                    } else if (snapshot.hasData && widget.postComent.id != null) {
                      final imageUrl = snapshot.data!;
                      return GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PerfilTela(usuario: widget.postComent.usuarioId),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: Image.network(imageUrl).image,
                        ),
                      );
                    } else {
                      return Container(
                        width: 42,
                        height: 42,
                        child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                        decoration: const BoxDecoration(
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
                      widget.postComent.id != null 
                      ? Text(snapshot.data![0].nome, style: const TextStyle(fontWeight: FontWeight.w600),)
                      : const Text('...'),
                      Text(widget.comentario.comentario),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(child: Text('Ocorreu um erro'));
          }
        }
          ),
      )
    );
  }
}


class AcoesWidget extends StatefulWidget{
  final Postagem postagem;

  const AcoesWidget({super.key, required this.postagem});

  @override
    State<AcoesWidget> createState() => _AcoesWidgetState();
  }

  class _AcoesWidgetState extends State<AcoesWidget> {

    ApiCurtidasPost lerCurtida = ApiCurtidasPost();
    ApiComentariosPost lerComentarios = ApiComentariosPost();
    final int? usuario = Autenticacao.usuario;

    @override
    Widget build(BuildContext context) {
    return Row(
      children: [
      FutureBuilder<List<dynamic>>(
        future: lerCurtida.getCurtidasPostagem(widget.postagem.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextButton.icon(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.solidStar, color: Color(0xFF989898)),
              label: const Text('0', style: TextStyle(color: Color(0xFF989898))),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black12,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final curtidas = snapshot.data!.length;
            var curtido = false;
            try {
              var usuariosCurtidos = snapshot.data!.map((item) => item['usuario_id']).toList();
              if (usuariosCurtidos.contains(usuario)){
                curtido = true;
              }
            }catch (error){
              curtido = false;
            }
            return TextButton.icon(
              onPressed: () => _curtirPost(widget.postagem.id),
              icon: Icon(FontAwesomeIcons.solidStar, color: curtido == true ? const Color(0xFF679C8A): const Color(0xFF989898)),
              label: Text('$curtidas', style: TextStyle(color: curtido == true ? const Color(0xFF679C8A): const Color(0xFF989898))),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black12,
                ),
              ),
            );
          } else {
            return TextButton.icon(
              onPressed: () => _curtirPost(widget.postagem.id),
              icon: const Icon(FontAwesomeIcons.solidStar, color: Color(0xFF989898)),
              label: const Text('0', style: TextStyle(color: Color(0xFF989898))),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black12,
                ),
              ),
            );
          }
          },
        ),
        FutureBuilder<List<dynamic>>(
          future: lerComentarios.getComentariosPostagem(widget.postagem.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return TextButton.icon(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)),
                label: const Text('0', style: TextStyle(color: Color(0xFF989898))),
                style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black12,
                ),
              ),
              );
            } else if (snapshot.hasData) {
              final comentarios = snapshot.data!.length;
              return TextButton.icon(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)),
                label: Text('$comentarios', style: const TextStyle(color: Color(0xFF989898))),
                style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black12,
                ),
              ),
              );
            } else {
                return TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.solidCommentDots, color: Color(0xFF989898)),
                  label: const Text('0', style: TextStyle(color: Color(0xFF989898))),
                  style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.black12,
                  ),
                ),
              );
            }
          },
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.share),
          color: const Color(0xFF989898),
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
              (states) => Colors.black12,
            ),
          ),
        ),
      ],
    );
  }

  Future _curtirPost(postagemId) async {
    int? usuario = Autenticacao.usuario;

    Curtidas curtida = Curtidas(postagemId: postagemId, usuarioId: usuario!);
    try {
      await lerCurtida.createData(curtida);
    } catch(error){
      await lerCurtida.deleteData('$postagemId', '$usuario');
    }

    setState(() {
      lerCurtida.getCurtidasPostagem(postagemId);
    });
    
  }
}