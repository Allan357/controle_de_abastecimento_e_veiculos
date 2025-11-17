import 'package:controle_de_abastecimento_e_veiculos/routes/app_navigator.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastro de Livros',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Bem-vindo!',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Página Inicial',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToHome(context);
            },
          ),
          ListTile(
            title: Text(
              'Meus Veículos',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToVeiculos(context);
            },
          ),
          ListTile(
            title: Text(
              'Registrar Veículos',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToNewVeiculo(context);
            },
          ),
          ListTile(
            title: Text(
              'Registrar Abastecimento',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToNewAbastecimento(context);
            },
          ),
          ListTile(
            title: Text(
              'Histórico de Abastecimentos',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToAbastecimento(context);
            },
          ),
          ListTile(
            title: Text(
              'Sair',
              style: TextStyle(
                color: theme.colorScheme.onSurface, // texto padrão
              ),
            ),
            onTap: () {
              AppNavigator.goToLogin(context);
            },
          ),
        ],
      ),
    );
  }
}
