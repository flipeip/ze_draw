import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/models.dart';
import 'api.dart';

class ApiPost {
  Future<List<dynamic>> createData(Postagem post) async {
    List<dynamic> res = await api.from('postagem').insert(post.toMap()).select();
    return res;
  }
  
  Future<PostgrestResponse<dynamic>> readData() async {
    PostgrestResponse<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao');
    return res;
  }
}
