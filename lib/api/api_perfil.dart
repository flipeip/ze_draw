import '../../models/models.dart';
import 'api.dart';

class ApiPerfil {
  Future<List<dynamic>> createData(Usuario usuario) async {
    List<dynamic> res = await api.from('usuario').insert(usuario.toMap()).select();
    return res;
  }
  
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('usuario')
        .select('id, nome, usuario, celular, usuario_id, data_nascimento');
    return res;
  }

  Future<String> getUsuarioBucketUrl(String arquivo) async {
    final usuarioBucket = await api.storage.from('fotos_usuario').getPublicUrl(arquivo);
    return usuarioBucket as String;
  }
}
