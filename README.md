# Agents for EU

> Replace the European Commission with a college of AI agents.

Inspired by [gstack](https://github.com/garrytan/gstack) — which turns Claude Code into a virtual engineering team — **Agents for EU** models the entire European Commission as a structured system of specialized AI agents: one per Commissioner portfolio, backed by Directorate-General agents, wired together through the EU's real legislative and policy workflows.

The goal is not satire. It is a serious attempt to simulate how the EU Commission thinks, deliberates, and produces policy — and to use that simulation as a tool for research, policy drafting, scenario testing, and civic education.

---

## What this is

| Layer | What it models |
|---|---|
| **Commissioners** | 21 portfolio agents, each with mandate, legal basis, political persona |
| **DGs** | Operational directorate agents that produce technical analysis |
| **Skills** | Reusable EU policy tools: impact assessment, consultation, treaty check… |
| **Workflows** | End-to-end processes: ordinary legislative procedure, budget cycle, infringement |
| **Agents** | Multi-agent sessions: College deliberation, trilogue, inter-service consultation |
| **Institutions** | Counter-party agents: Parliament, Council, ECJ, ECB, EEAS |

---

## Quick start

```bash
# Ask the President to open a policy initiative
/president

# Run a full College deliberation on a topic
/college-deliberate "Should the EU ban algorithmic pricing in retail?"

# Draft a legislative proposal via the standard workflow
/legislative-proposal "Regulation on synthetic biology"

# Stress-test a policy against all Commissioner portfolios
/impact-assessment "Carbon border adjustment expansion to agriculture"
```

---

## Repository layout

```
agents-for-EU/
├── CLAUDE.md                       ← how to operate this system
├── ARCHITECTURE.md                 ← design rationale & extension guide
├── CONTRIBUTING.md                 ← how to extend the system
├── CONNECTORS.md                   ← MCP connector catalogue
├── QUICKSTART.md                   ← 5-minute onboarding guide
├── SKILL.md                        ← SKILL.md authoring standard
├── marketplace.json                ← plugin registry for /plugin install
│
├── plugins/                        ← installable skill packages
│   ├── legislative-eu/             ← Policy, legislative drafting, ISC, PQ
│   ├── competition-eu/             ← Antitrust, state aid, Legal Service
│   ├── institutional-management-eu/← Unit management, HR, finance, CDR
│   ├── trade-eu/                   ← Trade defence instruments
│   ├── grants-enforcement-eu/      ← Grants, infringement, procurement
│   ├── data-communication-eu/      ← Data analysis, press, speeches
│   ├── simulation-eu/              ← Commissioner personas, College, trilogue, OLP
│   └── privacy-eu/                 ← DPIA workflow, DPO, IT security, legal officer
│       Each contains:
│           CLAUDE.md               ← domain practice profile
│           .claude-plugin/         ← plugin.json manifest
│           skills/<name>/SKILL.md  ← individual skills
│           skills/cold-start-interview/ ← plugin onboarding skill
│           hooks/                  ← symlinks to lib/hooks/
│           references/             ← reference documents loaded by skills
│
├── knowledge/                      ← EU institutional knowledge base
│   ├── commissioners/              ← 21 Commissioner agent definitions + _template.md
│   ├── dgs/                        ← 17 Directorate-General operational agents
│   ├── institutions/               ← Counter-party agents (EP, Council, ECJ, ECB, EEAS, European Council)
│   ├── workflows/                  ← End-to-end policy processes (legislative-cycle, policy-cycle)
│   └── agents/                     ← Multi-agent session definitions (college, ISC, trilogue, DPIA, EDPS)
│
├── lib/                            ← Shared technical assets
│   ├── hooks/                      ← Event hook shell scripts
│   │   ├── post-output-disclaimer.sh
│   │   ├── post-subsidiarity-prompt.sh
│   │   ├── post_tool_use_citation_matcher.sh
│   │   ├── post_tool_use_eurlex_resolver.sh
│   │   └── pre-legal-basis-check.sh
│   └── legacy-skills/              ← Pre-SKILL.md flat skills (pending conversion)
│
└── docs/                           ← Guides and reference material
    ├── getting-started.md
    ├── glossary.md
    ├── using-skills-beginners-guide.md
    └── examples/                   ← Worked end-to-end simulations
        ├── ai-act-simulation/
        ├── green-deal-package/
        └── migration-policy/
```

---

## Design principles

**One agent per mandate.** Each Commissioner's agent is scoped strictly to its treaty-based competence. The Competition Commissioner cannot speak for Agriculture; the President arbitrates conflicts.

**Real procedures, not shortcuts.** Workflows follow actual EU procedures — subsidiarity checks, impact assessments, inter-service consultations — so outputs are structurally realistic.

**Adversarial by design.** Commissioners disagree. The Council pushes back. Parliament amends. The system is built for productive tension, not rubber-stamping.

**Composable.** Every skill, commissioner, and workflow can be invoked standalone or composed into larger multi-agent sessions.

---

## Use cases

- **Policy research** — Simulate how a new regulation would be received across all Commission portfolios before it is written.
- **Legislative drafting** — Use the `legislative-proposal` skill to produce a structurally compliant draft from a one-line brief.
- **Education** — Walk students through the full ordinary legislative procedure with live agent interactions.
- **Scenario testing** — Test geopolitical shocks, climate events, or market crises against the College's deliberative capacity.
- **Civic tech** — Build tools that explain EU decisions in plain language by running them backward through the agents that produced them.

---

## Status

Early scaffolding. Commissioners and core skills are defined; multi-agent orchestration and tooling are in active development.

---

## License

MIT
