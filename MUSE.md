# Install Rodeo Network in Meta Muse

These instructions are written for the agent. A person only needs to send Muse this message:

```text
Install Rodeo Network for me from https://github.com/Druidia-Services/rodeo-network-plugins. Read MUSE.md there and follow it.
```

If the person gave you a different Rodeo Network address (a circuit or committee custom domain), use that host everywhere this file says `https://admin.prorodeos.org`.

Muse connects to the **full operator profile**, `https://admin.prorodeos.org/api/mcp`. Muse has its own computer to run code, a browser, and process files, so it gets the same surface as Codex and Claude Code. Do not connect `/api/web-mcp`; that is the narrower profile for browser-only agents, and a token issued for one endpoint is rejected by the other.

There are two Muse products. Follow the section for the one you are.

- **Muse** (the Muse app, WhatsApp, muse.ai): follow *Muse app* below.
- **Muse Code** (the terminal coding agent): follow *Muse Code* further down.

## Muse app

Muse does not install plugins or skill files. You build a custom connector to the Rodeo Network MCP server and save it as a reusable skill.

### 1. Build the connector

Create a custom connector for a remote MCP server:

- Name: `rodeo_network_admin`
- Transport: streamable HTTP
- URL: `https://admin.prorodeos.org/api/mcp`
- Auth: OAuth 2.1. There is no API key.

The OAuth details your client needs:

- An unauthenticated request to the URL returns `401` with a `WWW-Authenticate` header naming the protected-resource metadata, `https://admin.prorodeos.org/.well-known/oauth-protected-resource`. The path-inserted form `/.well-known/oauth-protected-resource/api/mcp` returns the same document.
- Authorization server metadata: `https://admin.prorodeos.org/.well-known/oauth-authorization-server`.
- Register a public client with dynamic client registration at `https://admin.prorodeos.org/register`, using your own HTTPS callback as the redirect URI. Any HTTPS redirect URI is accepted.
- Authorization code flow with PKCE `S256`. Send `resource=https://admin.prorodeos.org/api/mcp` on both the authorize and token requests, and request the scopes `rodeo:mcp offline_access`.
- Access tokens last one hour. Refresh tokens last 90 days and rotate on every use: store the newest refresh token each time, or the next refresh fails and the person has to sign in again.

The person signs in to Rodeo Network in the browser window and approves access. Never ask for a password, access token, authorization code, or dashboard session in chat. Credentials belong in your secure credential store, not the conversation.

### 2. Verify the connection

1. List the server's tools.
2. Call `account_context_get` and tell the person which account and rodeos it returned. Do not make any claim about Rodeo Network records before this call succeeds.
3. Call `tool_domains_list`. Business tools are grouped by domain: load a domain with `tool_domain_load` (for example `{"domain":"sponsors"}`), then run one of its tools with `tool_domain_call`, passing the domain, the tool name, and its arguments.

### 3. Save the operating rules with the connector

When you save the connector as a reusable skill, include these rules in it so every future conversation starts correctly:

- Copy the body of [`plugins/rodeo-network-operator/skills/rodeo-network/SKILL.md`](plugins/rodeo-network-operator/skills/rodeo-network/SKILL.md) into the saved skill. It says when a task counts as rodeo work, the first calls to make, how gated actions are approved, and what not to log. Skip its first-run step about a local `AGENTS.md`; your saved skill takes that file's place.
- At the start of every Rodeo Network task, fetch `https://admin.prorodeos.org/api/agent/skill` and follow it. That hosted skill is the current operating policy and changes without notice. Do not save a frozen copy of it.

### 4. Approvals

Suggest that the person set this connector to require approval for each action in Muse settings until they are comfortable with it. That approval is Muse's own check. It does not replace Rodeo Network's: money, publishing, deleting, and erasing a person's data still need a prepared review, recorded with `action_review_decide` only after the person explicitly approves in chat.

### 5. What your computer can and cannot do here

Your computer runs in Meta's cloud. It can process files the person hands you, such as images, PDFs, and spreadsheets, and send them to Rodeo Network through the MCP tools. For images and documents, use the base64 media tools the hosted skill names. You cannot see the person's own computer or anything on their local network. When a task needs their local files, ask them to share the files with you.

### 6. If sign-in fails

Stop and tell the person which step failed: client registration, the sign-in window, the token exchange, or a refresh after the first hour. Ask them to report it to whoever runs their Rodeo Network account. Do not work around it with a password, a copied session, or a different endpoint, and do not claim you read or changed any record.

## Muse Code

Muse Code reads standard skill folders and remote MCP servers, so it installs much like Claude Code.

1. **Add the MCP server.** In your user settings file (`~/.config/muse/settings.json`, or the settings file your installation uses), merge this into `mcp_servers`. Keep `"schema_version": 1` and every existing entry:

   ```json
   {
     "mcp_servers": {
       "rodeo_network_admin": {
         "transport": "streamable_http",
         "url": "https://admin.prorodeos.org/api/mcp"
       }
     }
   }
   ```

2. **Sign in.** Have the person run `muse mcp login rodeo_network_admin` and finish the browser sign-in. Do not ask for tokens.
3. **Install the bootstrap skill.** Copy the folder [`plugins/rodeo-network-operator/skills/rodeo-network/`](plugins/rodeo-network-operator/skills/rodeo-network/) to `~/.agents/skills/rodeo-network/`. The skill's own first-run step creates the local workspace: it fetches `https://admin.prorodeos.org/api/agent/install` and writes `C:\RodeoNetwork\AGENTS.md` on Windows or `~/RodeoNetwork/AGENTS.md` elsewhere. Muse Code reads `AGENTS.md` natively when a session starts in that folder.
4. **Verify.** Start a fresh session in the RodeoNetwork folder. Run `muse mcp` to confirm `rodeo_network_admin` and its tools, then call `account_context_get`.

The plugin's `SessionStart` hook is written for Claude Code and Codex and is not installed in Muse Code. The skill carries the same privacy boundary.

## Privacy boundary

This repository contains no credentials and no rodeo data. The connection is made through Rodeo Network's own browser sign-in, and continuity debriefs are written only through the authenticated Rodeo Network API. File only the rodeo-related part of a task. Leave out personal errands, unrelated messages, credentials, and full private transcripts.
