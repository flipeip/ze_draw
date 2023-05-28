import '../../../models/models.dart';
import '../api.dart';

class ApiComentariosPost {
  Future<List<dynamic>> createData(Comentarios comentarios) async {
    List<dynamic> res = await api.from('comentario').insert(comentarios.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('comentario')
        .select('id, usuario_id, postagem, comentario');
    return res;
  }
}
