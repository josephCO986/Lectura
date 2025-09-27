import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/producto_escaneado.dart';

part 'producto_escaneado_model.g.dart';

@JsonSerializable()
class ProductoEscaneadoModel extends ProductoEscaneado {
  const ProductoEscaneadoModel({
    required String codigo,
    String? nombre,
    String? descripcion,
    double? peso,
    int? cantidad,
    String? categoria,
    required DateTime fechaEscaneo,
    required String tipoEscaneo,
  }) : super(
         codigo: codigo,
         nombre: nombre,
         descripcion: descripcion,
         peso: peso,
         cantidad: cantidad,
         categoria: categoria,
         fechaEscaneo: fechaEscaneo,
         tipoEscaneo: tipoEscaneo,
       );

  factory ProductoEscaneadoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductoEscaneadoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoEscaneadoModelToJson(this);

  factory ProductoEscaneadoModel.fromEntity(ProductoEscaneado entity) {
    return ProductoEscaneadoModel(
      codigo: entity.codigo,
      nombre: entity.nombre,
      descripcion: entity.descripcion,
      peso: entity.peso,
      cantidad: entity.cantidad,
      categoria: entity.categoria,
      fechaEscaneo: entity.fechaEscaneo,
      tipoEscaneo: entity.tipoEscaneo,
    );
  }

  // Crear desde código escaneado con datos básicos
  factory ProductoEscaneadoModel.fromCode({
    required String codigo,
    required String tipoEscaneo,
    String? nombre,
    String? descripcion,
  }) {
    return ProductoEscaneadoModel(
      codigo: codigo,
      nombre: nombre ?? _generateNameFromCode(codigo),
      descripcion: descripcion ?? _generateDescriptionFromCode(codigo),
      peso: null,
      cantidad: 1,
      categoria: _getCategoryFromCode(codigo),
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: tipoEscaneo,
    );
  }

  static String _generateNameFromCode(String codigo) {
    if (codigo.startsWith('MP-PALLM')) {
      return 'ALUMINIO BLANDO';
    } else if (codigo.startsWith('MP-PBOPP')) {
      return 'BOPP PERLADO';
    } else if (codigo.contains('FOIL')) {
      return 'Material FOIL';
    }
    return 'Producto ${codigo.split('-').last}';
  }

  static String _generateDescriptionFromCode(String codigo) {
    if (codigo.startsWith('MP-PALLM')) {
      // Extraer dimensiones si están disponibles
      if (codigo.contains('975')) {
        return 'ALUMINIO BLANDO 975 mm x 8 um FOIL';
      } else if (codigo.contains('455')) {
        return 'ALUMINIO BLANDO 455 MM x 8 um FOIL';
      } else if (codigo.contains('620')) {
        return 'ALUMINIO BLANDO 620 mm x 8 um FOIL';
      }
    } else if (codigo.startsWith('MP-PBOPP')) {
      return 'BOPP PERLADO 980 mm x 35 um';
    }
    return 'Descripción generada para ${codigo}';
  }

  static String _getCategoryFromCode(String codigo) {
    if (codigo.startsWith('MP-PALLM')) {
      return 'Aluminio';
    } else if (codigo.startsWith('MP-PBOPP')) {
      return 'BOPP';
    } else if (codigo.startsWith('MP-')) {
      return 'Material Prima';
    }
    return 'General';
  }
}
