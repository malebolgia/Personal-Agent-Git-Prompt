param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProfileName
)

if (-not (Test-Path .git)) {
    Write-Error "❌ Error: This script must be executed from the root of a Git repository."
    exit 1
}

$GitHome = $HOME.Replace('\', '/')

switch ($ProfileName) {
    'personal' {
        git config --local user.name "Your Name"
        git config --local user.email "your.email@example.com"
        git config --local core.sshCommand "ssh -i $GitHome/.ssh/id_rsa"
        Write-Host "👤 Identity set to: PERSONAL" -ForegroundColor Green
    }
    'ai_claude' {
        git config --local user.name "YourName-Claude"
        git config --local user.email "claude.bot@example.com"
        git config --local core.sshCommand "ssh -i $GitHome/.ssh/id_ed25519_claude"
        Write-Host "🤖 Identity set to: CLAUDE" -ForegroundColor Cyan
    }
    'ai_codex' {
        git config --local user.name "YourName-Codex"
        git config --local user.email "codex.bot@example.com"
        git config --local core.sshCommand "ssh -i $GitHome/.ssh/id_ed25519_codex"
        Write-Host "🤖 Identity set to: CODEX" -ForegroundColor Yellow
    }
    'ai_gemini' {
        git config --local user.name "YourName-Gemini"
        git config --local user.email "gemini.bot@example.com"
        git config --local core.sshCommand "ssh -i $GitHome/.ssh/id_ed25519_gemini"
        Write-Host "🤖 Identity set to: GEMINI" -ForegroundColor Magenta
    }
    default {
        Write-Error "❌ Error: Unknown profile '$ProfileName'. Options: personal, ai_claude, ai_codex, ai_gemini"
        exit 1
    }
}

Write-Host "`nVerify Active Local Git Config:" -ForegroundColor Gray
Write-Host "Name:   $(git config --local user.name)" -ForegroundColor White
Write-Host "Email:  $(git config --local user.email)" -ForegroundColor White
Write-Host "Config: $(git config --local core.sshCommand)" -ForegroundColor White