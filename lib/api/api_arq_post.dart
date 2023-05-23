import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/models.dart';
import 'api.dart';

class ApiArquivoPost {
  Future<PostgrestResponse<dynamic>> createData(Arquivo arquivo) async {
    PostgrestResponse<dynamic> res = await api.from('arquivo').insert(arquivo.toMap());
    return res;
  }
  
  Future<PostgrestResponse<dynamic>> readData() async {
    PostgrestResponse<dynamic> res = await api.from('arquivo')
        .select('id, postagem, arquivo');
    return res;
  }
}
