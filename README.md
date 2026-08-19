# Rodeo Network plugins

Official agent package for Rodeo Network Admin. It links ChatGPT web to the web-safe profile and gives Codex and Claude Code the full trusted-local-agent profile.

It contains four public, reviewable pieces:

- a broad bootstrap skill that routes any plausible rodeo operation toward Rodeo Network, including future workflows;
- two MCP servers installed together in Codex and Claude Code: the full trusted-local-agent endpoint at `https://admin.prorodeos.org/api/mcp` (`rodeo_network_admin`) and the narrower web-safe endpoint at `https://admin.prorodeos.org/api/web-mcp` (`rodeo_network_web`);
- the registered ChatGPT app backed by the same web-safe `/api/web-mcp` endpoint;
- a short `SessionStart` reminder to preserve rodeo process knowledge without logging unrelated personal activity.

The plugin contains no credentials or private rodeo data. The MCP connection uses Rodeo Network's browser OAuth flow on first use. Detailed tool and policy guidance is fetched from the current hosted skill rather than frozen into the package.

## Install in Codex

The Codex desktop app is the preferred path and does not require the Codex CLI:

1. Open **Plugins**.
2. Choose **Add** > **Add a marketplace**.
3. Paste `https://github.com/Druidia-Services/rodeo-network-plugins`.
4. Install **Rodeo Network Operator** from the new Rodeo Network marketplace.

For a terminal install, Codex CLI must already be installed. On Windows PowerShell, run:

```powershell
irm https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-codex.ps1 | iex
```

On macOS or Linux, run:

```sh
curl -fsSL https://raw.githubusercontent.com/Druidia-Services/rodeo-network-plugins/main/install-codex.sh | sh
```

If `codex` is not found, use the desktop marketplace flow above or install it from the [official Codex CLI guide](https://learn.chatgpt.com/docs/codex/cli), then rerun the command.

## Install in ChatGPT web

ChatGPT web does not install plugins from a GitHub marketplace URL. It installs the registered Rodeo Network app from ChatGPT's plugin/app directory. During development, an authorized tester can add the production MCP address in ChatGPT developer mode:

```text
https://admin.prorodeos.org/api/web-mcp
```

The package's `.app.json` links to that registered development app so the same reviewed bootstrap skill and web-safe connection can ship through OpenAI's plugin system. General directory installation remains unavailable until OpenAI approves and the publisher releases the public listing.

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
3. Complete the Rodeo Network browser sign-in for `rodeo_network_admin` (the full operator connection). `rodeo_network_web` is optional — only authenticate it to test the web-safe profile.
4. The agent should call `account_context_get` before making live claims.

ChatGPT web uses the narrower `/api/web-mcp` profile. Codex and Claude Code install both servers: `rodeo_network_admin` (`/api/mcp`, the full operator profile — the one to authenticate for normal work) and `rodeo_network_web` (`/api/web-mcp`, the web-safe profile, useful for testing exactly what browser and mobile agents can see). Each server completes its own OAuth consent; tokens are scoped to their exact resource, and the two profiles are never interchangeable.

## Privacy boundary

The hook injects static policy text only. It does not read transcripts, emails, files, or browser state and does not send data anywhere. Operational debriefs are created only through the authenticated Rodeo Network API and should contain only the rodeo-relevant slice of the work.
