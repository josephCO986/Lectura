# Guía de Desarrollo - Lectura Temporal

## 🚀 Configuración del Proyecto

### Primer Setup
```bash
# Clonar el repositorio
git clone <tu-repositorio-url>
cd lectura_flutter_app

# Instalar dependencias
flutter pub get

# Generar archivos de código
flutter packages pub run build_runner build

# Ejecutar en desarrollo
flutter run
```

### 🏗️ Estructura del Proyecto

```
lib/
├── core/                    # Funcionalidades centrales
├── features/                # Features de la aplicación
│   └── lectura_temporal/   # Feature principal
└── shared/                 # Recursos compartidos
```

## 🔧 Comandos Útiles

### Desarrollo
```bash
# Ejecutar en modo debug
flutter run

# Hot reload automático
flutter run --hot

# Ejecutar en dispositivos específicos
flutter run -d chrome
flutter run -d windows
flutter run -d android
```

### Build y Release
```bash
# Generar APK para Android
flutter build apk --release

# Generar para Play Store
flutter build appbundle --release

# Build para Windows
flutter build windows --release
```

### Code Generation
```bash
# Generar archivos *.g.dart
flutter packages pub run build_runner build

# Watch mode (regenera automáticamente)
flutter packages pub run build_runner watch

# Limpiar archivos generados
flutter packages pub run build_runner clean
```

### Testing y Calidad
```bash
# Ejecutar tests
flutter test

# Análisis estático
flutter analyze

# Formatear código
flutter format .
```

## 🌐 Integración con Backend .NET

### Configurar API URL
1. Editar `lib/core/constants/app_constants.dart`
2. Cambiar `baseUrl` por tu endpoint
3. Configurar autenticación si es necesaria

### Modelo de Datos
El proyecto espera este formato JSON:
```json
{
  "id": "string",
  "titulo": "string", 
  "contenido": "string",
  "fechaCreacion": "2024-01-01T00:00:00Z",
  "fechaExpiracion": "2024-01-01T00:00:00Z", 
  "isExpired": false,
  "categoria": "string",
  "tiempoLecturaMinutos": 5
}
```

## 📱 Patrones Implementados

- **Clean Architecture**: Separación en capas
- **BLoC Pattern**: Gestión de estado reactiva
- **Repository Pattern**: Abstracción de datos
- **Dependency Injection**: Desacoplamiento
- **Either Pattern**: Manejo funcional de errores

## 🐛 Troubleshooting

### Error: Building with plugins requires symlink support
**Solución:** Habilitar Modo Desarrollador en Windows
```bash
start ms-settings:developers
```

### Error: No pubspec.yaml found
**Solución:** Ejecutar comandos desde la carpeta raíz del proyecto
```bash
cd lectura_flutter_app
flutter [comando]
```

### Errores de dependencias
**Solución:** Limpiar y reinstalar
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build
```

## 📋 Checklist de Release

- [ ] Tests pasando: `flutter test`
- [ ] Sin errores de análisis: `flutter analyze`
- [ ] Código formateado: `flutter format .`
- [ ] Build exitoso: `flutter build apk --release`
- [ ] README actualizado
- [ ] Versión incrementada en `pubspec.yaml`
- [ ] Changelog actualizado

---

*Desarrollado con Clean Architecture y BLoC Pattern para máxima escalabilidad y mantenibilidad.*