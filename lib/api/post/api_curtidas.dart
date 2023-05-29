import '../../../models/models.dart';
import '../api.dart';

class ApiCurtidasPost {
  Future<List<dynamic>> createData(Curtidas curtidas) async {
    List<dynamic> res = await api.from('curtidas').insert(curtidas.toMap()).select();
    return res;
  }

  Future deleteData(String postagem, String usuarioId) async {
    await api.from('curtidas').delete().match({'postagem_id': postagem, 'usuario_id': usuarioId});
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('curtidas')
        .select('usuario_id, postagem_id');
    return res;
  }
  
  Future<List<dynamic>> getCurtidasPostagem(int? postagemId) async {
    List<dynamic> curtidasPost = await api.from('curtidas').select().eq('postagem_id', postagemId);
    return curtidasPost;
  }
}
