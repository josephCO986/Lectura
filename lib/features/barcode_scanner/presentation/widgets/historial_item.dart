import 'package:flutter/material.dart';
import '../../domain/entities/producto_escaneado.dart';

class HistorialItem extends StatelessWidget {
  final ProductoEscaneado producto;
  final VoidCallback? onTap;

  const HistorialItem({super.key, required this.producto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icono del producto
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre o código
                    Text(
                      producto.nombre?.isNotEmpty == true
                          ? producto.nombre!
                          : producto.codigo,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Código (si hay nombre)
                    if (producto.nombre?.isNotEmpty == true)
                      Text(
                        producto.codigo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 4),

                    // Información adicional
                    Row(
                      children: [
                        // Tipo de código
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(
                              producto.tipoEscaneo,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            producto.tipoEscaneo,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getTypeColor(producto.tipoEscaneo),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Categoría (si existe)
                        if (producto.categoria?.isNotEmpty == true) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              producto.categoria!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Fecha y hora
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(producto.fechaEscaneo),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(producto.fechaEscaneo),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String tipo) {
    switch (tipo.toUpperCase()) {
      case 'QR':
        return Colors.blue;
      case 'EAN13':
        return Colors.green;
      case 'CODE128':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (itemDate == today) {
      return 'Hoy';
    } else if (itemDate == today.subtract(const Duration(days: 1))) {
      return 'Ayer';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
