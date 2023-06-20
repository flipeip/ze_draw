// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ze_draw/api/post/api_arq_post.dart';
import 'package:ze_draw/telas/feed/post_aberto.dart';
import 'package:ze_draw/telas/perfil/perfil_tela.dart';
import 'package:ze_draw/telas/post/novo_post.dart';
import 'package:ze_draw/widgets/app_bar_default.dart';
import '../../api/api_perfil.dart';
import '../../api/autenticacao.dart';
import '../../api/post/api_comentarios.dart';
import '../../api/post/api_curtidas.dart';
import 'package:ze_draw/models/models.dart';
import '../../api/post/api_post.dart';

class EventoTela extends StatelessWidget {
  const EventoTela({super.key});
  @override
  Widget build(BuildContext context) {

    ApiPost lerPost = ApiPost();
    late final int? eventoId;

    Future<List<Postagem>> readDataEvento() async {
      List<dynamic> response = await lerPost.readDataEvento();
      return (response).map((e) => Postagem.fromMap(e)).toList();
    }

    void getUltimoEvento() async {
      List<dynamic> response = await lerPost.getUltimoEvento();
      eventoId = response[0]['id'];
    }
    getUltimoEvento();

    return Scaffold(
      appBar: const AppBarDefault(),
      body: FutureBuilder(
        future: readDataEvento(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: (snapshot.data!).length,
              itemBuilder: ((BuildContext context, int index) {
              Postagem postagem = (snapshot.data!)[index];
              return PostagemWidget(postagem: postagem);
              }
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: Color(0xFF679C8A),));
          }
          return const Padding(
            padding: EdgeInsets.all(55.0),
            child: Center(child: Text("Ainda não há posts em eventos... Publique a primeira arte!", style: TextStyle(color: Color(0xFF989898)))),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'novoPostEvento',
        onPressed: (){
          PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: NovoPostTela(evento: eventoId),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: 
          Container(
            width: 60,
            height: 60,
            child: const Icon(FontAwesomeIcons.paintbrush, color: Colors.white,),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0XFFFF2626), Color(0XFFFFA800), Color(0XFF34D1DB)]),
            ),
          ),
          shape: const CircleBorder(),
        ),
    );
  }
}

class PostagemWidget extends StatefulWidget {
  final Postagem postagem;

  const PostagemWidget({super.key, required this.postagem});

  @override
  State<PostagemWidget> createState() => _PostagemWidgetState();
}

class _PostagemWidgetState extends State<PostagemWidget> {
  DateTime dataAtual = DateTime.now();

  ApiPost lerPost = ApiPost();
  ApiArquivoPost lerArquivos = ApiArquivoPost();
  ApiPerfil lerPerfil = ApiPerfil();

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
    return Column(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
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
                  )],
                ),
                widget.postagem.evento != null ?
                  SvgPicture.asset(
                    'assets/images/event-calendar.svg',
                    height: 30,
                  )
                : Container()
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
                              return GestureDetector(
                                onTap: (){
                                  PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: PostAbertoTela(post: widget.postagem.id),
                                      withNavBar: true,
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return LinearGradient(
                                              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                              begin: const FractionalOffset(0.5, 0.3),
                                              end: Alignment.bottomCenter,
                                            ).createShader(bounds);
                                          },
                                          blendMode: BlendMode.srcATop,
                                          child: Image.network(imageUrl))
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      child: Text(widget.postagem.titulo, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300))
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
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(255, 218, 218, 218)))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: AcoesWidget(postagem: widget.postagem),
          ),
        ),
      ],
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
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PostAbertoTela(post: widget.postagem.id),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
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
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PostAbertoTela(post: widget.postagem.id),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
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