import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:uuid/uuid.dart';
import 'package:ze_draw/api/post/api_arq_post.dart';
import 'package:ze_draw/widgets/app_bar_default.dart';


import '../../api/api.dart';
import '../../api/api_perfil.dart';
import '../../api/autenticacao.dart';
import '../../models/post/arquivos_postagem.dart';
import '../../models/usuario.dart';
import '../feed/post_aberto.dart';

class PerfilTela extends StatefulWidget {
  final int? usuario;

  const PerfilTela({Key? key, required this.usuario}): super(key: key);

  @override
  State<PerfilTela> createState() => _PerfilTela();
}
class _PerfilTela extends State<PerfilTela>{
  ApiPerfil lerPerfil = ApiPerfil();
  ApiArquivoPost lerArquivos = ApiArquivoPost();

  Future<List<Usuario>> readData() async {
    List<dynamic> response = await lerPerfil.getUsuario(widget.usuario!);
    return (response).map((e) => Usuario.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDefault(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: readData(),
          builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: const Center(
                  child:
                    CircularProgressIndicator(color: Colors.blueGrey,)
                ),
            );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return Builder(
                builder: ((BuildContext context) {
                Usuario perfil = snapshot.data![0];
                return Column(
                  children: [
                    CapaWidget(perfil: perfil, usuarioPerfil: widget.usuario!),
                    Transform.translate(
                      offset: const Offset(0, -54),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FutureBuilder(
                              future: lerPerfil.getUsuarioBucketUrl('${perfil.foto}'),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),
                                    child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                                  );
                                } else if (snapshot.hasData) {
                                  final imageUrl = snapshot.data!;
                                  return CircleAvatar(
                                    maxRadius: 43,
                                    backgroundImage: Image.network(imageUrl).image,
                                  );
                                } else {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),
                                    child: const Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 20),
                                  );
                                }
                              })),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('${perfil.nome}',
                                style: const TextStyle(color: Colors.white,
                                fontSize: 22)),
                              ),
                              const SizedBox(height: 12),
                              InteracoesWidget(perfil: perfil, usuario: widget.usuario!,)
                            ],),
                          ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.userGroup, color: Colors.black, size: 12),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Fãs', textAlign: TextAlign.left),
                                  ),
                                ],
                              )
                            ),
                          ),
                          FutureBuilder<List<Usuario>>(
                            future: lerPerfil.getFas(widget.usuario!),
                            builder: (context, snapshot) {
                              final fas = snapshot.data ?? [];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: fas.map(
                                  (fa) => FutureBuilder<String>(
                                    future: lerPerfil.getUsuarioBucketUrl('${fa.foto}'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: CircleAvatar(
                                          maxRadius: 28,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                                            child: Image.network(snapshot.data!),
                                          )
                                          ),
                                      );
                                      } else {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(horizontal:12.0),
                                          child: Text('Você ainda não possui fãs :( Publique suas artes e interaja para conseguir novos fãs!', style: TextStyle(color: Colors.grey),),
                                        );
                                      }
                                    }
                                  )
                                ).toList(),
                              );
                            }
                          ),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.palette, color: Colors.black, size: 12),
                                  Padding(
                                    padding: EdgeInsets.only(left:9.0),
                                    child: Text('Galeria', textAlign: TextAlign.left),
                                  ),
                                ],
                              )
                            ),
                          ),
                          FutureBuilder<List<Arquivo>>(
                            future: lerPerfil.getArquivosPostsUsuario(widget.usuario!),
                            builder: (context, snapshot) {
                              final arquivos = snapshot.data ?? [];
                              return Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                children: arquivos
                                .map(
                                  (arquivo) => FutureBuilder<String>(
                                    future: lerArquivos.getArquivoBucketUrl('${arquivo.postagem}/${arquivo.arquivo}'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final imageUrl = snapshot.data!;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8),
                                          child: 
                                          GestureDetector(
                                            onTap: (){
                                              PersistentNavBarNavigator.pushNewScreen(
                                                  context,
                                                  screen: PostAbertoTela(post: arquivo.postagem),
                                                  withNavBar: true,
                                                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                              );
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context).width * 0.27,
                                              width: MediaQuery.sizeOf(context).width * 0.27,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                child: Image.network(imageUrl, fit: BoxFit.cover),
                                              ),
                                            ),
                                          )
                                        );
                                      } else {
                                        return const Text('Imagem indisponível');
                                      }
                                    },
                                  ),
                                ).toList(),
                              );
                            }
                          ),
                        ],),
                      ),
                    )
                  ]
                );
              }));
              } else {
                return const Text('Ocorreu um erro');
              }
        })),
      )
    );
  }
}
class CapaWidget extends StatefulWidget{
  final Usuario perfil;
  final int usuarioPerfil;

  const CapaWidget({super.key, required this.perfil, required this.usuarioPerfil});

