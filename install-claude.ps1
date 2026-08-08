$ErrorActionPreference = 'Stop'

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Host 'Claude Code is not installed or is not on PATH.' -ForegroundColor Yellow
  Write-Host 'Install Claude Code from https://code.claude.com/docs/en/installation and run this installer again.'
  Start-Process 'https://code.claude.com/docs/en/installation'
  exit 1
}

claude plugin marketplace add Druidia-Services/rodeo-network-plugins
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

claude plugin install rodeo-network-operator@rodeo-network
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host 'Rodeo Network Operator installed for Claude Code.' -ForegroundColor Green
Write-Host 'Start a fresh Claude Code session, review the SessionStart hook, and complete browser OAuth on first use.'
