import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/model/veiculo_model.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/viewmodel/veiculo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculoFormPage extends StatefulWidget {
  final VeiculoModel? veiculo; // null = criar | não-null = editar

  const VeiculoFormPage({this.veiculo, super.key});

  @override
  State<VeiculoFormPage> createState() => _VeiculoFormPageState();
}

class _VeiculoFormPageState extends State<VeiculoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final modelo = TextEditingController();
  final marca = TextEditingController();
  final placa = TextEditingController();
  final ano = TextEditingController();
  final tipo = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Se estiver editando, preenche os campos
    if (widget.veiculo != null) {
      modelo.text = widget.veiculo!.modelo;
      marca.text = widget.veiculo!.marca;
      placa.text = widget.veiculo!.placa;
      ano.text = widget.veiculo!.ano.toString();
      tipo.text = widget.veiculo!.tipoCombustivel;
    }
  }

  @override
  Widget build(BuildContext context) {
    // importantíssimo: read e não watch
    final vm = context.read<VeiculoViewModel>();

    final isEditing = widget.veiculo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar Veículo" : "Cadastrar Veículo"),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: modelo,
                  decoration: InputDecoration(labelText: "Modelo"),
                  validator: (value) =>
                      value!.isEmpty ? "Informe o modelo" : null,
                ),
                TextFormField(
                  controller: marca,
                  decoration: InputDecoration(labelText: "Marca"),
                  validator: (value) =>
                      value!.isEmpty ? "Informe a marca" : null,
                ),
                TextFormField(
                  controller: placa,
                  decoration: InputDecoration(labelText: "Placa"),
                  validator: (value) =>
                      value!.isEmpty ? "Informe a placa" : null,
                ),
                TextFormField(
                  controller: ano,
                  decoration: InputDecoration(labelText: "Ano"),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty || value.length != 4  ? "Informe o ano" : null,
                ),
                TextFormField(
                  controller: tipo,
                  decoration: InputDecoration(labelText: "Tipo Combustível"),
                  validator: (value) =>
                      value!.isEmpty ? "Informe o tipo de combustível" : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: Text(isEditing ? "Salvar Alterações" : "Cadastrar"),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final data = VeiculoModel(
                      id: widget.veiculo?.id,
                      modelo: modelo.text,
                      marca: marca.text,
                      placa: placa.text,
                      ano: int.parse(ano.text),
                      tipoCombustivel: tipo.text,
                    );

                    if (isEditing) {
                      await vm.editar(widget.veiculo!.id!, data);
                    } else {
                      await vm.adicionar(data);
                    }
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isEditing ? "Alterações salvas com sucesso!" : "Cadastro realizado com sucesso!"),
                        duration: const Duration(seconds: 2),
                      )
                    );

                    // if (!context.mounted) return;
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}
