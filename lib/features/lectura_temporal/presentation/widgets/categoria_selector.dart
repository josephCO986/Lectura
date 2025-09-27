import 'package:flutter/material.dart';

class CategoriaSelector extends StatelessWidget {
  final String selectedCategoria;
  final Function(String) onCategoriaChanged;

  const CategoriaSelector({
    Key? key,
    required this.selectedCategoria,
    required this.onCategoriaChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorias = [
      'Todas',
      'General',
      'Tecnología',
      'Ciencia',
      'Arte',
      'Historia',
    ];

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          final isSelected = categoria == selectedCategoria;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: Text(
                categoria,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onCategoriaChanged(categoria);
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Theme.of(context).primaryColor,
              checkmarkColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
