import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/register_viewmodel.dart';
import '../../../routes/app_navigator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("E-mail"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira um e-mail";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Senha"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira uma senha";
                    }
                    if (value.length < 6) {
                      return "A senha deve ter pelo menos 6 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => AppNavigator.goToLogin(context),
                  child: const Text(
                    "Já tem uma conta?",
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

                          final ok = await vm.register(
                            emailController.text,
                            senhaController.text,
                          );

                          if (!context.mounted) return;

                          if (ok) AppNavigator.goToHome(context);
                        },
                  child: vm.loading
                      ? const CircularProgressIndicator()
                      : const Text("Criar Conta"),
                ),
                const SizedBox(height: 12),
                if (vm.error != null)
                  Text(
                    vm.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
