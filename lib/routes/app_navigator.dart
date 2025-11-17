import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/view/abastecimento_form_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/view/abastecimento_list_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/auth/view/register_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/home/view/home_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/view/veiculo_form_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/view/veiculo_list_page.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppNavigator {
  static void goToHome(BuildContext context) {
    _navigateWithFade(context, AppRoutes.home, replace: true);
  }

  static void goToAbastecimento(BuildContext context) {
    _navigateWithFade(context, AppRoutes.abastecimentos);
  }

  static void goToNewAbastecimento(BuildContext context) {
    _navigateWithFade(context, AppRoutes.newAbastecimento);
  }

  static void goToNewVeiculo(BuildContext context) {
    _navigateWithFade(context, AppRoutes.newVeiculo);
  }

  static void goToVeiculos(BuildContext context) {
    _navigateWithFade(context, AppRoutes.veiculos);
  }

  static void goToRegister(BuildContext context) {
    _navigateWithFade(context, AppRoutes.register);
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (_) => false,
    );
  }

  static void _navigateWithFade(BuildContext context, String routeName, {bool replace = false}) {
    final route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _getScreenByName(routeName),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );

    if (replace) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
  }

  static Widget _getScreenByName(String routeName) {
    switch (routeName) {
      case AppRoutes.home:
        return HomePage();
      case AppRoutes.abastecimentos:
        return AbastecimentoListPage();
      case AppRoutes.newAbastecimento:
        return AbastecimentoFormPage();
      case AppRoutes.newVeiculo:
        return VeiculoFormPage();
      case AppRoutes.veiculos:
        return VeiculoListPage();
      case AppRoutes.register:
        return RegisterPage();
      default:
        return HomePage();
    }
  }
}
