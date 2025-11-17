import 'package:controle_de_abastecimento_e_veiculos/features/auth/repository/auth_repository.dart';
import 'package:controle_de_abastecimento_e_veiculos/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_navigator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> checkUser() async {
    await Future.delayed(Duration.zero);
    if (!mounted) return;
    final auth = context.read<AuthRepository>();
    
    if (!auth.isLogged()) {
      AppNavigator.goToLogin(context);
    }
  }
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Tela Inicial"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          SizedBox(height: 200,
          child: Image.asset("assets/images/carro.png"),
          ),
          Text(
            "Bem-vindo ao Controle de Abastecimento!",
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ],
        )
      ),
    );
  }
}
