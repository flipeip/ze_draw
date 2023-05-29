import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../api/api.dart';
import '../../api/api_perfil.dart';
import '../../models/usuario.dart';
import '../../widgets/botao_default.dart';
import '../../widgets/campo_texto.dart';
import '../rotas.dart';
import 'perfil_novo_controlador.dart';
import 'package:path/path.dart' as path;

class NovoPerfilTela extends StatefulWidget {
  const NovoPerfilTela({Key? key}): super(key: key);

  @override
  State<NovoPerfilTela> createState() => _NovoPerfilTela();
}
class _NovoPerfilTela extends State<NovoPerfilTela>{
  NovoPerfilControlador controlador = NovoPerfilControlador();

  ApiPerfil criarPerfil = ApiPerfil();

  File? imagemSelecionada;

  bool _isBadgeTapped = false;

  Future<void> selecionarImagem() async {
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
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF34D1DB),
            Color(0xFFFFA800),
            Color(0xFFFF2626),
            Color(0xFFFF2626),
            Color(0xFFFF2626),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.0,
          centerTitle: true,
          title: const Text("Perfil", style: TextStyle(color: Colors.white, fontSize: 20),),
          backgroundColor: Colors.transparent,
          
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.82,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
                      ),
                      child:
                       Transform.translate(
                        offset: Offset(0, -50.0),
                         child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:32.0),
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          GestureDetector(
                            onTap: () {
                              if (_isBadgeTapped) {
                                selecionarImagem();
                              }
                            },
                            child: Badge(
                                alignment: AlignmentDirectional.bottomEnd,
                                backgroundColor: Color(0xFF679C8A),
                                largeSize: 32,
                                padding: EdgeInsets.all(8),
                                label: Icon(FontAwesomeIcons.pencil, color: Colors.white, size: 16),
                                child:
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isBadgeTapped = true;
                                      });
                                    },
                                    child: Container(
                                    width: 100,
                                    height: 100,
                                    child: imagemSelecionada != null
                                      ? null
                                      : Icon(FontAwesomeIcons.userLarge, color: Colors.white, size: 50),
                                    decoration: BoxDecoration(
                                      image: imagemSelecionada != null
                                      ? DecorationImage(
                                          image: FileImage(imagemSelecionada!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          const SizedBox(height: 18),
                          CampoTexto(
                            label: 'Usuário',
                            controlador: controlador.usuario,
                          ),
                          const SizedBox(height: 24),
                          CampoTexto(
                            label: 'Nome',
                            controlador: controlador.nome,
                          ),
                          const SizedBox(height: 24),
                          CampoTexto(
                            label: 'Celular',
                            controlador: controlador.celular,
                          ),
                          const SizedBox(height: 24),
                          CampoTexto(
                            label: 'Data Nascimento',
                            controlador: controlador.dataNascimento,
                          ),
                          const SizedBox(height: 24),
                          BotaoPadrao(
                            texto: 'Salvar Perfil',
                            aoClicar: _createData,
                          ),
                          const SizedBox(height: 32),
                          BotaoPadrao(
                            texto: 'Continuar sem perfil',
                            aoClicar: _createWithNoData,
                            buttonType: 'lightButton',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _createData() async {
    final uuid = Uuid();
    final new_uuid = uuid.v4();

    Usuario usuario = Usuario(foto: new_uuid+path.extension(imagemSelecionada!.path), nome: controlador.nome.text, user_id: api.auth.currentUser!.id, usuario: controlador.usuario.text, celular: controlador.celular.text);
  
    List<dynamic> res = await criarPerfil.createData(usuario);
    await api.storage.from("fotos_usuario").upload('${new_uuid+path.extension(imagemSelecionada!.path)}', imagemSelecionada!);
    // if (res.error != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.error!.message)));
    // }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Perfil criado com sucesso!", style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));

    Navigator.of(context).pushNamed(Rotas.telaIncial);
  }

  Future _createWithNoData() async {
    Usuario usuario = Usuario(user_id: api.auth.currentUser!.id);
    List<dynamic> res = await criarPerfil.createData(usuario);
    // if (res.error != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.error!.message)));
    // }
    Navigator.of(context).pushNamed(Rotas.telaIncial);
  }
}

class _Divisor extends StatelessWidget {
  const _Divisor();

  @override
  Widget build(BuildContext context) {
    final cor = Theme.of(context).colorScheme.outline.withOpacity(0.5);
    final divisor = Expanded(child: Divider(color: cor));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          divisor,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ou',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cor,
                  ),
            ),
          ),
          divisor,
        ],
      ),
    );
  }
}