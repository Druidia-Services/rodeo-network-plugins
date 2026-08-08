#!/usr/bin/env sh
set -eu

if ! command -v codex >/dev/null 2>&1; then
  echo 'Codex is not installed or is not on PATH.' >&2
  echo 'Install Codex from https://learn.chatgpt.com/docs/codex/cli and run this installer again.' >&2
  exit 1
fi

codex plugin marketplace add Druidia-Services/rodeo-network-plugins
codex plugin add rodeo-network-operator@rodeo-network

echo 'Rodeo Network Operator installed for Codex.'
echo 'Start a fresh Codex session, review the SessionStart hook, and complete browser OAuth on first use.'
