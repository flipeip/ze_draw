import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/campo_pesquisa.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/botao_default.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api_post.dart';
import '../../models/models.dart';
import 'novo_post_controlador.dart';
import 'package:ze_draw/api/api.dart';

class NovoPostTela extends StatefulWidget {
  const NovoPostTela({Key? key}): super(key: key);

  @override
  State<NovoPostTela> createState() => _NovoPostTela();
}
class _NovoPostTela extends State<NovoPostTela>{
  NovoPostControlador controlador = NovoPostControlador();

  // instance
  ApiPost criarPost = ApiPost();
  
  @override
  Widget build(BuildContext context) {
    XFile? image;

    final ImagePicker picker = ImagePicker();
  
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
      body: Column(
        children:[
          Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    picker.pickImage(source: ImageSource.gallery);
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: DottedBorder(
                        color: Color(0XFF679C8A),
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(15),
                        dashPattern: [10, 10],
                        child: Center(
                          child:
                            Padding(
                              padding: EdgeInsets.all(20),
                              child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child:
                                          SvgPicture.asset(
                                          'assets/images/photo_film.svg',
                                          height: 45,
                                        ),
                                      ),
                                      Text('Adicionar novo arquivo',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),
                                      Text('Somente imagens ou vídeos'),
                                    ],
                                )
                            )
                        )
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child:
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 68.0,
                          height: 68.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:10),
                          child:
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              width: 68.0,
                              height: 68.0,
                            )
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 68.0,
                          height: 68.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFF1F1F1),
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
                  padding: EdgeInsets.symmetric(vertical:10),
                  child:
                    TextFormField(
                      controller: controlador.titulo,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0XFFF1F1F1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                          hintText: "Título",
                          contentPadding: EdgeInsets.symmetric(horizontal: 22),
                      ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:10),
                  child:
                    TextFormField(
                      controller: controlador.descricao,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0XFFF1F1F1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                          hintText: "Descrição",
                          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 70),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:8),
                  child:
                    BotaoEntrar(
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
    int usuario = data![0]['id'];

    Postagem postagem = Postagem(titulo: controlador.titulo.text, descricao: controlador.descricao.text, usuario_id: usuario);

    PostgrestResponse<dynamic> res = await criarPost.createData(postagem);

    // if (res.error != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.error!.message)));
    // }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post criado!")));

  }
}