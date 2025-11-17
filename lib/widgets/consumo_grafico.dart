import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/abastecimento/abastecimento_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class ConsumoChartPage extends StatelessWidget {
  const ConsumoChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final veiculoVM = context.watch<VeiculoViewModel>();
    final abastecimentoVM = context.watch<AbastecimentoViewModel>();

    // Calcular consumo médio de cada veículo
    final consumosPorVeiculo = veiculoVM.veiculos.map((v) {
      final abastecimentos = abastecimentoVM.abastecimentos
          .where((a) => a.veiculoId == v.id)
          .toList();
      double consumoMedio = 0;
      if (abastecimentos.isNotEmpty) {
        consumoMedio = abastecimentos
                .map((a) => a.consumo)
                .reduce((a, b) => a + b) /
            abastecimentos.length;
      }
      return {'veiculo': v.modelo, 'consumo': consumoMedio};
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: consumosPorVeiculo
                    .map((c) => c['consumo'] as double)
                    .reduce((a, b) => a > b ? a : b) +
                5, // margem superior
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, _) => Text("${value.toStringAsFixed(1)} km/L"),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index >= 0 && index < consumosPorVeiculo.length) {
                      return Text(consumosPorVeiculo[index]['veiculo'] as String);
                    }
                    return const Text('');
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(consumosPorVeiculo.length, (i) {
              final consumo = consumosPorVeiculo[i]['consumo'] as double;
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: consumo,
                    color: Colors.red,
                    width: 20,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
