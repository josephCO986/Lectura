import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/lectura_temporal.dart';
import '../../domain/usecases/get_lecturas.dart';
import '../../domain/usecases/save_lectura.dart';

part 'lectura_temporal_event.dart';
part 'lectura_temporal_state.dart';

class LecturaTemporalBloc
    extends Bloc<LecturaTemporalEvent, LecturaTemporalState> {
  final GetLecturas getLecturas;
  final SaveLectura saveLectura;

  LecturaTemporalBloc({required this.getLecturas, required this.saveLectura})
    : super(LecturaTemporalInitial()) {
    on<LoadLecturasEvent>(_onLoadLecturas);
    on<SaveLecturaEvent>(_onSaveLectura);
    on<LoadLecturasByCategoriaEvent>(_onLoadLecturasByCategoria);
  }

  void _onLoadLecturas(
    LoadLecturasEvent event,
    Emitter<LecturaTemporalState> emit,
  ) async {
    emit(LecturaTemporalLoading());

    final result = await getLecturas();

    result.fold(
      (failure) => emit(LecturaTemporalError(failure.message)),
      (lecturas) => emit(LecturaTemporalLoaded(lecturas)),
    );
  }

  void _onSaveLectura(
    SaveLecturaEvent event,
    Emitter<LecturaTemporalState> emit,
  ) async {
    emit(LecturaTemporalLoading());

    final result = await saveLectura(event.lectura);

    result.fold(
      (failure) => emit(LecturaTemporalError(failure.message)),
      (_) => emit(LecturaSaved()),
    );
  }

  void _onLoadLecturasByCategoria(
    LoadLecturasByCategoriaEvent event,
    Emitter<LecturaTemporalState> emit,
  ) async {
    emit(LecturaTemporalLoading());

    final result = await getLecturas();

    result.fold((failure) => emit(LecturaTemporalError(failure.message)), (
      lecturas,
    ) {
      final filteredLecturas = lecturas
          .where((lectura) => lectura.categoria == event.categoria)
          .toList();
      emit(LecturaTemporalLoaded(filteredLecturas));
    });
  }
}
