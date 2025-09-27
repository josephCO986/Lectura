import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../bloc/barcode_scanner_bloc.dart';
import '../widgets/scanner_overlay.dart';
import '../widgets/product_info_card.dart';
import 'historial_page.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de Códigos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistorialPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: BlocConsumer<BarcodeScannerBloc, BarcodeScannerState>(
        listener: (context, state) {
          if (state is ScanErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ScanSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Producto escaneado: ${state.producto.nombre}'),
                backgroundColor: Colors.green,
              ),
            );

            // Mostrar información del producto
            _showProductDialog(context, state.producto);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String code = barcodes.first.rawValue ?? '';
                          if (code.isNotEmpty) {
                            // Escanear el código
                            context.read<BarcodeScannerBloc>().add(
                              StartScanEvent(),
                            );
                          }
                        }
                      },
                    ),
                    const ScannerOverlay(),
                    if (state is ScanningState)
                      const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Instrucciones',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Apunta la cámara hacia el código de barras\n'
                        '• Mantén el dispositivo estable\n'
                        '• Asegúrate de que haya buena iluminación\n'
                        '• El escaneo se realizará automáticamente',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.read<BarcodeScannerBloc>().add(
                                  StartScanEvent(),
                                );
                              },
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Escanear Manualmente'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistorialPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.history),
                              label: const Text('Ver Historial'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showProductDialog(BuildContext context, producto) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ProductInfoCard(producto: producto),
      ),
    );
  }
}
