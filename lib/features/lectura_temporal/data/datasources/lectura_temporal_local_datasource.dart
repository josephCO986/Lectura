import '../models/lectura_temporal_model.dart';

abstract class LecturaTempralLocalDataSource {
  Future<List<LecturaTemporalModel>> getCachedLecturas();
  Future<void> cacheLecturas(List<LecturaTemporalModel> lecturas);
  Future<LecturaTemporalModel?> getCachedLectura(String id);
  Future<void> cacheLectura(LecturaTemporalModel lectura);
  Future<void> deleteCachedLectura(String id);
}

class LecturaTemporalLocalDataSourceImpl
    implements LecturaTempralLocalDataSource {
  // Datos de muestra para demostración
  static final List<LecturaTemporalModel> _sampleData = [
    LecturaTemporalModel(
      id: '1',
      titulo: 'Inteligencia Artificial en 2024',
      contenido:
          'La inteligencia artificial ha revolucionado múltiples industrias este año. Desde chatbots avanzados hasta sistemas de reconocimiento de imágenes, la IA está cambiando la forma en que interactuamos con la tecnología.',
      fechaCreacion: DateTime.now().subtract(const Duration(days: 2)),
      fechaExpiracion: DateTime.now().add(const Duration(days: 5)),
      isExpired: false,
      categoria: 'Tecnología',
      tiempoLecturaMinutos: 5,
    ),
    LecturaTemporalModel(
      id: '2',
      titulo: 'El Arte del Renacimiento',
      contenido:
          'El Renacimiento fue un período de gran florecimiento artístico y cultural. Artistas como Leonardo da Vinci, Miguel Ángel y Rafael crearon obras maestras que siguen inspirando a generaciones.',
      fechaCreacion: DateTime.now().subtract(const Duration(days: 1)),
      fechaExpiracion: DateTime.now().add(const Duration(days: 3)),
      isExpired: false,
      categoria: 'Arte',
      tiempoLecturaMinutos: 7,
    ),
    LecturaTemporalModel(
      id: '3',
      titulo: 'Descubrimientos Científicos',
      contenido:
          'Los científicos han hecho varios descubrimientos importantes este año. Desde nuevas especies marinas hasta avances en medicina regenerativa, la ciencia continúa expandiendo nuestro conocimiento.',
      fechaCreacion: DateTime.now().subtract(const Duration(hours: 6)),
      fechaExpiracion: DateTime.now().add(const Duration(days: 1)),
      isExpired: false,
      categoria: 'Ciencia',
      tiempoLecturaMinutos: 4,
    ),
    LecturaTemporalModel(
      id: '4',
      titulo: 'La Revolución Francesa',
      contenido:
          'La Revolución Francesa (1789-1799) fue un período de cambio radical en Francia. Marcó el fin del Antiguo Régimen y estableció las bases de la Francia moderna.',
      fechaCreacion: DateTime.now().subtract(const Duration(days: 5)),
      fechaExpiracion: DateTime.now().subtract(const Duration(hours: 1)),
      isExpired: true,
      categoria: 'Historia',
      tiempoLecturaMinutos: 6,
    ),
    LecturaTemporalModel(
      id: '5',
      titulo: 'Productividad Personal',
      contenido:
          'Mejorar la productividad personal es clave para el éxito. Técnicas como el método Pomodoro, la matriz de Eisenhower y la regla de los 2 minutos pueden ayudarte a gestionar mejor tu tiempo.',
      fechaCreacion: DateTime.now().subtract(const Duration(hours: 3)),
      fechaExpiracion: DateTime.now().add(const Duration(days: 7)),
      isExpired: false,
      categoria: 'General',
      tiempoLecturaMinutos: 3,
    ),
  ];

  @override
  Future<List<LecturaTemporalModel>> getCachedLecturas() async {
    // Simular delay de carga
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_sampleData);
  }

  @override
  Future<void> cacheLecturas(List<LecturaTemporalModel> lecturas) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<LecturaTemporalModel?> getCachedLectura(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _sampleData.firstWhere((lectura) => lectura.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheLectura(LecturaTemporalModel lectura) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _sampleData.indexWhere((l) => l.id == lectura.id);
    if (index != -1) {
      _sampleData[index] = lectura;
    } else {
      _sampleData.add(lectura);
    }
  }

  @override
  Future<void> deleteCachedLectura(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _sampleData.removeWhere((lectura) => lectura.id == id);
  }
}
