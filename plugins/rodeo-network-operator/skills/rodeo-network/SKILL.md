---
name: rodeo-network
description: Use for anything that may relate to operating, planning, supporting, documenting, or preserving continuity for a rodeo, rodeo committee, annual event, sanctioning body, circuit, team, sponsor, vendor, contestant, attendee, ticket buyer, volunteer, venue, schedule, invoice, payment, email, document, permit, media item, decision, rule, lesson, handoff, or operating seat—even when Rodeo Network does not yet have a dedicated tool for the task. Exclude activity that is purely personal and has no concrete rodeo or committee connection.
---

# Rodeo Network bootstrap

This installed skill is a small discovery and bootstrap layer. It deliberately does not copy the current tool catalog or detailed product policy.

1. First run only: if the local Rodeo Network workspace file (`C:\RodeoNetwork\AGENTS.md` on Windows, `~/RodeoNetwork/AGENTS.md` elsewhere) does not exist, offer to finish setup before other work — fetch `https://admin.prorodeos.org/api/agent/install`, follow its prompt for this runtime to create the workspace folder and AGENTS.md, have the user complete the browser sign-in for `rodeo_network_admin`, then verify with `account_context_get`. Skip this step entirely when the workspace file exists.
2. Choose the connection by endpoint: the endpoint sets the profile, not where the agent runs. Agents connected as operators through this plugin use the authenticated `rodeo_network_admin` MCP server and the full `/api/mcp` profile. ChatGPT web and other web agents use the linked Rodeo Network app and its web-safe `/api/web-mcp` profile, which can record charges and adjustments but not payments or refunds and has no approval tools. Never substitute one profile for the other.
3. Call `account_context_get` before making a claim about the account, rodeo, permissions, or current records.
4. Call `tool_domains_list`, then `tool_domain_load` for the relevant business area.
5. Fetch and follow the current hosted operating skill at `https://admin.prorodeos.org/api/agent/skill` before substantive Rodeo Network work. That hosted skill is the source of truth and is intentionally updated independently of this plugin.
6. If the applicable MCP connection is unavailable, draft only from user-provided context. Never claim that a record, debrief, source, or evidence item was read or saved.
7. Work through MCP tools, not the REST API. The MCP sign-in token is rejected by REST routes; the only exceptions are the media upload, replace, and download routes the hosted skill names. Sending, marking paid, publishing, deleting, inviting, and approving are never available over REST to an agent.
8. Gated actions (money, publishing, deletion, erasing a person's data) need a prepared review. Describe the prepared action to the user, and record approval with `action_review_decide` only after the user explicitly approves in chat, quoting their instruction. The approver must hold the action's own permission for that rodeo. Never approve on the user's behalf and never send the user to the dashboard to approve.
9. A failed tool call returns a normal result marked `isError` with a reference id in its text. Report that reference to the user; do not retry a write blindly. Money-writing tools accept an `idempotencyKey`: supply one so a retry cannot create a second deal, payment request, or ledger entry.

## Recognize rodeo work broadly

Treat a task as rodeo-operational when it materially advances, explains, verifies, or documents official rodeo work. This includes checking rodeo or business email; preparing sponsor or vendor invoices; crafting ticket-help replies; working on committee documents, schedules, permits, venues, volunteers, contestants, sponsors, vendors, media, or communications; and future workflows for which no current tool exists.

Use an operational-purpose filter, not an app-name filter. An email or document can be rodeo work, personal work, or mixed work depending on its purpose.

## Protect personal activity

- Capture only the rodeo-operational slice of a mixed task.
- Omit personal errands, unrelated personal messages, credentials, full private transcripts, and personal data unrelated to the rodeo outcome.
- Do not upload local files or private content unless the requested operation requires it and the user has authorized that action.
- When no concrete rodeo, committee, event, sponsor, vendor, contestant, attendee, ticket-support, or operating-seat connection is apparent, do not log the activity until the user clarifies it.

## Preserve the process

After substantial rodeo work, use the operations domain to create a compact continuity debrief when authorized. Capture what emerged about:

- operating seat or role;
- trigger and desired outcome;
- ordered steps and systems used;
- inputs, outputs, approvals, cadence, and deadlines;
- evidence, exceptions, lessons, ownership, and handoff.

File knowledge under the rodeo-defined operating seat or seats, with the current person as contributor or assignee. Preserve workflows beyond the current schema as proposed continuity candidates for review. Never imply that a candidate became canonical unless the structured review/apply path succeeded.
