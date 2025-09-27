import 'package:equatable/equatable.dart';

class ProductoEscaneado extends Equatable {
  final String codigo;
  final String? nombre;
  final String? descripcion;
  final double? peso;
  final int? cantidad;
  final String? categoria;
  final DateTime fechaEscaneo;
  final String tipoEscaneo; // 'QR', 'EAN13', 'CODE128', etc.

  const ProductoEscaneado({
    required this.codigo,
    this.nombre,
    this.descripcion,
    this.peso,
    this.cantidad,
    this.categoria,
    required this.fechaEscaneo,
    required this.tipoEscaneo,
  });

  @override
  List<Object?> get props => [
    codigo,
    nombre,
    descripcion,
    peso,
    cantidad,
    categoria,
    fechaEscaneo,
    tipoEscaneo,
  ];

  ProductoEscaneado copyWith({
    String? codigo,
    String? nombre,
    String? descripcion,
    double? peso,
    int? cantidad,
    String? categoria,
    DateTime? fechaEscaneo,
    String? tipoEscaneo,
  }) {
    return ProductoEscaneado(
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      peso: peso ?? this.peso,
      cantidad: cantidad ?? this.cantidad,
      categoria: categoria ?? this.categoria,
      fechaEscaneo: fechaEscaneo ?? this.fechaEscaneo,
      tipoEscaneo: tipoEscaneo ?? this.tipoEscaneo,
    );
  }
}
