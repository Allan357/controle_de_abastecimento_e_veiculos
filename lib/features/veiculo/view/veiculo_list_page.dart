import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/view/veiculo_form_page.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculoListPage extends StatefulWidget {
  const VeiculoListPage({super.key});
  @override
  State<VeiculoListPage> createState() => _VeiculoListPageState();
}

class _VeiculoListPageState extends State<VeiculoListPage> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VeiculoViewModel>();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Meus Veículos")),
      body: vm.loading
          ? Center(child: CircularProgressIndicator())
          : Center(
            child: ListView.builder(
                itemCount: vm.veiculos.length,
                itemBuilder: (_, i) {
                  final v = vm.veiculos[i];
                  return ListTile(
                    title: Text("${v.modelo} - ${v.placa}"),
                    subtitle: Text("Ano: ${v.ano} | ${v.tipoCombustivel}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => vm.excluir(v.id!),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VeiculoFormPage(veiculo: v))),
                  );
                },
              ),
          ),
    );
  }
}

