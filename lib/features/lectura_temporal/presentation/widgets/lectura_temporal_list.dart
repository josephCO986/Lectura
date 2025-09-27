import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/lectura_temporal_bloc.dart';
import 'lectura_temporal_card.dart';

class LecturaTemporalList extends StatelessWidget {
  const LecturaTemporalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LecturaTemporalBloc, LecturaTemporalState>(
      builder: (context, state) {
        if (state is LecturaTemporalLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LecturaTemporalError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Error al cargar las lecturas',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<LecturaTemporalBloc>().add(
                      LoadLecturasEvent(),
                    );
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        if (state is LecturaTemporalLoaded) {
          if (state.lecturas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No hay lecturas disponibles',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Agrega tu primera lectura temporal usando el botón +',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.lecturas.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: LecturaTemporalCard(lectura: state.lecturas[index]),
              );
            },
          );
        }

        return const Center(child: Text('Estado inicial'));
      },
    );
  }
}
