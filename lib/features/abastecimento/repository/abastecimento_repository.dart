import 'package:controle_de_abastecimento_e_veiculos/core/services/firebase_realtime_service.dart';
import 'package:controle_de_abastecimento_e_veiculos/features/abastecimento/model/abastecimento_model.dart';

class AbastecimentoRepository {
  final FirebaseRealtimeService service;

  AbastecimentoRepository(this.service);

  Future<String> add(AbastecimentoModel a) async {
    return await service.create("abastecimentos", a.toMap());
  }

  Future<List<AbastecimentoModel>> getAll() async {
    final data = await service.readAll("abastecimentos");
    if (data == null) return [];

    return data.entries
        .map((e) => AbastecimentoModel.fromMap(e.key, e.value))
        .toList();
  }

  Future<void> update(String id, AbastecimentoModel a) async {
    await service.update("abastecimentos/$id", a.toMap());
  }

  Future<void> delete(String id) async {
    await service.delete("abastecimentos", id);
  }
}
