import '../../../models/models.dart';
import '../api.dart';

class ApiPost {
  Future<List<dynamic>> createData(PostagemCreate post) async {
    List<dynamic> res = await api.from('postagem').insert(post.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao, usuario_id, data_publicacao').order('data_publicacao', ascending: false);
    return res;
  }

  Future<dynamic> readPost(int? postagem) async {
    List<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao, usuario_id, data_publicacao').eq('id', postagem).order('data_publicacao', ascending: false);
    return res;
  }

  Future<List<Usuario>> getUsuarioPostagem(int? usuarioId) async {
    List<dynamic> usuarioPostagem = await api.from('usuario').select().eq('id', usuarioId);
    return (usuarioPostagem).map((e) => Usuario.fromMap(e)).toList();
  }
}