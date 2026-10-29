---
name: rodeo-network-setup
description: Set up Rodeo Network on this computer for the first time, or repair a broken setup. Creates the local RodeoNetwork workspace and AGENTS.md, signs in to the rodeo_network_admin MCP server, and verifies the connection with account_context_get. Use right after installing the plugin, when the workspace file is missing, or when Rodeo Network sign-in fails. Not for day-to-day rodeo work; that is the rodeo-network skill.
license: MIT
metadata:
  display-name: Rodeo Network setup
---

# Rodeo Network setup

Run these steps in order. Stop and tell the user which step failed if any of them does.

1. **Check the workspace.** The local workspace file is `C:\RodeoNetwork\AGENTS.md` on Windows and `~/RodeoNetwork/AGENTS.md` elsewhere. If it already exists and the user did not ask for a repair, say setup is already done and go to step 4.
2. **Create the workspace.** Fetch `https://admin.prorodeos.org/api/agent/install` and follow the prompt it returns for this runtime. It creates the workspace folder and writes `AGENTS.md`. Write only what that prompt specifies. Never put a token, password, API key, or sign-in code in `AGENTS.md` or in a visible command.
3. **Sign in.** The user signs in to Rodeo Network in the browser for the `rodeo_network_admin` MCP server, the full operator profile at `https://admin.prorodeos.org/api/mcp`. Point them to their runtime's own sign-in step: `/mcp` in Claude Code, `codex mcp login rodeo_network_admin` in Codex, `muse mcp login rodeo_network_admin` in Muse Code. `rodeo_network_web` is optional; it is only for testing the web-safe profile. Never ask for a password, token, or authorization code in chat.
4. **Verify.** Call `account_context_get` and tell the user which account and rodeos it returned. If the tools are not visible yet, ask the user to start a fresh session, in the RodeoNetwork folder when the runtime supports project folders, and check again.
5. **Hand off.** Tell the user setup is complete and that day-to-day work goes through the `rodeo-network` skill. Do not claim any Rodeo Network record was read or changed during setup.
