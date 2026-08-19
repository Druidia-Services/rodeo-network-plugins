if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Host 'Claude Code is not installed or is not on PATH.' -ForegroundColor Yellow
  Write-Host 'Install Claude Code from https://code.claude.com/docs/en/installation and run this installer again.'
  Start-Process 'https://code.claude.com/docs/en/installation'
  return
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host 'Git is required to add the plugin marketplace. Install it from https://git-scm.com/downloads and rerun.' -ForegroundColor Yellow
  return
}

claude plugin marketplace add Druidia-Services/rodeo-network-plugins
if ($LASTEXITCODE -ne 0) {
  Write-Host 'Adding the Rodeo Network marketplace failed. Review the output above, resolve the issue, and rerun this installer.' -ForegroundColor Yellow
  return
}

claude plugin install rodeo-network-operator@rodeo-network
if ($LASTEXITCODE -ne 0) {
  Write-Host 'Installing Rodeo Network Operator failed. Review the output above, resolve the issue, and rerun this installer.' -ForegroundColor Yellow
  return
}

Write-Host 'Rodeo Network Operator installed for Claude Code.' -ForegroundColor Green
Write-Host 'Start a fresh Claude Code session, review the SessionStart hook, and complete browser OAuth on first use.'
Write-Host 'The plugin installs two MCP servers. Authenticate rodeo_network_admin for normal work; rodeo_network_web is optional and only for testing the web-safe profile.'
