import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final db = FirebaseFirestore.instance;

  Future saveDadosUsuario({
    required String uid,
    required String nome,
    required String dataNasc,
    required String sexo,
    required String celular,
    required String email,
    required String prefAces,
  }) async{
    await db.collection('usuarios').doc(uid).set({
      'nome': nome,
      'data_nasc': dataNasc,
      'sexo': sexo,
      'celular': celular,
      'email': email,
      'pref_aces': prefAces,
    });
  }
}