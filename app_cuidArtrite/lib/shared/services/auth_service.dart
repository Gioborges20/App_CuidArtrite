import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._internal();

  // A única instância da classe
  static final AuthService instance = AuthService._internal();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registrar(String email, String senha) async {
    return await _auth.createUserWithEmailAndPassword( // Retorna uid do usuário criado
    email: email,
    password: senha,
    );
  }

  Future login(String email, String senha) async {
    return await _auth.signInWithEmailAndPassword(
    email: email,
    password: senha,
    );
  }

  Future logout() async {
    await _auth.signOut(); 
  }

  User? get usuarioAtual => _auth.currentUser; // Retorna o usuário atualmente logado, ou null se não houver
  }