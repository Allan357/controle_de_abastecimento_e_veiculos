import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/model/veiculo_model.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/repository/veiculo_repository.dart';
import 'package:flutter/material.dart';

class VeiculoViewModel extends ChangeNotifier {
  final VeiculoRepository repo;

  VeiculoViewModel(this.repo)
  {
    carregar();
  }

  List<VeiculoModel> veiculos = [];
  bool loading = false;

  Future<void> carregar() async {
    loading = true;
    notifyListeners();

    veiculos = await repo.getVeiculos();

    loading = false;
    notifyListeners();
  }

  Future<void> editar(String id, VeiculoModel novo) async {
    await repo.updateVeiculo(id, novo);
    await carregar();
  }

  Future<void> adicionar(VeiculoModel v) async {
    await repo.addVeiculo(v);
    await carregar();
  }

  Future<void> excluir(String id) async {
    await repo.deleteVeiculo(id);
    await carregar();
  }
}
