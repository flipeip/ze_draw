import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../api/api_perfil.dart';
import '../../api/autenticacao.dart';
import '../../models/usuario.dart';

class PerfilTela extends StatefulWidget {
  const PerfilTela({Key? key}): super(key: key);

  @override
  State<PerfilTela> createState() => _PerfilTela();
}
class _PerfilTela extends State<PerfilTela>{
  ApiPerfil lerPerfil = ApiPerfil();
  int? usuario = Autenticacao.usuario;

  Future<List<Usuario>> readData() async {
      List<dynamic> response = await lerPerfil.getUsuario(usuario!);
      return (response).map((e) => Usuario.fromMap(e)).toList();
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: readData(),
          builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return Builder(
              builder: ((BuildContext context) {
              Usuario perfil = snapshot.data![0];
              return Column(
                children: [
                  Container(
                    height: 120,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -55.0),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      maxRadius: 48,
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
                              Column(children: [
                                const SizedBox(height: 28),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(onPressed: (){}, style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),), child: const Text('Tornar-se Fã', style: TextStyle(color: Color(0xFF679C8A), fontSize: 12),)),
                                )
                              ],),
                              Column(children: [
                                const SizedBox(height: 28),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(onPressed: (){}, style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFFD9F4EB)),), child: const Text('Compartilhar', style: TextStyle(color: Color(0xFF679C8A), fontSize: 12),)),
                                )
                              ],)
                            ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:4.0),
                                  child: CircleAvatar(maxRadius: 28),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:4.0),
                                  child: CircleAvatar(maxRadius: 28),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:4.0),
                                  child: CircleAvatar(maxRadius: 28),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:4.0),
                                  child: CircleAvatar(child: Text('+3', style: TextStyle(color: Colors.white, fontSize: 20),),maxRadius: 28, backgroundColor: Colors.grey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Align(
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
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                for (var i = 1; i <= 10; i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8),
                                  child: 
                                  Container(
                                    height: MediaQuery.sizeOf(context).width * 0.26,
                                    width: MediaQuery.sizeOf(context).width * 0.26,
                                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(15))),
                                  )
                                ),
                              ],
                            )
                          ],)
                        ),
                      ],
                    ),
                  )
                ]
              );
          }));
          } else {
            return Text('Ocorreu um erro');
          }
        })),
      )
    );
  }
}
