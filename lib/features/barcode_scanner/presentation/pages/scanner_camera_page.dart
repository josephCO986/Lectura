import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../bloc/barcode_scanner_bloc.dart';
import '../widgets/scanner_overlay.dart';

class ScannerCameraPage extends StatefulWidget {
  const ScannerCameraPage({super.key});

  @override
  State<ScannerCameraPage> createState() => _ScannerCameraPageState();
}

class _ScannerCameraPageState extends State<ScannerCameraPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isScanning = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Escáner de Códigos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
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
            setState(() {
              _isScanning = false;
            });
          } else if (state is ScanSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Producto escaneado: ${state.producto.nombre ?? state.producto.codigo}',
                ),
                backgroundColor: Colors.green,
              ),
            );
            // Volver a la página anterior después de escanear
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                Navigator.of(context).pop();
              }
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Cámara
              MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  if (_isScanning) return; // Evitar múltiples escaneos

                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String code = barcodes.first.rawValue ?? '';
                    if (code.isNotEmpty) {
                      setState(() {
                        _isScanning = true;
                      });

                      // Simular el escaneo con los productos de ejemplo
                      context.read<BarcodeScannerBloc>().add(StartScanEvent());
                    }
                  }
                },
              ),

              // Overlay del escáner
              const ScannerOverlay(),

              // Indicador de carga
              if (state is ScanningState || _isScanning)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),

              // Instrucciones
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Apunta la cámara hacia el código',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'El escaneo se realizará automáticamente',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Botón de escaneo manual
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: FloatingActionButton.large(
                    onPressed: () {
                      if (!_isScanning) {
                        setState(() {
                          _isScanning = true;
                        });
                        context.read<BarcodeScannerBloc>().add(
                          StartScanEvent(),
                        );
                      }
                    },
                    backgroundColor: const Color(0xFF007AFF),
                    child: Icon(
                      _isScanning
                          ? Icons.hourglass_empty
                          : Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
