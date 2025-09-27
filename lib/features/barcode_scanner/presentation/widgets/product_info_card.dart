import 'package:flutter/material.dart';
import '../../domain/entities/producto_escaneado.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductoEscaneado producto;

  const ProductInfoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.inventory_2, color: Colors.white, size: 48),
                const SizedBox(height: 8),
                Text(
                  'Producto Escaneado',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Código
                  _buildInfoRow(
                    icon: Icons.qr_code,
                    label: 'Código',
                    value: producto.codigo,
                    context: context,
                  ),
                  const SizedBox(height: 16),

                  // Nombre
                  _buildInfoRow(
                    icon: Icons.label,
                    label: 'Nombre',
                    value: producto.nombre ?? 'No disponible',
                    context: context,
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  _buildInfoRow(
                    icon: Icons.description,
                    label: 'Descripción',
                    value: producto.descripcion ?? 'No disponible',
                    context: context,
                  ),
                  const SizedBox(height: 16),

                  // Peso
                  if (producto.peso != null)
                    Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.scale,
                          label: 'Peso',
                          value: '${producto.peso} kg',
                          context: context,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Cantidad
                  if (producto.cantidad != null)
                    Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.inventory,
                          label: 'Cantidad',
                          value: '${producto.cantidad} unidades',
                          context: context,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Categoría
                  if (producto.categoria != null)
                    Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.category,
                          label: 'Categoría',
                          value: producto.categoria!,
                          context: context,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Fecha de escaneo
                  _buildInfoRow(
                    icon: Icons.schedule,
                    label: 'Escaneado',
                    value: _formatDateTime(producto.fechaEscaneo),
                    context: context,
                  ),

                  const SizedBox(height: 24),

                  // Estado del producto
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Producto registrado correctamente',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cerrar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Aquí se podría agregar lógica para compartir o exportar
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Compartir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Hace un momento';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} horas';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
