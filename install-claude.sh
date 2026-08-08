#!/usr/bin/env sh
set -eu

if ! command -v claude >/dev/null 2>&1; then
  echo 'Claude Code is not installed or is not on PATH.' >&2
  echo 'Install Claude Code from https://code.claude.com/docs/en/installation and run this installer again.' >&2
  exit 1
fi

claude plugin marketplace add Druidia-Services/rodeo-network-plugins
claude plugin install rodeo-network-operator@rodeo-network

echo 'Rodeo Network Operator installed for Claude Code.'
echo 'Start a fresh Claude Code session, review the SessionStart hook, and complete browser OAuth on first use.'
