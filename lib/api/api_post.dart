import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/models.dart';
import 'api.dart';
import 'dart:io';

class ApiPost {
  Future<PostgrestResponse<dynamic>> createData(Postagem post, List<File> files) async {
    PostgrestResponse<dynamic> res = await api.from('postagem').insert(post.toMap());

    for(var file in files) {
      await api.storage.from("arquivos_postagem").upload(file.path, file);
    }
    return res;
  }
  
  Future<PostgrestResponse<dynamic>> readData() async {
    PostgrestResponse<dynamic> res = await api.from('postagem')
        .select('id, titulo, descricao');
    return res;
  }
}
