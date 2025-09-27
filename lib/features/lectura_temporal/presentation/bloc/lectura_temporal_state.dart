part of 'lectura_temporal_bloc.dart';

abstract class LecturaTemporalState extends Equatable {
  const LecturaTemporalState();

  @override
  List<Object> get props => [];
}

class LecturaTemporalInitial extends LecturaTemporalState {}

class LecturaTemporalLoading extends LecturaTemporalState {}

class LecturaTemporalLoaded extends LecturaTemporalState {
  final List<LecturaTemporal> lecturas;

  const LecturaTemporalLoaded(this.lecturas);

  @override
  List<Object> get props => [lecturas];
}

class LecturaTemporalError extends LecturaTemporalState {
  final String message;

  const LecturaTemporalError(this.message);

  @override
  List<Object> get props => [message];
}

class LecturaSaved extends LecturaTemporalState {}

class LecturaDeleted extends LecturaTemporalState {}
