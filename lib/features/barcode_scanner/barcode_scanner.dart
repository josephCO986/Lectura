// Domain
export 'domain/entities/producto_escaneado.dart';
export 'domain/repositories/barcode_scanner_repository.dart';
export 'domain/usecases/scan_barcode.dart';
export 'domain/usecases/get_product_info.dart';
export 'domain/usecases/get_historial_escaneos.dart';

// Data
export 'data/repositories/barcode_scanner_repository_impl.dart';
export 'data/datasources/barcode_scanner_camera_datasource.dart';
export 'data/datasources/barcode_scanner_local_datasource.dart';
export 'data/models/producto_escaneado_model.dart';

// Presentation
export 'presentation/bloc/barcode_scanner_bloc.dart';
export 'presentation/pages/barcode_scanner_page.dart';
export 'presentation/pages/historial_page.dart';
export 'presentation/widgets/scanner_overlay.dart';
export 'presentation/widgets/product_info_card.dart';
export 'presentation/widgets/historial_item.dart';
