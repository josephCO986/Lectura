part of 'barcode_scanner_bloc.dart';

abstract class BarcodeScannerEvent extends Equatable {
  const BarcodeScannerEvent();

  @override
  List<Object> get props => [];
}

class StartScanEvent extends BarcodeScannerEvent {}

class StopScanEvent extends BarcodeScannerEvent {}

class LoadHistorialEvent extends BarcodeScannerEvent {}

class ClearHistorialEvent extends BarcodeScannerEvent {}

class ExportHistorialEvent extends BarcodeScannerEvent {}

class SaveScannedProductEvent extends BarcodeScannerEvent {
  final ProductoEscaneado producto;

  const SaveScannedProductEvent(this.producto);

  @override
  List<Object> get props => [producto];
}
