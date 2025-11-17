import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/abastecimento/abastecimento_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/repository/abastecimento_repository.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/view/abastecimento_form_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/view/abastecimento_list_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/home/view/home_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/repository/veiculo_repository.dart';
import 'package:controle_de_abastecimento_e_veiculos/core/services/firebase_realtime_service.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/view/veiculo_form_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/view/veiculo_list_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_routes.dart';
import 'core/services/firebase_auth_service.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/viewmodel/login_viewmodel.dart';
import 'features/auth/viewmodel/register_viewmodel.dart';
import 'features/auth/view/login_page.dart';
import 'features/auth/view/register_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "../.env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthService()),

        ProxyProvider<FirebaseAuthService, AuthRepository>(
          update: (_, service, prev) => AuthRepository(service),
        ),

        ChangeNotifierProvider(
          create: (context) => LoginViewModel(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(context.read<AuthRepository>()),
        ),

        ProxyProvider<AuthRepository, FirebaseRealtimeService>(
          update: (_, authRepo, prev) => FirebaseRealtimeService(authRepo),
        ),

        ProxyProvider<FirebaseRealtimeService, VeiculoRepository>(
          update: (_, service, prev) => VeiculoRepository(service),
        ),

        ChangeNotifierProvider(
          create: (context) => VeiculoViewModel(context.read<VeiculoRepository>()),
        ),
        ProxyProvider<FirebaseRealtimeService, AbastecimentoRepository>(
          update: (_, service, prev) => AbastecimentoRepository(service),
        ),

        ChangeNotifierProvider(
          create: (context) =>
              AbastecimentoViewModel(context.read<AbastecimentoRepository>()),
        ),

      ],
      child: const App(),
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => LoginPage(),
        AppRoutes.register: (_) => RegisterPage(),
        AppRoutes.home: (_) => HomePage(),
        AppRoutes.veiculos: (_) => VeiculoListPage(),
        AppRoutes.newVeiculo: (_) => VeiculoFormPage(),
        AppRoutes.abastecimentos: (_) => AbastecimentoListPage(),
        AppRoutes.newAbastecimento: (_) => AbastecimentoFormPage(),
      },
    );
  }
}
