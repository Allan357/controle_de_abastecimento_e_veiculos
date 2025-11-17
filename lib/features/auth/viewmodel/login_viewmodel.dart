import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repo;

  LoginViewModel(this.repo);

  final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

  bool loading = false;
  String? error;

  Future<bool> login(String email, String senha) async {
    loading = true;
    error = null;
    notifyListeners();

    if (!emailRegex.hasMatch(email)) {
      error = 'E-mail inválido';
      loading = false;
      return false;
    }

    try {
      await repo.login(email, senha);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
