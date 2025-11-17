import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/abastecimento/abastecimento_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/model/abastecimento_model.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:controle_de_abastecimento_e_veiculos/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbastecimentoFormPage extends StatefulWidget {
  const AbastecimentoFormPage({super.key});

  @override
  State<AbastecimentoFormPage> createState() => _AbastecimentoFormPageState();
}

class _AbastecimentoFormPageState extends State<AbastecimentoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final litros = TextEditingController();
  final valor = TextEditingController();
  final km = TextEditingController();
  final tipoCombustivel = TextEditingController();
  final obs = TextEditingController();

  String? veiculoId;
  DateTime data = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final vmAb = context.read<AbastecimentoViewModel>();
    final vmVeiculos = context.watch<VeiculoViewModel>();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Registrar Abastecimento")),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: veiculoId,
                  hint: Text("Selecione o veículo"),
                  items: vmVeiculos.veiculos
                      .map((v) => DropdownMenuItem(
                            value: v.id,
                            child: Text("${v.modelo} - ${v.placa}"),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => veiculoId = v),
                  validator: (v) => v == null ? "Selecione um veículo" : null,
                ),
                TextFormField(
                  controller: litros,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Litros Abastecidos"),
                  validator: (v) => v!.isEmpty ? "Informe a quantidade" : null,
                ),
                TextFormField(
                  controller: valor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Valor Pago"),
                  validator: (v) => v!.isEmpty ? "Informe o valor" : null,
                ),
                TextFormField(
                  controller: km,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Quilometragem Atual"),
                  validator: (v) => v!.isEmpty ? "Informe o km" : null,
                ),
                TextFormField(
                  controller: tipoCombustivel,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Tipo de combustivel"),
                  validator: (v) => v!.isEmpty ? "Informe o Tipo de combustivel" : null,
                ),
                TextFormField(
                  controller: obs,
                  decoration: InputDecoration(labelText: "Observação (opcional)"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final litrosNum = double.parse(litros.text);
                    final kmNum = int.parse(km.text);
                    final tc = tipoCombustivel.text;

                    final ultimo = vmAb.ultimoAbastecimentoDoVeiculo(veiculoId!);

                    double consumo = 0;

                    if (ultimo != null) {
                      final distancia = kmNum - ultimo.quilometragem;

                      if (distancia > 0) {
                        consumo = distancia / litrosNum;
                      }
                    }

                    final a = AbastecimentoModel(
                      data: data,
                      quantidadeLitros: litrosNum,
                      valorPago: double.parse(valor.text),
                      quilometragem: kmNum,
                      tipoCombustivel: tc,
                      veiculoId: veiculoId!,
                      consumo: consumo,
                      observacao: obs.text,
                    );

                    vmAb.adicionar(a);
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Abastecimento salvo com sucesso!"),
                        duration: const Duration(seconds: 2),
                      )
                    );
                    // Navigator.pop(context);
                  },
                  child: Text("Salvar"),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
