if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
  Write-Host 'Codex is not installed or is not on PATH.' -ForegroundColor Yellow
  Write-Host 'Install Codex from https://learn.chatgpt.com/docs/codex/cli and run this installer again.'
  Start-Process 'https://learn.chatgpt.com/docs/codex/cli'
  return
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host 'Git is required to add the plugin marketplace. Install it from https://git-scm.com/downloads and rerun.' -ForegroundColor Yellow
  return
}

codex plugin marketplace add Druidia-Services/rodeo-network-plugins
if ($LASTEXITCODE -ne 0) {
  Write-Host 'Adding the Rodeo Network marketplace failed. Review the output above, resolve the issue, and rerun this installer.' -ForegroundColor Yellow
  return
}

codex plugin add rodeo-network-operator@rodeo-network
if ($LASTEXITCODE -ne 0) {
  Write-Host 'Installing Rodeo Network Operator failed. Review the output above, resolve the issue, and rerun this installer.' -ForegroundColor Yellow
  return
}

Write-Host 'Rodeo Network Operator installed for Codex.' -ForegroundColor Green
Write-Host 'Start a fresh Codex session, review the SessionStart hook, and complete browser OAuth on first use.'
Write-Host 'The plugin installs two MCP servers. Authenticate rodeo_network_admin for normal work; rodeo_network_web is optional and only for testing the web-safe profile.'
