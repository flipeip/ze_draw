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
}
