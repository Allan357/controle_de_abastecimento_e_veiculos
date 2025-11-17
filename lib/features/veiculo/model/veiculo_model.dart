class VeiculoModel {
  String? id;
  String modelo;
  String marca;
  String placa;
  int ano;
  String tipoCombustivel;

  VeiculoModel({
    this.id,
    required this.modelo,
    required this.marca,
    required this.placa,
    required this.ano,
    required this.tipoCombustivel,
  });

  Map<String, dynamic> toMap() {
    return {
      "modelo": modelo,
      "marca": marca,
      "placa": placa,
      "ano": ano,
      "tipoCombustivel": tipoCombustivel,
    };
  }

  static VeiculoModel fromMap(String id, Map data) {
    return VeiculoModel(
      id: id,
      modelo: data["modelo"],
      marca: data["marca"],
      placa: data["placa"],
      ano: data["ano"],
      tipoCombustivel: data["tipoCombustivel"],
    );
  }
}
