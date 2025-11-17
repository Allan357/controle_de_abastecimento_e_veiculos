import '../../../core/exceptions/auth_exception.dart';
import '../../../core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService service;

  AuthRepository(this.service);

  Future<void> login(String email, String senha) async {
    try {
      await service.login(email, senha);
    } catch (e) {
      throw AuthException('Erro ao fazer login: ${e.toString()}');
    }
  }

  Future<void> register(String email, String senha) async {
    try {
      await service.register(email, senha);
    } catch (e) {
      throw AuthException('Erro ao cadastrar usuário: ${e.toString()}');
    }
  }

  bool isLogged() => service.currentUser != null;
}
