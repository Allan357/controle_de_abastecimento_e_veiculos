import 'package:controle_de_abastecimento_e_veiculos/features/auth/viewmodel/login_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: formKey, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(controller: emailController, 
                decoration: InputDecoration(label: Text("E-mail")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail';
                  }
                  return null;
                },),
                const SizedBox(height: 16),
                TextFormField(controller: senhaController, 
                obscureText: true, 
                decoration: InputDecoration(label: Text("Senha")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  return null;
                },),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => AppNavigator.goToRegister(context),
                  child: const Text(
                    "Ainda não tem conta?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: vm.loading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final ok = await vm.login(
                            emailController.text,
                            senhaController.text,
                          );

                          if (!context.mounted) return;

                          if (ok) AppNavigator.goToNewAbastecimento(context);
                        },
                  child: vm.loading
                      ? CircularProgressIndicator()
                      : Text("Entrar"),
                ),
                if (vm.error != null) Text(vm.error!, style: TextStyle(color: Colors.red)),
              ],
          ),),
        )
      ),
    );
  }
}
