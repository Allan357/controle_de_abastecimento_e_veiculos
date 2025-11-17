import 'package:controle_de_abastecimento_e_veiculos/features/veiculo/model/veiculo_model.dart';

import '../../../core/services/firebase_realtime_service.dart';

class VeiculoRepository {
  final FirebaseRealtimeService service;

  VeiculoRepository(this.service);

  Future<void> addVeiculo(VeiculoModel v) async {
    await service.create("veiculos", v.toMap());
  }

  Future<List<VeiculoModel>> getVeiculos() async {
    final data = await service.readAll("veiculos");
    if (data == null) return [];

    return data.entries.map((entry) {
      return VeiculoModel.fromMap(entry.key, entry.value);
    }).toList();
  }

  Future<void> updateVeiculo(String id, VeiculoModel veiculo) async {
    await service.update("veiculos/$id", veiculo.toMap());
  }

  Future<void> deleteVeiculo(String id) async {
    await service.delete("veiculos", id);
  }
}
