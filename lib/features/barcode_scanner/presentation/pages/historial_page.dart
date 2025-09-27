import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/barcode_scanner_bloc.dart';
import '../widgets/historial_item.dart';
import '../widgets/product_info_card.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  void initState() {
    super.initState();
    // Cargar el historial al iniciar
    context.read<BarcodeScannerBloc>().add(LoadHistorialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Escaneos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export':
                  context.read<BarcodeScannerBloc>().add(
                    ExportHistorialEvent(),
                  );
                  break;
                case 'clear':
                  _showClearConfirmDialog();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Exportar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever),
                    SizedBox(width: 8),
                    Text('Limpiar Todo'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<BarcodeScannerBloc, BarcodeScannerState>(
        listener: (context, state) {
          if (state is HistorialErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ExportSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Historial exportado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ClearHistorialSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Historial limpiado'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HistorialLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistorialLoadedState) {
            if (state.productos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No hay escaneos registrados',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Los productos escaneados aparecerán aquí',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Escanear Ahora'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Estadísticas
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${state.productos.length}',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: Colors.grey[300]),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${_getTodayCount(state.productos)}',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                            ),
                            Text(
                              'Hoy',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: Colors.grey[300]),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${_getUniqueProductsCount(state.productos)}',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                            ),
                            Text(
                              'Únicos',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Lista de productos
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.productos.length,
                    itemBuilder: (context, index) {
                      final producto = state.productos[index];
                      return HistorialItem(
                        producto: producto,
                        onTap: () => _showProductDetails(producto),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Error cargando historial'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  int _getTodayCount(productos) {
    final today = DateTime.now();
    return productos.where((producto) {
      final fecha = producto.fechaEscaneo;
      return fecha.year == today.year &&
          fecha.month == today.month &&
          fecha.day == today.day;
    }).length;
  }

  int _getUniqueProductsCount(productos) {
    final codigos = <String>{};
    for (final producto in productos) {
      codigos.add(producto.codigo);
    }
    return codigos.length;
  }

  void _showClearConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar todo el historial? '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<BarcodeScannerBloc>().add(ClearHistorialEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showProductDetails(producto) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ProductInfoCard(producto: producto),
      ),
    );
  }
}
