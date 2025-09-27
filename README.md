# 📚 Lectura Temporal - Flutter App

Una aplicación Flutter con arquitectura limpia (Clean Architecture) que implementa un sistema de **lectura temporal** con menú dinámico y patrón de diseño robusto.

## 🏗️ Arquitectura

Este proyecto implementa **Clean Architecture** con el patrón **BLoC** para la gestión de estado:

```
lib/
├── core/                    # Funcionalidades centrales
│   ├── constants/          # Constantes de la aplicación
│   ├── errors/            # Manejo de errores y failures
│   ├── network/           # Configuración de red
│   ├── utils/            # Utilidades generales
│   └── di/               # Inyección de dependencias
├── features/
│   └── lectura_temporal/  # Feature principal
│       ├── data/         # Capa de datos
│       │   ├── datasources/  # Fuentes de datos (local/remote)
│       │   ├── models/      # Modelos de datos
│       │   └── repositories/ # Implementación de repositorios
│       ├── domain/       # Lógica de negocio
│       │   ├── entities/    # Entidades de dominio
│       │   ├── repositories/ # Interfaces de repositorios
│       │   └── usecases/    # Casos de uso
│       └── presentation/ # Capa de presentación
│           ├── bloc/       # Gestión de estado
│           ├── pages/      # Páginas de la app
│           └── widgets/    # Widgets reutilizables
└── shared/               # Recursos compartidos
    ├── widgets/         # Widgets globales
    ├── utils/          # Utilidades compartidas
    └── constants/      # Constantes compartidas
```

## 🚀 Características

### ✨ Funcionalidades Principales
- **Lectura Temporal**: Sistema de contenido con fecha de expiración
- **Categorización**: Organización por categorías (Tecnología, Arte, Ciencia, Historia, General)
- **Filtros Dinámicos**: Menú de filtros por categoría
- **Interfaz Moderna**: UI con Material Design 3
- **Estado de Expiración**: Indicadores visuales para contenido expirado

### 🏛️ Patrones de Diseño
- **Clean Architecture**: Separación clara de responsabilidades
- **BLoC Pattern**: Gestión reactiva del estado
- **Repository Pattern**: Abstracción del acceso a datos
- **Dependency Injection**: Desacoplamiento de dependencias
- **Either Pattern**: Manejo funcional de errores

### 📱 Características de UI
- **Bottom Navigation**: Navegación entre secciones
- **Filter Chips**: Selección de categorías
- **Cards Dinámicas**: Visualización de contenido
- **Loading States**: Indicadores de carga
- **Error Handling**: Manejo elegante de errores

## 🛠️ Tecnologías Utilizadas

### 📦 Dependencias Principales
```yaml
# State Management
flutter_bloc: ^8.1.6
equatable: ^2.0.5

# Navigation
go_router: ^14.2.7

# HTTP & API
http: ^1.2.2
dio: ^5.7.0

# Local Storage
shared_preferences: ^2.3.2

# Dependency Injection
get_it: ^8.0.0
injectable: ^2.4.4

# JSON Serialization
json_annotation: ^4.9.0
dartz: ^0.10.1

# UI Components
flutter_svg: ^2.0.10+1
```

### 🔧 Dev Dependencies
```yaml
# Code Generation
build_runner: ^2.4.13
json_serializable: ^6.8.0
injectable_generator: ^2.6.2
```

## 📋 Instalación y Configuración

### Prerrequisitos
- Flutter SDK >= 3.9.0
- Dart >= 3.0.0
- **Modo Desarrollador habilitado en Windows** (para symlinks)

### 🔧 Configuración Inicial

1. **Habilitar Modo Desarrollador** (Windows):
   ```bash
   start ms-settings:developers
   ```
   Luego activar "Modo desarrollador"

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Generar código**:
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

## 🎯 Funcionalidades del Menú de Lectura Temporal

### 📚 Vista Principal
- **Lista de Lecturas**: Muestra todas las lecturas disponibles
- **Filtros por Categoría**: Chips interactivos para filtrar contenido
- **Indicadores de Estado**: Visual para contenido expirado
- **Tiempo de Lectura**: Estimación en minutos

### 📖 Características de Contenido
- **Título y Contenido**: Información principal de cada lectura
- **Categorías**: Tecnología, Arte, Ciencia, Historia, General
- **Fechas**: Creación y expiración
- **Estado de Vigencia**: Marcado visual de contenido expirado

### 🔄 Datos de Muestra
La aplicación incluye contenido de ejemplo:
1. **Inteligencia Artificial en 2024** (Tecnología)
2. **El Arte del Renacimiento** (Arte)
3. **Descubrimientos Científicos** (Ciencia)
4. **La Revolución Francesa** (Historia)
5. **Productividad Personal** (General)

## 🌐 Integración con Backend .NET

### 🔗 Configuración de API
```dart
// lib/core/constants/app_constants.dart
static const String baseUrl = 'https://tu-backend-net-api.com/api';
static const String lecturaEndpoint = '/lecturas';
```

### 📡 Endpoints Esperados
```http
GET /api/lecturas              # Obtener todas las lecturas
GET /api/lecturas/{id}         # Obtener lectura por ID
POST /api/lecturas             # Crear nueva lectura
PUT /api/lecturas/{id}         # Actualizar lectura
DELETE /api/lecturas/{id}      # Eliminar lectura
```

### 📄 Modelo JSON Esperado
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

## 🧪 Datos de Prueba

La aplicación actualmente utiliza datos locales de muestra. Para conectar con tu backend .NET:

1. Actualiza la `baseUrl` en `app_constants.dart`
2. Modifica el `LecturaTemporalRepositoryImpl` para usar `remoteDataSource`
3. Configura autenticación si es necesaria

## 🚀 Próximos Pasos

### 🔄 Mejoras Pendientes
- [ ] Conexión completa con backend .NET
- [ ] Autenticación de usuarios
- [ ] Notificaciones push para contenido próximo a expirar
- [ ] Modo offline mejorado
- [ ] Búsqueda de contenido
- [ ] Favoritos y marcadores
- [ ] Estadísticas de lectura
- [ ] Tema oscuro/claro

### 🎨 Personalización de UI
- [ ] Animaciones personalizadas
- [ ] Temas de color personalizables
- [ ] Configuraciones de usuario
- [ ] Accesibilidad mejorada

## 📝 Comandos Útiles

```bash
# Análisis de código
flutter analyze

# Formatear código
flutter format .

# Tests
flutter test

# Build para release
flutter build apk --release

# Limpiar proyecto
flutter clean && flutter pub get
```

## 🤝 Contribución

Este proyecto está configurado con Clean Architecture para facilitar el mantenimiento y la escalabilidad. La estructura modular permite:

- **Fácil testing**: Cada capa puede ser testeada independientemente
- **Mantenibilidad**: Separación clara de responsabilidades
- **Escalabilidad**: Fácil adición de nuevas features
- **Flexibilidad**: Cambio de implementaciones sin afectar otras capas

---

## 📞 Soporte

Para conectar con tu backend .NET existente:

1. **Revisa los endpoints** en `remote_datasource.dart`
2. **Ajusta los modelos** según tu API
3. **Configura autenticación** si es necesaria
4. **Actualiza las constantes** de la aplicación

¡Tu aplicación Flutter con patrón de diseño limpio está lista para integrarse con tu backend .NET! 🎉
