import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/campo_pesquisa.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/botao_default.dart';
import 'package:file_picker/file_picker.dart';

import '../../api/api_post.dart';
import '../../api/api.dart';
import '../../models/models.dart';
import 'novo_post_controlador.dart';

class NovoPostTela extends StatefulWidget {
  const NovoPostTela({Key? key}): super(key: key);

  @override
  State<NovoPostTela> createState() => _NovoPostTela();
}
class _NovoPostTela extends State<NovoPostTela>{
  NovoPostControlador controlador = NovoPostControlador();

  // instance
  ApiPost criarPost = ApiPost();

  List<File> files = [];

  bool uploadState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CampoPesquisa(label: 'Pesquisar'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.ellipsisVertical), color: const Color(0xFF679C8A)),
        ],
        shadowColor: Colors.black12,
        elevation: 10,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    setState((){
                      uploadState = false;
                    });
                    var pickedFile = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']
                    );
                    if (pickedFile != null) {
                      files = pickedFile.paths.map((path) => File(path!)).toList();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: DottedBorder(
                        color: const Color(0XFF679C8A),
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(15),
                        dashPattern: const [10, 10],
                        child: Center(
                          child:
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child:
                                          SvgPicture.asset(
                                          'assets/images/photo_film.svg',
                                          height: 45,
                                        ),
                                      ),
                                      const Text('Adicionar novo arquivo',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),
                                      const Text('Somente imagens ou vídeos'),
                                    ],
                                )
                            )
                        )
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0XFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 68.0,
                          height: 68.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10),
                          child:
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0XFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              width: 68.0,
                              height: 68.0,
                            )
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0XFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 68.0,
                          height: 68.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0XFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              width: 68.0,
                              height: 68.0,
                            )
                        ),
                      ]
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child:
                    TextFormField(
                      controller: controlador.titulo,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFF1F1F1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                          hintText: "Título",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 22),
                      ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child:
                    TextFormField(
                      controller: controlador.descricao,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFF1F1F1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                          hintText: "Descrição",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 70),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8),
                  child:
                    BotaoPadrao(
                      texto: 'Publicar novo post',
                      aoClicar: _createData,
                    ),
                )
              ]
            )
          )
        ]
      )
    );
  }

  Future _createData() async {
    List data = await api.from('usuario').select('id').eq('user_id', api.auth.currentUser?.id);
    int usuario = data[0]['id'];

    Postagem postagem = Postagem(titulo: controlador.titulo.text, descricao: controlador.descricao.text, usuario_id: usuario);

    PostgrestResponse<dynamic> res = await criarPost.createData(postagem, files);

    // if (res.error != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.error!.message)));
    // }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post criado!")));

  }
  
}