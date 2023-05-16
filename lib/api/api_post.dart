import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/models.dart';
import 'api.dart';

class ApiPost {
  Future<PostgrestResponse<dynamic>> createData(Postagem post) async {
    PostgrestResponse<dynamic> res = await api.from('postagem').insert(post.toMap());
    // final arquivo = File('path/to/file');
    // final String path = await supabase.storage.from('avatars').upload(
    //   'public/avatar1.png',
    //   avatarFile,
    //   fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    // );
    return res;
  }
  
  Future<PostgrestResponse<dynamic>> readData() async {
    PostgrestResponse<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao');
    return res;
  }
}