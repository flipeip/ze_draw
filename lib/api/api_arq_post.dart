import '../../models/models.dart';
import 'api.dart';

class ApiArquivoPost {
  Future<List<dynamic>> createData(Arquivo arquivo) async {
    List<dynamic> res = await api.from('arquivo').insert(arquivo.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('arquivo')
        .select('id, postagem(id, titulo, descricao), arquivo');
    return res;
  }
}
