import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/producto_escaneado.dart';
import '../../domain/usecases/scan_barcode.dart';
import '../../domain/usecases/get_product_info.dart';
import '../../domain/usecases/get_historial_escaneos.dart';
import '../../domain/repositories/barcode_scanner_repository.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  final ScanBarcode scanBarcode;
  final GetProductInfo getProductInfo;
  final GetHistorialEscaneos getHistorialEscaneos;
  final BarcodeScannerRepository repository;

  BarcodeScannerBloc({
    required this.scanBarcode,
    required this.getProductInfo,
    required this.getHistorialEscaneos,
    required this.repository,
  }) : super(BarcodeScannerInitial()) {
    on<StartScanEvent>(_onStartScan);
    on<LoadHistorialEvent>(_onLoadHistorial);
    on<SaveScannedProductEvent>(_onSaveScannedProduct);
    on<ClearHistorialEvent>(_onClearHistorial);
    on<ExportHistorialEvent>(_onExportHistorial);
  }

  void _onStartScan(
    StartScanEvent event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    emit(ScanningState());

    try {
      final scanResult = await scanBarcode();

      scanResult.fold((failure) => emit(ScanErrorState(failure.message)), (
        codigo,
      ) async {
        // Obtener información del producto
        final productResult = await getProductInfo(codigo);

        productResult.fold((failure) => emit(ScanErrorState(failure.message)), (
          producto,
        ) async {
          // Guardar automáticamente el escaneo
          final saveResult = await repository.guardarEscaneo(producto);

          saveResult.fold(
            (failure) =>
                emit(ScanErrorState('Error al guardar: ${failure.message}')),
            (_) => emit(ScanSuccessState(producto)),
          );
        });
      });
    } catch (e) {
      emit(ScanErrorState('Error inesperado: $e'));
    }
  }

  void _onLoadHistorial(
    LoadHistorialEvent event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    emit(HistorialLoadingState());

    final result = await getHistorialEscaneos();

    result.fold(
      (failure) => emit(HistorialErrorState(failure.message)),
      (productos) => emit(HistorialLoadedState(productos)),
    );
  }

  void _onSaveScannedProduct(
    SaveScannedProductEvent event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    final result = await repository.guardarEscaneo(event.producto);

    result.fold(
      (failure) => emit(ScanErrorState('Error al guardar: ${failure.message}')),
      (_) {
        emit(ScanSuccessState(event.producto));
        // Recargar historial
        add(LoadHistorialEvent());
      },
    );
  }

  void _onClearHistorial(
    ClearHistorialEvent event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    final result = await repository.limpiarHistorial();

    result.fold(
      (failure) =>
          emit(HistorialErrorState('Error al limpiar: ${failure.message}')),
      (_) {
        emit(ClearHistorialSuccessState());
        // Recargar historial vacío
        add(LoadHistorialEvent());
      },
    );
  }

  void _onExportHistorial(
    ExportHistorialEvent event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    final result = await repository.exportarHistorial();

    result.fold(
      (failure) =>
          emit(HistorialErrorState('Error al exportar: ${failure.message}')),
      (_) => emit(ExportSuccessState()),
    );
  }
}
