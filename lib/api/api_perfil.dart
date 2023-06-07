import '../../models/models.dart';
import '../models/usuarios_fa.dart';
import 'api.dart';

class ApiPerfil {
  Future<List<dynamic>> createData(Usuario usuario) async {
    List<dynamic> res = await api.from('usuario').insert(usuario.toMap()).select();
    return res;
  }

  Future<List<dynamic>> createFaData(UsuarioFa fa) async {
    List<dynamic> res = await api.from('usuarios_fa').insert(fa.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('usuario')
        .select('id, nome, foto, usuario, celular, user_id, data_nascimento');
    return res;
  }

  // Future<List<dynamic>> updateData(Usuario usuario) async {
  //   List<dynamic> res = await api.from('usuario').update(usuario.toMap()).select();
  //   return res;
  // }

  Future updateCapa(int usuarioID, String capa) async {
    await api.from('usuario').update({'capa': capa}).match({'id': usuarioID});
  }

  Future<List<dynamic>> getUsuario(int usuarioId) async {
    List<dynamic> res = await api.from('usuario')
        .select().eq('id', usuarioId);
    return res;
  }

  Future<bool> isFa(int usuarioId, int? faId) async {
    List<dynamic> res = await api.from('usuarios_fa').select().eq('usuario_id', usuarioId).eq('fa_id', faId);
    return res.isNotEmpty;
  }

  Future<List<Usuario>> getFas(int usuarioId) async {
    List<dynamic> res = await api.from('usuarios_fa').select().eq('usuario_id', usuarioId);
    final fas = res.map((item) => item['fa_id']);

    List<dynamic> usuariosFas = await api.from('usuario').select().in_('id', fas.toList());
    return (usuariosFas).map((e) => Usuario.fromMap(e)).toList();
  }

  Future<String> getUsuarioBucketUrl(String arquivo) async {
    final usuarioBucket = api.storage.from('fotos_usuario').getPublicUrl(arquivo);
    return usuarioBucket;
  }

  Future<String> getUsuarioCapaBucketUrl(String arquivo) async {
    final capaBucket = api.storage.from('capa_usuario').getPublicUrl(arquivo);
    return capaBucket;
  }

  Future<List<dynamic>> getPostsUsuario(int usuarioId) async {
    List<dynamic> res = await api.from('postagem')
        .select('id').eq('usuario_id', usuarioId);
    return res;
  }

  Future<List<Arquivo>> getArquivosPostsUsuario(int usuarioId) async {
    List<dynamic> response = await getPostsUsuario(usuarioId);
    final postsDoUsuario = response.map((item) => item['id']);

    List<dynamic> arquivosPostagem = await api.from('arquivo').select().in_('postagem', postsDoUsuario.toList());
    return (arquivosPostagem).map((e) => Arquivo.fromMap(e)).toList();
  }


}
