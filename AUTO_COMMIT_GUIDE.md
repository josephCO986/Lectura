# 🤖 Auto Commit System - Lectura Temporal

Sistema completo de commits automáticos para el proyecto Lectura Temporal.

## 🚀 Formas de usar Auto Commit

### 1. **PowerShell Script** (Recomendado para Windows)
```powershell
# Commit rápido con push automático
.\scripts\auto-commit.ps1 -Type feat -Message "nueva pantalla de login" -Push

# Commit de fix
.\scripts\auto-commit.ps1 -Type fix -Message "corregir bug en formulario" -Push

# Commit de documentación
.\scripts\auto-commit.ps1 -Type docs -Message "actualizar README" -Push

# Modo watch (commits automáticos cada 5 segundos si hay cambios)
.\scripts\auto-commit.ps1 -Watch
```

### 2. **Batch Script** (Windows simple)
```batch
REM Con push automático
set AUTO_PUSH=true
auto-commit.bat feat "nueva funcionalidad"
auto-commit.bat fix "corregir bug"
auto-commit.bat docs "documentación"
```

### 3. **Bash Script** (Git Bash/WSL)
```bash
# Hacer ejecutable
chmod +x scripts/auto-commit.sh

# Usar con push automático
AUTO_PUSH=true ./scripts/auto-commit.sh feat "nueva funcionalidad"

# Modo watch
./scripts/auto-commit.sh watch
```

### 4. **VS Code Tasks** (Integrado en editor)
1. **Presiona:** `Ctrl + Shift + P`
2. **Escribe:** `Tasks: Run Task`
3. **Selecciona:** 
   - `Auto Commit - Quick` (commit rápido)
   - `Auto Commit - Feature` (nueva funcionalidad)
   - `Auto Commit - Fix` (corrección de bugs)
   - `Auto Commit - Watch Mode` (automático continuo)

## 🎯 Tipos de Commit Disponibles

| Tipo | Prefijo | Descripción |
|------|---------|-------------|
| `feat` | ✨ feat: | Nueva funcionalidad |
| `fix` | 🐛 fix: | Corrección de bugs |
| `docs` | 📝 docs: | Documentación |
| `style` | 💄 style: | Cambios de estilo |
| `refactor` | ♻️ refactor: | Refactorización |
| `test` | ✅ test: | Tests |
| `build` | 🔧 build: | Build/configuración |
| `chore` | 🔄 chore: | Otros cambios |

## ⚡ Modo Watch (Automático)

El **modo watch** monitorea cambios cada 5 segundos y hace commit automáticamente:

```powershell
# Iniciar modo watch
.\scripts\auto-commit.ps1 -Watch
```

**Características:**
- ✅ Detecta cambios automáticamente
- ✅ Commits con mensajes descriptivos
- ✅ Push automático habilitado
- ✅ Muestra progreso cada minuto
- ✅ Presiona `Ctrl+C` para salir

## 🔧 Configuración Recomendada

### Para desarrollo activo:
```powershell
# Terminal 1: Ejecutar Flutter
flutter run -d chrome

# Terminal 2: Modo watch para commits
.\scripts\auto-commit.ps1 -Watch
```

### Para commits manuales frecuentes:
```powershell
# Commit rápido
.\scripts\auto-commit.ps1 -Type chore -Message "ajustes menores" -Push

# O usar el alias rápido en VS Code: Ctrl+Shift+P -> "Auto Commit - Quick"
```

## 📋 Ejemplos de Uso

```powershell
# Nuevas funcionalidades
.\scripts\auto-commit.ps1 -Type feat -Message "agregar filtros de categoría" -Push
.\scripts\auto-commit.ps1 -Type feat -Message "implementar modo oscuro" -Push

# Correcciones
.\scripts\auto-commit.ps1 -Type fix -Message "corregir error de navegación" -Push
.\scripts\auto-commit.ps1 -Type fix -Message "solucionar crash en Android" -Push

# Documentación
.\scripts\auto-commit.ps1 -Type docs -Message "actualizar guía de instalación" -Push
.\scripts\auto-commit.ps1 -Type docs -Message "agregar ejemplos de API" -Push

# Refactorización
.\scripts\auto-commit.ps1 -Type refactor -Message "mejorar arquitectura BLoC" -Push
```

## 🎨 VS Code Integration

**Comandos rápidos desde VS Code:**

1. **Command Palette** (`Ctrl+Shift+P`):
   - `Tasks: Auto Commit - Feature`
   - `Tasks: Auto Commit - Fix` 
   - `Tasks: Auto Commit - Quick`

2. **Keybindings personalizados** (opcional):
   ```json
   {
     "key": "ctrl+alt+c",
     "command": "workbench.action.tasks.runTask",
     "args": "Auto Commit - Quick"
   }
   ```

## ⚠️ Buenas Prácticas

### ✅ Recomendado:
- Usar **modo watch** durante desarrollo activo
- Mensajes descriptivos para commits importantes
- Push automático habilitado para sincronización
- Commits frecuentes con cambios pequeños

### ❌ Evitar:
- Commits muy grandes con muchos archivos
- Mensajes genéricos como "cambios"
- Commitear archivos temporales o build

## 🔄 Workflow Recomendado

1. **Inicio de sesión de desarrollo:**
   ```powershell
   # Terminal 1: Flutter en modo desarrollo
   flutter run -d chrome --hot
   
   # Terminal 2: Auto commits
   .\scripts\auto-commit.ps1 -Watch
   ```

2. **Para features específicas:**
   ```powershell
   git checkout -b feature/nueva-funcionalidad
   # Desarrollar...
   .\scripts\auto-commit.ps1 -Type feat -Message "implementar nueva funcionalidad" -Push
   ```

3. **Para fixes rápidos:**
   ```powershell
   .\scripts\auto-commit.ps1 -Type fix -Message "descripción del fix" -Push
   ```

---

**¡Con este sistema tendrás commits automáticos y organizados para todo tu desarrollo! 🎉**