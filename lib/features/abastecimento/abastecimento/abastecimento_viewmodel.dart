import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/model/abastecimento_model.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/repository/abastecimento_repository.dart';
import 'package:flutter/material.dart';

class AbastecimentoViewModel extends ChangeNotifier {
  final AbastecimentoRepository repo;

  AbastecimentoViewModel(this.repo) {
    carregar();
  }

  List<AbastecimentoModel> abastecimentos = [];
  bool loading = false;

  Future<void> carregar() async {
    loading = true;
    notifyListeners();

    abastecimentos = await repo.getAll();

    loading = false;
    notifyListeners();
  }

  Future<void> adicionar(AbastecimentoModel a) async {
    await repo.add(a);
    await carregar();
  }

  Future<void> editar(String id, AbastecimentoModel novo) async {
    await repo.update(id, novo);
    await carregar();
  }

  Future<void> excluir(String id) async {
    await repo.delete(id);
    await carregar();
  }

    AbastecimentoModel? ultimoAbastecimentoDoVeiculo(String veiculoId) {
    final lista = abastecimentos
        .where((a) => a.veiculoId == veiculoId)
        .toList();

    if (lista.isEmpty) return null;

    lista.sort((a, b) => b.data.compareTo(a.data));

    return lista.first;
  }
}
