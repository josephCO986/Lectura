import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/lectura_temporal_bloc.dart';
import '../widgets/lectura_temporal_list.dart';
import '../widgets/categoria_selector.dart';
import '../../../../core/di/injection_container.dart';

class LecturaTemporalPage extends StatefulWidget {
  const LecturaTemporalPage({Key? key}) : super(key: key);

  @override
  State<LecturaTemporalPage> createState() => _LecturaTemporalPageState();
}

class _LecturaTemporalPageState extends State<LecturaTemporalPage> {
  String selectedCategoria = 'Todas';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LecturaTemporalBloc>()..add(LoadLecturasEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lectura Temporal'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<LecturaTemporalBloc>().add(LoadLecturasEvent());
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Selector de Categorías
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CategoriaSelector(
                selectedCategoria: selectedCategoria,
                onCategoriaChanged: (categoria) {
                  setState(() {
                    selectedCategoria = categoria;
                  });

                  if (categoria == 'Todas') {
                    context.read<LecturaTemporalBloc>().add(
                      LoadLecturasEvent(),
                    );
                  } else {
                    context.read<LecturaTemporalBloc>().add(
                      LoadLecturasByCategoriaEvent(categoria),
                    );
                  }
                },
              ),
            ),

            // Lista de Lecturas
            const Expanded(child: LecturaTemporalList()),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddLecturaDialog(context);
          },
          tooltip: 'Agregar Lectura',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddLecturaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddLecturaDialog(),
    );
  }
}

class AddLecturaDialog extends StatefulWidget {
  const AddLecturaDialog({Key? key}) : super(key: key);

  @override
  State<AddLecturaDialog> createState() => _AddLecturaDialogState();
}

class _AddLecturaDialogState extends State<AddLecturaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _contenidoController = TextEditingController();
  String _selectedCategoria = 'General';
  int _tiempoLectura = 5;

  final List<String> categorias = [
    'General',
    'Tecnología',
    'Ciencia',
    'Arte',
    'Historia',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva Lectura Temporal'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contenidoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el contenido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedCategoria,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                items: categorias
                    .map(
                      (categoria) => DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategoria = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Text('Tiempo de lectura: '),
                  Expanded(
                    child: Slider(
                      value: _tiempoLectura.toDouble(),
                      min: 1,
                      max: 60,
                      divisions: 59,
                      label: '$_tiempoLectura min',
                      onChanged: (value) {
                        setState(() {
                          _tiempoLectura = value.round();
                        });
                      },
                    ),
                  ),
                  Text('$_tiempoLectura min'),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Crear nueva lectura (implementar según tu backend)
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidad de guardado pendiente'),
                ),
              );
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }
}
