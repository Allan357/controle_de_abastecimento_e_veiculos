class AbastecimentoModel {
  String? id;
  final DateTime data;
  final double quantidadeLitros;
  final double valorPago;
  final int quilometragem;
  final String tipoCombustivel;
  final String veiculoId;
  final double consumo; 
  final String? observacao;

  AbastecimentoModel({
    this.id,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.veiculoId,
    required this.consumo,
    this.observacao,
  });

  Map<String, dynamic> toMap() {
    return {
      "data": data.toIso8601String(),
      "quantidadeLitros": quantidadeLitros,
      "valorPago": valorPago,
      "quilometragem": quilometragem,
      "tipoCombustivel": tipoCombustivel,
      "veiculoId": veiculoId,
      "consumo": consumo,
      "observacao": observacao,
    };
  }

  factory AbastecimentoModel.fromMap(String id, Map map) {
    return AbastecimentoModel(
      id: id,
      data: DateTime.parse(map["data"]),
      quantidadeLitros: map["quantidadeLitros"] * 1.0,
      valorPago: map["valorPago"] * 1.0,
      quilometragem: map["quilometragem"],
      tipoCombustivel: map["tipoCombustivel"],
      veiculoId: map["veiculoId"],
      consumo: map["consumo"] * 1.0,
      observacao: map["observacao"],
    );
  }
}
