import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String senha) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return result.user;
  }

  Future<User?> register(String email, String senha) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return result.user;
  }

  Future<void> logout() async => _auth.signOut();

  User? get currentUser => _auth.currentUser;
}
