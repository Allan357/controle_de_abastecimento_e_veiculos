import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/abastecimento/abastecimento_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbastecimentoListPage extends StatelessWidget {
  const AbastecimentoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AbastecimentoViewModel>();
    final vmVeiculos = context.watch<VeiculoViewModel>();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Histórico de Abastecimentos")),
      body: vm.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.abastecimentos.length,
              itemBuilder: (_, i) {
                final a = vm.abastecimentos[i];

                final veiculo = vmVeiculos.veiculos
                    .where((v) => v.id == a.veiculoId)
                    .firstOrNull;

                final titulo = veiculo != null
                    ? "${veiculo.modelo} — ${veiculo.placa}"
                    : "Veículo não encontrado";

                return ListTile(
                  title: Text(titulo),
                  subtitle: Text(
                    "Litros: ${a.quantidadeLitros} — "
                    "Consumo: ${a.consumo.toStringAsFixed(2)} km/L",
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => vm.excluir(a.id!),
                  ),
                );
              },
            ),
    );
  }
}
