# Auto Commit PowerShell Script Simple
param(
    [string]$Type = "chore",
    [string]$Message = "",
    [switch]$Push = $false,
    [switch]$Watch = $false,
    [switch]$Help = $false
)

function Show-Help {
    Write-Host "Auto Commit Helper - Lectura Temporal App" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Uso:"
    Write-Host "  .\auto-commit-simple.ps1 -Type feat -Message 'nueva funcionalidad' -Push"
    Write-Host "  .\auto-commit-simple.ps1 -Type fix -Message 'corregir bug' -Push"
    Write-Host "  .\auto-commit-simple.ps1 -Watch"
    Write-Host ""
    Write-Host "Tipos: feat, fix, docs, style, refactor, test, build, chore"
}

function Get-CommitPrefix {
    param([string]$CommitType)
    
    switch ($CommitType.ToLower()) {
        "feat" { return "feat: " }
        "fix" { return "fix: " }
        "docs" { return "docs: " }
        "style" { return "style: " }
        "refactor" { return "refactor: " }
        "test" { return "test: " }
        "build" { return "build: " }
        default { return "chore: " }
    }
}

function Auto-Commit {
    param(
        [string]$CommitMessage,
        [string]$CommitType = "chore",
        [bool]$AutoPush = $false
    )
    
    if ([string]::IsNullOrEmpty($CommitMessage)) {
        $CommitMessage = "Auto commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }
    
    $prefix = Get-CommitPrefix $CommitType
    $fullMessage = "$prefix$CommitMessage"
    
    try {
        git add .
        
        $gitStatus = git status --porcelain
        if ([string]::IsNullOrEmpty($gitStatus)) {
            Write-Host "No hay cambios para commitear" -ForegroundColor Red
            return $false
        }
        
        git commit -m $fullMessage
        Write-Host "Commit realizado: $fullMessage" -ForegroundColor Green
        
        if ($AutoPush) {
            $currentBranch = git branch --show-current
            git push origin $currentBranch
            Write-Host "Push realizado a $currentBranch" -ForegroundColor Blue
        }
        
        return $true
    }
    catch {
        Write-Host "Error al hacer commit: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Start-WatchMode {
    Write-Host "Iniciando modo watch para auto-commit..." -ForegroundColor Cyan
    Write-Host "Presiona Ctrl+C para salir" -ForegroundColor Yellow
    
    while ($true) {
        Start-Sleep -Seconds 5
        
        $gitStatus = git status --porcelain
        if (![string]::IsNullOrEmpty($gitStatus)) {
            Write-Host "Cambios detectados, haciendo commit automatico..." -ForegroundColor Yellow
            Auto-Commit -CommitMessage "Cambios automaticos detectados" -CommitType "chore" -AutoPush $true
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

if ([string]::IsNullOrEmpty($Message)) {
    Write-Host "No se proporciono mensaje. Usa -Help para ver opciones." -ForegroundColor Yellow
    Show-Help
    exit
}

Auto-Commit -CommitMessage $Message -CommitType $Type -AutoPush $Push