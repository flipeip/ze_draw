import '../api.dart';

class ApiEvento {
  Future<List<dynamic>> readData() async {
    List<dynamic> res = await api.from('evento').select();
    return res;
  }

  Future<dynamic> readEvento(int? eventoId) async {
    List<dynamic> res = await api.from('evento').select().eq('id', eventoId);
    return res;
  }
}
