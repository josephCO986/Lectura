part of 'lectura_temporal_bloc.dart';

abstract class LecturaTemporalEvent extends Equatable {
  const LecturaTemporalEvent();

  @override
  List<Object> get props => [];
}

class LoadLecturasEvent extends LecturaTemporalEvent {}

class LoadLecturasByCategoriaEvent extends LecturaTemporalEvent {
  final String categoria;

  const LoadLecturasByCategoriaEvent(this.categoria);

  @override
  List<Object> get props => [categoria];
}

class SaveLecturaEvent extends LecturaTemporalEvent {
  final LecturaTemporal lectura;

  const SaveLecturaEvent(this.lectura);

  @override
  List<Object> get props => [lectura];
}

class DeleteLecturaEvent extends LecturaTemporalEvent {
  final String lecturaId;

  const DeleteLecturaEvent(this.lecturaId);

  @override
  List<Object> get props => [lecturaId];
}
