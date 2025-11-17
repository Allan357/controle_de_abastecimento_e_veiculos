import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  static void goToNewVeiculo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.newVeiculo);
  }

  static void goToVeiculos(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.veiculos);
  }

  static void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.register);
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (_) => false,
    );
  }
}
