#!/bin/bash
# Auto Commit Script para desarrollo

# Función para hacer commit automático
auto_commit() {
    local message=$1
    local type=$2
    
    # Si no se proporciona mensaje, generar uno automático
    if [ -z "$message" ]; then
        message="Auto commit: $(date +'%Y-%m-%d %H:%M:%S')"
    fi
    
    # Prefijo según tipo de cambio
    case $type in
        "feat"|"feature")
            prefix="✨ feat: "
            ;;
        "fix"|"bugfix")
            prefix="🐛 fix: "
            ;;
        "docs"|"doc")
            prefix="📝 docs: "
            ;;
        "style")
            prefix="💄 style: "
            ;;
        "refactor")
            prefix="♻️ refactor: "
            ;;
        "test")
            prefix="✅ test: "
            ;;
        "build")
            prefix="🔧 build: "
            ;;
        *)
            prefix="🔄 chore: "
            ;;
    esac
    
    # Agregar archivos modificados
    git add .
    
    # Verificar si hay cambios
    if git diff --cached --quiet; then
        echo "❌ No hay cambios para commitear"
        return 1
    fi
    
    # Hacer commit
    git commit -m "${prefix}${message}"
    
    echo "✅ Commit realizado: ${prefix}${message}"
    
    # Push automático si está configurado
    if [ "$AUTO_PUSH" = "true" ]; then
        git push origin $(git branch --show-current)
        echo "🚀 Push realizado automáticamente"
    fi
}

# Función para commit rápido con mensaje
quick_commit() {
    auto_commit "$1" "chore"
}

# Función para commit de feature
feat_commit() {
    auto_commit "$1" "feat"
}

# Función para commit de fix
fix_commit() {
    auto_commit "$1" "fix"
}

# Función para commit de docs
docs_commit() {
    auto_commit "$1" "docs"
}

# Función para verificar cambios y commitear automáticamente
watch_and_commit() {
    echo "👀 Iniciando watch mode para auto-commit..."
    echo "💡 Presiona Ctrl+C para salir"
    
    local last_commit=$(git rev-parse HEAD)
    
    while true; do
        sleep 5
        
        # Verificar si hay cambios
        if ! git diff --quiet || ! git diff --cached --quiet; then
            echo "📝 Cambios detectados, haciendo commit automático..."
            auto_commit "Cambios detectados automáticamente" "chore"
            last_commit=$(git rev-parse HEAD)
        fi
    done
}

# Ayuda
show_help() {
    echo "🤖 Auto Commit Helper - Lectura Temporal App"
    echo ""
    echo "Comandos disponibles:"
    echo "  ./auto-commit.sh quick \"mensaje\"     - Commit rápido"
    echo "  ./auto-commit.sh feat \"mensaje\"      - Commit de feature"
    echo "  ./auto-commit.sh fix \"mensaje\"       - Commit de fix"
    echo "  ./auto-commit.sh docs \"mensaje\"      - Commit de documentación"
    echo "  ./auto-commit.sh watch                 - Modo watch (auto-commit)"
    echo ""
    echo "Variables de entorno:"
    echo "  AUTO_PUSH=true                        - Habilita push automático"
    echo ""
    echo "Ejemplos:"
    echo "  ./auto-commit.sh feat \"nueva pantalla de login\""
    echo "  AUTO_PUSH=true ./auto-commit.sh fix \"corregir bug en formulario\""
}

# Router principal
case $1 in
    "quick")
        quick_commit "$2"
        ;;
    "feat"|"feature")
        feat_commit "$2"
        ;;
    "fix"|"bugfix")
        fix_commit "$2"
        ;;
    "docs"|"doc")
        docs_commit "$2"
        ;;
    "watch")
        watch_and_commit
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        if [ -z "$1" ]; then
            show_help
        else
            quick_commit "$1"
        fi
        ;;
esac