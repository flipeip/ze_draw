import '../../../models/models.dart';
import '../api.dart';

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

  Future<String> getArquivoBucketUrl(String arquivo) async {
    final arquivoBucket = api.storage.from('arquivos_postagem').getPublicUrl(arquivo);
    return arquivoBucket;
  }

  Future<List<Arquivo>> getArquivosDaPostagem(int? postagemId) async {
    List<dynamic> arquivosPostagem = await api.from('arquivo').select().eq('postagem', postagemId);
    return (arquivosPostagem).map((e) => Arquivo.fromMap(e)).toList();
  }
}