  @override
    State<CapaWidget> createState() => _CapaWidgetState();
  }
  class _CapaWidgetState extends State<CapaWidget> {
    ApiPerfil lerPerfil = ApiPerfil();

    File? imagemSelecionada;

    bool _isBadgeTapped = true;

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<String>(
        future: lerPerfil.getUsuarioCapaBucketUrl('${widget.perfil.capa}'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black45, Colors.black54, Colors.black87]
              ),
            ),
          );
          } else if (snapshot.hasData && widget.perfil.capa != null) {
            if (widget.usuarioPerfil == Autenticacao.usuario as int){
              return GestureDetector(
              onTap: () {
                if (_isBadgeTapped) {
                  _atualizarCapa();
                }
              },
              child: Badge(
                largeSize: 25,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                label: const Icon(FontAwesomeIcons.camera, color: Colors.white, size: 12,),
                backgroundColor: Colors.black26,
                alignment: const Alignment(0.85, 0.9),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isBadgeTapped = true;
                    });
                  },
                  child:SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        child: Image.network(snapshot.data!, fit: BoxFit.cover),
                      ),
                  ),
                ),
              ),
            );
            }else{
              return SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    child: Image.network(snapshot.data!, fit: BoxFit.cover),
                  ),
              );
            }
          } else {
            return GestureDetector(
              onTap: () {
                if (_isBadgeTapped) {
                  _atualizarCapa();
                }
              },
              child: Badge(
                largeSize: 25,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                label: const Icon(FontAwesomeIcons.camera, color: Colors.white, size: 12,),
                backgroundColor: Colors.black26,
                alignment: const Alignment(0.85, 0.9),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isBadgeTapped = true;
                    });
                  },
                  child:Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black45, Colors.black54, Colors.black87]
                        )
                      ),
                  ),
                ),
              ),
            );
          }
      }));
    }


    Future _atualizarCapa() async {
      final capa = widget.perfil.capa;
      if (capa != null){
        await api.storage.from("capa_usuario").remove([capa]);
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        setState(() {
          imagemSelecionada = File(file.path!);
        });
      }

      var uuid = const Uuid();
      final newUuid = uuid.v4();
      api.storage.from("capa_usuario").upload(newUuid+path.extension(imagemSelecionada!.path), imagemSelecionada!);

      lerPerfil.updateCapa(widget.usuarioPerfil, newUuid+path.extension(imagemSelecionada!.path));

      setState(() {
        lerPerfil.getUsuarioCapaBucketUrl(newUuid+path.extension(imagemSelecionada!.path));
      });
    }
}


class InteracoesWidget extends StatefulWidget{
  final Usuario perfil;
  final int usuario;
  const InteracoesWidget({super.key, required this.perfil, required this.usuario});

  @override
    State<InteracoesWidget> createState() => _InteracoesWidgetState();
  }

  class _InteracoesWidgetState extends State<InteracoesWidget> {
    ApiPerfil lerPerfil = ApiPerfil();
    int? usuarioLogado = Autenticacao.usuario;

    @override
    Widget build(BuildContext context) {
      return Row(
        children: [
          FutureBuilder(
            future: lerPerfil.getFas(widget.usuario),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: TextButton.icon(
                    onPressed: () => virarFa(widget.usuario, usuarioLogado),
                    icon: const Icon(FontAwesomeIcons.plus, color: Color(0xFF679C8A),size: 11),
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),),
                    label: const Text('Tornar-se Fã',
                      style: TextStyle(color: Color(0xFF679C8A),
                      fontSize: 11, fontWeight: FontWeight.w300),
                      )
                    ),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child:  FutureBuilder(
                    future: lerPerfil.isFa(widget.usuario, usuarioLogado),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TextButton.icon(
                          onPressed: () => virarFa(widget.usuario, usuarioLogado),
                          icon: const Icon(FontAwesomeIcons.plus, color: Color(0xFF679C8A),size: 11,),
                          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),),
                          label: const Text('Tornar-se Fã',
                            style: TextStyle(color: Color(0xFF679C8A),
                            fontSize: 11, fontWeight: FontWeight.w300),
                            )
                          );
                        } else {
                          return TextButton.icon(
                            onPressed: () => virarFa(widget.usuario, usuarioLogado),
                            icon: snapshot.data! == true ? const Icon(FontAwesomeIcons.minus, color: Color(0xFF679C8A),size: 11,) : const Icon(FontAwesomeIcons.plus, color: Color(0xFF679C8A),size: 11,) ,
                            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),),
                            label: snapshot.data! == true  ? const Text('Deixar de ser fã', textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF679C8A),
                              fontSize: 11, fontWeight: FontWeight.w300),
                              ) : const Text('Tornar-se Fã',
                              style: TextStyle(color: Color(0xFF679C8A),
                              fontSize: 11, fontWeight: FontWeight.w300),
                              )
                            );
                          }
                        }
                    )
                  ),
                );
              }
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.34,
            child: TextButton.icon(
              onPressed: (){},
              icon: const Icon(FontAwesomeIcons.share, color: Color(0xFF679C8A),size: 11),
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),),
              label: const Text('Compartilhar',
              style: TextStyle(color: Color(0xFF679C8A),
              fontSize: 11,fontWeight: FontWeight.w300),
              )
              ),
          ),
        )
        ],
      );
    }

    Future<void> virarFa(int usuarioId, int? faId) async {
      try {
        await api.from('usuarios_fa').insert({'usuario_id': usuarioId, 'fa_id': faId});
      } catch(error){
        await api.from('usuarios_fa').delete().match({'usuario_id': usuarioId, 'fa_id': faId});
      }

      setState(() {
        lerPerfil.getFas(widget.usuario);
      });
    }
  }