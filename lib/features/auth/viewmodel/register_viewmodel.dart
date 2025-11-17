import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository repo;

  RegisterViewModel(this.repo);

  bool loading = false;
  String? error;

  final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  Future<bool> register(String email, String senha) async {
    loading = true;
    error = null;
    notifyListeners();

    if (!emailRegex.hasMatch(email)) {
      error = 'E-mail inválido';
      loading = false;
      return false;
    }

    try {
      await repo.register(email, senha);
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
