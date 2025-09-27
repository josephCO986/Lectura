@echo off
REM Auto Commit Batch Script para Windows
REM Uso: auto-commit.bat [tipo] [mensaje]

if "%1"=="help" goto :help
if "%1"=="--help" goto :help
if "%1"=="-h" goto :help
if "%1"=="" goto :help

set TYPE=%1
set MESSAGE=%2

REM Determinar prefijo según tipo
if "%TYPE%"=="feat" set PREFIX=✨ feat: 
if "%TYPE%"=="feature" set PREFIX=✨ feat: 
if "%TYPE%"=="fix" set PREFIX=🐛 fix: 
if "%TYPE%"=="bugfix" set PREFIX=🐛 fix: 
if "%TYPE%"=="docs" set PREFIX=📝 docs: 
if "%TYPE%"=="doc" set PREFIX=📝 docs: 
if "%TYPE%"=="style" set PREFIX=💄 style: 
if "%TYPE%"=="refactor" set PREFIX=♻️ refactor: 
if "%TYPE%"=="test" set PREFIX=✅ test: 
if "%TYPE%"=="build" set PREFIX=🔧 build: 
if "%PREFIX%"=="" set PREFIX=🔄 chore: 

REM Si no hay mensaje, generar uno automático
if "%MESSAGE%"=="" (
    for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set DATE=%%c-%%a-%%b
    for /f "tokens=1-2 delims=: " %%a in ('time /t') do set TIME=%%a:%%b
    set MESSAGE=Auto commit: %DATE% %TIME%
)

echo 📝 Haciendo commit automático...
git add .

REM Verificar si hay cambios
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%PREFIX%%MESSAGE%"
    echo ✅ Commit realizado: %PREFIX%%MESSAGE%
    
    REM Push automático si AUTO_PUSH está configurado
    if "%AUTO_PUSH%"=="true" (
        for /f "tokens=*" %%i in ('git branch --show-current') do set BRANCH=%%i
        git push origin %BRANCH%
        echo 🚀 Push realizado a %BRANCH%
    )
) else (
    echo ❌ No hay cambios para commitear
)

goto :end

:help
echo 🤖 Auto Commit Helper - Lectura Temporal App
echo.
echo Uso:
echo   auto-commit.bat feat "nueva funcionalidad"
echo   auto-commit.bat fix "corregir bug"
echo   auto-commit.bat docs "actualizar documentación"
echo.
echo Tipos disponibles:
echo   feat      - ✨ Nueva funcionalidad
echo   fix       - 🐛 Corrección de bugs  
echo   docs      - 📝 Documentación
echo   style     - 💄 Cambios de estilo
echo   refactor  - ♻️ Refactorización
echo   test      - ✅ Tests
echo   build     - 🔧 Build/configuración
echo.
echo Variables de entorno:
echo   set AUTO_PUSH=true  - Habilita push automático
echo.
echo Ejemplos:
echo   auto-commit.bat feat "pantalla de login"
echo   set AUTO_PUSH=true ^&^& auto-commit.bat fix "bug en formulario"

:end