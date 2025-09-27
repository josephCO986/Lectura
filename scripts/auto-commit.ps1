# Auto Commit PowerShell Script para Windows
# Uso: .\auto-commit.ps1 [tipo] [mensaje]

param(
    [string]$Type = "chore",
    [string]$Message = "",
    [switch]$Push = $false,
    [switch]$Watch = $false,
    [switch]$Help = $false
)

# Función para mostrar ayuda
function Show-Help {
    Write-Host "🤖 Auto Commit Helper - Lectura Temporal App" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor Yellow
    Write-Host "  .\auto-commit.ps1 -Type feat -Message 'nueva funcionalidad'"
    Write-Host "  .\auto-commit.ps1 -Type fix -Message 'corregir bug' -Push"
    Write-Host "  .\auto-commit.ps1 -Watch  # Modo watch automático"
    Write-Host ""
    Write-Host "Tipos disponibles:" -ForegroundColor Yellow
    Write-Host "  feat      - Nueva funcionalidad"
    Write-Host "  fix       - Corrección de bugs"
    Write-Host "  docs      - Documentación"
    Write-Host "  style     - Cambios de estilo"
    Write-Host "  refactor  - Refactorización"
    Write-Host "  test      - Tests"
    Write-Host "  build     - Build/configuración"
    Write-Host "  chore     - Otros cambios"
    Write-Host ""
    Write-Host "Parámetros:" -ForegroundColor Yellow
    Write-Host "  -Push     - Hace push automático después del commit"
    Write-Host "  -Watch    - Modo watch para commits automáticos"
    Write-Host "  -Help     - Muestra esta ayuda"
}

# Función para obtener el prefijo según el tipo
function Get-CommitPrefix {
    param([string]$CommitType)
    
    switch ($CommitType.ToLower()) {
        "feat" { return "feat: " }
        "feature" { return "feat: " }
        "fix" { return "fix: " }
        "bugfix" { return "fix: " }
        "docs" { return "docs: " }
        "doc" { return "docs: " }
        "style" { return "style: " }
        "refactor" { return "refactor: " }
        "test" { return "test: " }
        "build" { return "build: " }
        default { return "chore: " }
    }
}

# Función para hacer commit automático
function Auto-Commit {
    param(
        [string]$CommitMessage,
        [string]$CommitType = "chore",
        [bool]$AutoPush = $false
    )
    
    # Generar mensaje automático si no se proporciona
    if ([string]::IsNullOrEmpty($CommitMessage)) {
        $CommitMessage = "Auto commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }
    
    # Obtener prefijo
    $prefix = Get-CommitPrefix $CommitType
    $fullMessage = "$prefix$CommitMessage"
    
    try {
        # Agregar archivos
        git add .
        
        # Verificar si hay cambios
        $gitStatus = git status --porcelain
        if ([string]::IsNullOrEmpty($gitStatus)) {
            Write-Host "❌ No hay cambios para commitear" -ForegroundColor Red
            return $false
        }
        
        # Hacer commit
        git commit -m $fullMessage
        Write-Host "Commit realizado: $fullMessage" -ForegroundColor Green
        
        # Push automático si está habilitado
        if ($AutoPush) {
            $currentBranch = git branch --show-current
            git push origin $currentBranch
            Write-Host "Push realizado a $currentBranch" -ForegroundColor Blue
        }
        
        return $true
    }
    catch {
        Write-Host "❌ Error al hacer commit: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para modo watch
function Start-WatchMode {
    Write-Host "👀 Iniciando modo watch para auto-commit..." -ForegroundColor Cyan
    Write-Host "💡 Presiona Ctrl+C para salir" -ForegroundColor Yellow
    Write-Host ""
    
    $lastCommit = git rev-parse HEAD
    $watchCount = 0
    
    while ($true) {
        Start-Sleep -Seconds 5
        $watchCount++
        
        # Mostrar progreso cada 12 iteraciones (1 minuto)
        if ($watchCount % 12 -eq 0) {
            Write-Host "⏰ Watch activo... ($(Get-Date -Format 'HH:mm:ss'))" -ForegroundColor Gray
        }
        
        # Verificar cambios
        $gitStatus = git status --porcelain
        if (![string]::IsNullOrEmpty($gitStatus)) {
            Write-Host "📝 Cambios detectados, haciendo commit automático..." -ForegroundColor Yellow
            
            # Analizar tipos de cambios para mejor mensaje
            $changes = $gitStatus -split "`n"
            $hasNewFiles = $changes | Where-Object { $_ -match "^\?\?" }
            $hasModified = $changes | Where-Object { $_ -match "^ M" }
            $hasDeleted = $changes | Where-Object { $_ -match "^ D" }
            
            $autoMessage = "Cambios automáticos detectados"
            if ($hasNewFiles) { $autoMessage += " (nuevos archivos)" }
            if ($hasModified) { $autoMessage += " (archivos modificados)" }
            if ($hasDeleted) { $autoMessage += " (archivos eliminados)" }
            
            Auto-Commit -CommitMessage $autoMessage -CommitType "chore" -AutoPush $true
            $lastCommit = git rev-parse HEAD
            $watchCount = 0  # Reset counter después de commit
        }
    }
}

# Script principal
if ($Help) {
    Show-Help
    exit
}

if ($Watch) {
    Start-WatchMode
    exit
}

# Commit normal
if ([string]::IsNullOrEmpty($Message)) {
    Write-Host "⚠️  No se proporcionó mensaje. Usa -Help para ver opciones." -ForegroundColor Yellow
    Show-Help
    exit
}

Auto-Commit -CommitMessage $Message -CommitType $Type -AutoPush $Push