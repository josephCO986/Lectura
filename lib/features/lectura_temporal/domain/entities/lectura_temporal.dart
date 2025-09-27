import 'package:equatable/equatable.dart';

class LecturaTemporal extends Equatable {
  final String id;
  final String titulo;
  final String contenido;
  final DateTime fechaCreacion;
  final DateTime? fechaExpiracion;
  final bool isExpired;
  final String categoria;
  final int tiempoLecturaMinutos;

  const LecturaTemporal({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.fechaCreacion,
    this.fechaExpiracion,
    required this.isExpired,
    required this.categoria,
    required this.tiempoLecturaMinutos,
  });

  @override
  List<Object?> get props => [
    id,
    titulo,
    contenido,
    fechaCreacion,
    fechaExpiracion,
    isExpired,
    categoria,
    tiempoLecturaMinutos,
  ];

  LecturaTemporal copyWith({
    String? id,
    String? titulo,
    String? contenido,
    DateTime? fechaCreacion,
    DateTime? fechaExpiracion,
    bool? isExpired,
    String? categoria,
    int? tiempoLecturaMinutos,
  }) {
    return LecturaTemporal(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      contenido: contenido ?? this.contenido,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaExpiracion: fechaExpiracion ?? this.fechaExpiracion,
      isExpired: isExpired ?? this.isExpired,
      categoria: categoria ?? this.categoria,
      tiempoLecturaMinutos: tiempoLecturaMinutos ?? this.tiempoLecturaMinutos,
    );
  }
}
