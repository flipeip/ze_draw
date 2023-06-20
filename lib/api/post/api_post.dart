import '../../../models/models.dart';
import '../../models/post/usuario_conquista.dart';
import '../api.dart';

class ApiPost {
  Future<List<dynamic>> createData(PostagemCreate post) async {
    List<dynamic> res = await api.from('postagem').insert(post.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao, usuario_id, data_publicacao, evento').order('data_publicacao', ascending: false);
    return res;
  }

  Future<List<dynamic>> readDataEvento() async {
    List<dynamic> res = await api.from('postagem')
        .select().not('evento', 'is', null).order('data_publicacao', ascending: false);
    return res;
  }

  Future<dynamic> readPost(int? postagem) async {
    List<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao, usuario_id, data_publicacao').eq('id', postagem).order('data_publicacao', ascending: false);
    return res;
  }

  Future<dynamic> getUltimoEvento() async {
    List<dynamic> res = await api.from('evento')
        .select().order('data_termino', ascending: false).limit(1);
    return res;
  }

  Future<dynamic> novaConquista(UsuarioConquista conquista) async {
    List<dynamic> res = await api.from('usuario_conquista').insert(conquista.toMap()).select();
    return res;
  }

  Future<String> getEventoBucketUrl(String eventoId) async {
    final eventoBucket = api.storage.from('capa_evento').getPublicUrl(eventoId);
    return eventoBucket;
  }

  Future<List<Usuario>> getUsuarioPostagem(int? usuarioId) async {
    List<dynamic> usuarioPostagem = await api.from('usuario').select().eq('id', usuarioId);
    return (usuarioPostagem).map((e) => Usuario.fromMap(e)).toList();
  }
}
