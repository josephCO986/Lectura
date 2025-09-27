import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/lectura_temporal.dart';

part 'lectura_temporal_model.g.dart';

@JsonSerializable()
class LecturaTemporalModel extends LecturaTemporal {
  const LecturaTemporalModel({
    required String id,
    required String titulo,
    required String contenido,
    required DateTime fechaCreacion,
    DateTime? fechaExpiracion,
    required bool isExpired,
    required String categoria,
    required int tiempoLecturaMinutos,
  }) : super(
         id: id,
         titulo: titulo,
         contenido: contenido,
         fechaCreacion: fechaCreacion,
         fechaExpiracion: fechaExpiracion,
         isExpired: isExpired,
         categoria: categoria,
         tiempoLecturaMinutos: tiempoLecturaMinutos,
       );

  factory LecturaTemporalModel.fromJson(Map<String, dynamic> json) =>
      _$LecturaTemporalModelFromJson(json);

  Map<String, dynamic> toJson() => _$LecturaTemporalModelToJson(this);

  factory LecturaTemporalModel.fromEntity(LecturaTemporal entity) {
    return LecturaTemporalModel(
      id: entity.id,
      titulo: entity.titulo,
      contenido: entity.contenido,
      fechaCreacion: entity.fechaCreacion,
      fechaExpiracion: entity.fechaExpiracion,
      isExpired: entity.isExpired,
      categoria: entity.categoria,
      tiempoLecturaMinutos: entity.tiempoLecturaMinutos,
    );
  }
}
