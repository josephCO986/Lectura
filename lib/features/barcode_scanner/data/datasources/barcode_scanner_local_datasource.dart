import '../models/producto_escaneado_model.dart';

abstract class BarcodeScannerLocalDataSource {
  Future<List<ProductoEscaneadoModel>> getHistorialEscaneos();
  Future<void> guardarEscaneo(ProductoEscaneadoModel producto);
  Future<void> limpiarHistorial();
  Future<ProductoEscaneadoModel?> getProductoPorCodigo(String codigo);
}

class BarcodeScannerLocalDataSourceImpl
    implements BarcodeScannerLocalDataSource {
  // Simulación de base de datos local con productos de ejemplo
  static final List<ProductoEscaneadoModel> _historialEscaneos = [];

  // Base de datos de productos conocidos (simulando tu backend .NET)
  static final Map<String, ProductoEscaneadoModel> _productosConocidos = {
    'MP-PALLM000030': ProductoEscaneadoModel(
      codigo: 'MP-PALLM000030',
      nombre: 'ALUMINIO BLANDO',
      descripcion: 'ALUMINIO BLANDO 975 mm x 8 um FOIL',
      peso: 5698.50,
      cantidad: 11,
      categoria: 'Aluminio',
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: 'CODE128',
    ),
    'MP-PALLM000038': ProductoEscaneadoModel(
      codigo: 'MP-PALLM000038',
      nombre: 'ALUMINIO BLANDO',
      descripcion: 'ALUMINIO BLANDO 455 MM x 8 um FOIL',
      peso: 3981.00,
      cantidad: 15,
      categoria: 'Aluminio',
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: 'CODE128',
    ),
    'MP-PALLM000043': ProductoEscaneadoModel(
      codigo: 'MP-PALLM000043',
      nombre: 'ALUMINIO BLANDO',
      descripcion: 'ALUMINIO BLANDO 620 mm x 8 um FOIL',
      peso: 1113.00,
      cantidad: 3,
      categoria: 'Aluminio',
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: 'CODE128',
    ),
    'MP-PBOPP000393': ProductoEscaneadoModel(
      codigo: 'MP-PBOPP000393',
      nombre: 'BOPP PERLADO',
      descripcion: 'BOPP PERLADO 980 mm x 35 um',
      peso: 560.07,
      cantidad: 3,
      categoria: 'BOPP',
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: 'CODE128',
    ),
  };

  @override
  Future<List<ProductoEscaneadoModel>> getHistorialEscaneos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_historialEscaneos);
  }

  @override
  Future<void> guardarEscaneo(ProductoEscaneadoModel producto) async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Actualizar con información completa si existe en la base de productos
    final productoCompleto = _productosConocidos[producto.codigo] ?? producto;

    // Agregar al historial con timestamp actual
    final productoConFecha = ProductoEscaneadoModel(
      codigo: productoCompleto.codigo,
      nombre: productoCompleto.nombre,
      descripcion: productoCompleto.descripcion,
      peso: productoCompleto.peso,
      cantidad: productoCompleto.cantidad,
      categoria: productoCompleto.categoria,
      fechaEscaneo: DateTime.now(),
      tipoEscaneo: producto.tipoEscaneo,
    );

    _historialEscaneos.insert(0, productoConFecha); // Insertar al inicio

    // Limitar historial a últimos 100 elementos
    if (_historialEscaneos.length > 100) {
      _historialEscaneos.removeLast();
    }
  }

  @override
  Future<void> limpiarHistorial() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _historialEscaneos.clear();
  }

  @override
  Future<ProductoEscaneadoModel?> getProductoPorCodigo(String codigo) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _productosConocidos[codigo];
  }

  // Método para simular escaneo de códigos específicos (para testing)
  static void simularEscaneo(String codigo, String tipo) {
    final dataSource = BarcodeScannerLocalDataSourceImpl();
    final producto = ProductoEscaneadoModel.fromCode(
      codigo: codigo,
      tipoEscaneo: tipo,
    );
    dataSource.guardarEscaneo(producto);
  }
}
