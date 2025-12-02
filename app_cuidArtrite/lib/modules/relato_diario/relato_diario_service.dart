import 'package:cloud_firestore/cloud_firestore.dart';

class RelatoDiarioService {
  final CollectionReference relatosRef = FirebaseFirestore.instance.collection('relatos_diarios');
  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  Future<void> saveRelatos({
    required String usuarioID,
    required Map<String, int?> respostas,
  }) async {
    try{
      await relatosRef.add({
      'usuario_id': usuarioID,
      'respostas': respostas,
      'data_envio': DateTime.now(),
    });
    }
    catch (e) {
      throw Exception('Erro ao salvar relatos diários: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRelatos(String usuarioID) async {
    try {
      final snapshot = await relatosRef
          .where('usuario_id', isEqualTo: usuarioID)
          .orderBy('data_envio', descending: true)    // acho que vamos mudar isso depois (nao precisamos da data para o usuario)
          .get();
      
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Erro ao buscar relatos diários: $e');
    }
  }

  // método para verificar se o usuário já enviou um relato hoje
  Future<bool> relatoEnviadoHoje(String usuarioID) async {
    final hoje = DateTime.now();
    final snapshot = await relatosRef
        .where('usuario_id', isEqualTo: usuarioID)
        .orderBy('data_envio', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return false;
    } 

    final ultimoRelato = snapshot.docs.first['data_envio'].toDate() as DateTime;
    return ultimoRelato.year == hoje.year &&
            ultimoRelato.month == hoje.month &&
            ultimoRelato.day == hoje.day;
  }

  Future<List<Map<String, dynamic>>> getRelatosUltimos7Dias(String uid) async {
  final agora = DateTime.now();
  final limite = agora.subtract(const Duration(days: 7));

  final snap = await _fire
      .collection("relatos_diarios")
      .doc(uid)
      .collection("dias")
      .where("data", isGreaterThanOrEqualTo: limite)
      .orderBy("data")
      .get();

  return snap.docs.map((d) => d.data()).toList();
}
}