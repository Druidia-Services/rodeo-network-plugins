$ErrorActionPreference = 'Stop'

if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
  Write-Host 'Codex is not installed or is not on PATH.' -ForegroundColor Yellow
  Write-Host 'Install Codex from https://learn.chatgpt.com/docs/codex/cli and run this installer again.'
  Start-Process 'https://learn.chatgpt.com/docs/codex/cli'
  exit 1
}

codex plugin marketplace add Druidia-Services/rodeo-network-plugins
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

codex plugin add rodeo-network-operator@rodeo-network
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host 'Rodeo Network Operator installed for Codex.' -ForegroundColor Green
Write-Host 'Start a fresh Codex session, review the SessionStart hook, and complete browser OAuth on first use.'
