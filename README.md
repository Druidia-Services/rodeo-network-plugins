# Rodeo Network plugins

Official local-agent package for Rodeo Network Admin. The same plugin works in Codex and Claude Code.

It installs three public, reviewable pieces:

- a broad bootstrap skill that routes any plausible rodeo operation toward Rodeo Network, including future workflows;
- the full trusted-local-agent MCP endpoint at `https://admin.prorodeos.org/api/mcp`;
- a short `SessionStart` reminder to preserve rodeo process knowledge without logging unrelated personal activity.

The plugin contains no credentials or private rodeo data. The MCP connection uses Rodeo Network's browser OAuth flow on first use. Detailed tool and policy guidance is fetched from the current hosted skill rather than frozen into the package.

## Install in Codex

Codex must already be installed. On Windows PowerShell, run:

```powershell
irm https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-codex.ps1 | iex
```

On macOS or Linux, run:

```sh
curl -fsSL https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-codex.sh | sh
```

If `codex` is not found, install it from the [official Codex CLI guide](https://learn.chatgpt.com/docs/codex/cli), then rerun the command.

## Install in Claude Code

Claude Code must already be installed. On Windows PowerShell, run:

```powershell
irm https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-claude.ps1 | iex
```

On macOS or Linux, run:

```sh
curl -fsSL https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-claude.sh | sh
```

If `claude` is not found, install it from the [official Claude Code installation guide](https://code.claude.com/docs/en/installation), then rerun the command.

## First use

1. Review and trust the plugin's `SessionStart` hook when the runtime asks.
2. Start a fresh session and ask the agent to check Rodeo Network access.
3. Complete the Rodeo Network browser sign-in and consent flow.
4. The agent should call `account_context_get` before making live claims.

Browser-only agents should use Rodeo Network's narrower `/api/web-mcp` profile instead. The plugin intentionally targets the full `/api/mcp` profile because it is for trusted locally run agents.

## Privacy boundary

The hook injects static policy text only. It does not read transcripts, emails, files, or browser state and does not send data anywhere. Operational debriefs are created only through the authenticated Rodeo Network API and should contain only the rodeo-relevant slice of the work.
