part of 'barcode_scanner_bloc.dart';

abstract class BarcodeScannerState extends Equatable {
  const BarcodeScannerState();

  @override
  List<Object> get props => [];
}

class BarcodeScannerInitial extends BarcodeScannerState {}

class ScanningState extends BarcodeScannerState {}

class ScanSuccessState extends BarcodeScannerState {
  final ProductoEscaneado producto;

  const ScanSuccessState(this.producto);

  @override
  List<Object> get props => [producto];
}

class ScanErrorState extends BarcodeScannerState {
  final String message;

  const ScanErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class HistorialLoadedState extends BarcodeScannerState {
  final List<ProductoEscaneado> productos;

  const HistorialLoadedState(this.productos);

  @override
  List<Object> get props => [productos];
}

class HistorialLoadingState extends BarcodeScannerState {}

class HistorialErrorState extends BarcodeScannerState {
  final String message;

  const HistorialErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ExportSuccessState extends BarcodeScannerState {}

class ClearHistorialSuccessState extends BarcodeScannerState {}
