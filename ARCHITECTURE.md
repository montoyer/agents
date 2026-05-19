# Architecture

## Overview

Agents for EU is a layered multi-agent framework. The layers map directly onto the European Commission's actual institutional structure: political leadership (Commissioners), technical administration (DGs), procedural instruments (skills), and inter-institutional relationships (institutions).

```
┌─────────────────────────────────────────────────────┐
│                    USER / RESEARCHER                │
└───────────────────────┬─────────────────────────────┘
                        │ invokes skill, workflow, or agent
┌───────────────────────▼─────────────────────────────┐
│                   SKILLS LAYER                      │
│  impact-assessment · legislative-proposal ·         │
│  treaty-check · consultation · state-aid-review …  │
└───────────────────────┬─────────────────────────────┘
                        │ delegates to
          ┌─────────────┴──────────────┐
          │                            │
┌─────────▼──────────┐    ┌────────────▼────────────┐
│  COMMISSIONER LAYER│    │      DG LAYER           │
│  21 portfolio agents│   │  16 directorate agents  │
│  Political mandate  │   │  Technical analysis     │
│  Treaty competence  │   │  Legal framing, data    │
└─────────┬──────────┘    └────────────┬────────────┘
          │                            │
          └─────────────┬──────────────┘
                        │ coordinates via
┌───────────────────────▼─────────────────────────────┐
│                  AGENTS LAYER                       │
│  college-deliberation · inter-service-consultation  │
│  trilogue · task-force                             │
└───────────────────────┬─────────────────────────────┘
                        │ negotiates with
┌───────────────────────▼─────────────────────────────┐
│               INSTITUTIONS LAYER                    │
│  European Parliament · Council · ECJ · ECB · EEAS   │
└─────────────────────────────────────────────────────┘
```

---

## Layer 1 — Skills

Skills are **stateless, procedural tools**. They take a brief as input, run a structured procedure, and return a formatted output. They are the atomic unit of the system — composable, reusable, and invocable standalone.

Each skill file defines:
- **Trigger**: the slash command name
- **Inputs**: what the user must provide
- **Procedure**: step-by-step process the agent follows
- **Output format**: what the deliverable looks like
- **Legal/procedural references**: which TFEU articles, Better Regulation tools, or EU templates apply

### Skill catalog

| Skill | Output | Key reference |
|---|---|---|
| `impact-assessment` | Staff Working Document (SWD) | Better Regulation Toolbox |
| `legislative-proposal` | Draft regulation or directive | OLP template, TFEU Art. 294 |
| `treaty-check` | Legal opinion | TFEU, subsidiarity protocol |
| `consultation` | Consultation summary | Better Regulation guidelines |
| `state-aid-review` | Compatibility decision | TFEU Art. 107-109 |
| `comitology` | Committee opinion | Regulation 182/2011 |
| `infringement` | Reasoned opinion draft | TFEU Art. 258 |
| `sdg-alignment` | SDG mapping | UN 2030 Agenda |
| `better-regulation` | Regulatory fitness check | REFIT platform |
| `review` | Evaluation report | SWD evaluation template |

---

## Layer 2 — Commissioners

Commissioner agents are **persona-bound political agents**. Each holds a portfolio derived from the treaties, has a defined set of dossiers, a decision-making style, and known tensions with other portfolios.

### Commissioner agent file structure

```markdown
# Commissioner for [Portfolio]

## Mandate
[Treaty basis, scope of competence, key regulations administered]

## Political priorities
[Current strategic objectives, links to Commission Work Programme]

## Decision style
[How this commissioner weighs trade-offs: precautionary vs. market-driven,
centralist vs. subsidiarity-oriented, etc.]

## Key dossiers
[Active legislative files, ongoing enforcement actions]

## Tensions with other portfolios
[Where this portfolio structurally conflicts with others and why]

## DG
[Which Directorate-General provides technical support]

## Agent behavior
[Specific instructions for how this agent should respond]
```

### The College hierarchy

```
President
├── Executive Vice-President — Green Deal & Climate
├── Executive Vice-President — Digital & Tech Sovereignty
├── Executive Vice-President — Economy & Productivity
├── Executive Vice-President — Democracy, Justice & Rule of Law
│
├── Commissioner — Internal Market & Industry
├── Commissioner — Competition
├── Commissioner — Trade
├── Commissioner — Agriculture & Food
├── Commissioner — Health & Food Safety
├── Commissioner — Home Affairs & Migration
├── High Representative — Foreign Affairs & Security Policy
├── Commissioner — Energy
├── Commissioner — Transport
├── Commissioner — Regional Development & Cohesion
├── Commissioner — Research & Innovation
├── Commissioner — Education, Youth & Culture
├── Commissioner — Employment & Social Rights
├── Commissioner — Budget & Administration
├── Commissioner — Environment & Oceans
└── Commissioner — Justice & Fundamental Rights
```

---

## Layer 3 — Directorate-Generals (DGs)

DG agents are **technical-analytical agents**. They do not hold political positions; they produce the analysis, legal framing, data synthesis, and options papers that Commissioner agents rely on.

A DG agent's output is always attributed: "DG COMP analysis shows…", "DG ENV assessment finds…". This mirrors the real Commission, where political decisions are distinct from technical preparation.

### DG-to-Commissioner mapping

| DG | Commissioner |
|---|---|
| DG COMP (Competition) | Commissioner for Competition |
| DG TRADE | Commissioner for Trade |
| DG AGRI | Commissioner for Agriculture |
| DG SANTE | Commissioner for Health |
| DG ENER | Commissioner for Energy |
| DG MOVE | Commissioner for Transport |
| DG REGIO | Commissioner for Regional Development |
| DG RTD | Commissioner for Research & Innovation |
| DG EMPL | Commissioner for Employment |
| DG BUDG | Commissioner for Budget |
| DG ENV | Commissioner for Environment |
| DG JUST | Commissioner for Justice |
| DG HOME | Commissioner for Home Affairs |
| DG GROW | Commissioner for Internal Market |
| DG TAXUD | Commissioner for Internal Market (taxation) |
| DG CONNECT | EVP for Digital |

---

## Layer 4 — Agents (multi-agent sessions)

Multi-agent sessions coordinate multiple Commissioner and DG agents in a defined procedure.

### College deliberation

The most important multi-agent session. Simulates the weekly College meeting where all Commissioners vote on proposals.

**Protocol:**
1. Rapporteur Commissioner presents the dossier (3 min).
2. Each Commissioner speaks once (1 min) — support, reservations, or opposition.
3. President identifies consensus or calls a formal vote.
4. Outcome: adopted, referred back, or withdrawn.

### Inter-service consultation (ISC)

When a lead DG prepares a proposal, it circulates to all affected DGs for written opinions. This agent session simulates that circulation:

1. Lead DG circulates draft.
2. Each affected DG returns a written opinion (agreement, reservations, opposition).
3. Lead DG produces a synthesis and revises the draft.
4. Second round if needed.

### Trilogue

Simulates the informal inter-institutional negotiation between Commission, Parliament (rapporteur + shadow rapporteurs), and Council (Presidency + member state delegations):

1. Commission defends its proposal.
2. Parliament presents its amendments.
3. Council presents its general approach.
4. Rounds of compromise text negotiation.
5. Political agreement or breakdown.

### Task force

Ad-hoc multi-DG working group convened by the President or an EVP for cross-cutting issues (e.g., AI governance cutting across CONNECT, COMP, JUST, HOME).

---

## Layer 5 — Institutions

Counter-party agents representing EU bodies outside the Commission. They receive Commission proposals and respond according to their institutional role and political dynamics.

| Institution | Role in the system |
|---|---|
| European Parliament | Amends legislation, holds democratic accountability |
| Council of the EU | Represents member states, adopts legislation jointly with EP |
| European Council | Sets strategic direction, no legislative function |
| Court of Justice (ECJ) | Rules on legality, interprets treaties |
| European Central Bank | Monetary policy, consulted on financial legislation |
| EEAS | External relations, implements foreign policy |

---

## Data flow for a legislative proposal

```
User brief
    │
    ▼
/legislative-proposal skill
    │
    ├── DG (lead) produces technical options paper
    │
    ├── /impact-assessment skill runs on preferred option
    │
    ├── /treaty-check skill validates legal basis
    │
    ├── /consultation skill simulates stakeholder round
    │
    ├── /inter-service-consultation circulates to all DGs
    │
    ├── Lead Commissioner endorses and signs
    │
    ├── /college-deliberate votes on adoption
    │
    └── OUTPUT: draft legislative text (regulation/directive)
              + explanatory memorandum
              + impact assessment SWD
              + consultation summary
```

---

## Extension guide

### Adding a commissioner
1. Copy `knowledge/commissioners/_template.md`.
2. Fill in mandate, legal basis, priorities, tensions.
3. Add to the roster in `knowledge/agents/college-deliberation.md`.
4. Link to the corresponding DG file in `knowledge/dgs/`.

### Adding a skill
1. Create `plugins/<domain>/skills/<skill-name>/SKILL.md` using the SKILL.md frontmatter convention.
2. Define: trigger, inputs, step-by-step procedure, output format.
3. Cite the EU procedure or legal instrument it models.
4. Register the skill name in `plugins/<domain>/.claude-plugin/plugin.json`.

### Adding a workflow
1. Create `knowledge/workflows/my-workflow.md`.
2. Define the sequence of skills and agents to invoke, with data passed between steps.
3. Note any decision gates (e.g., College must adopt before proceeding).

### Adding an institution
1. Create `knowledge/institutions/my-institution.md`.
2. Define: treaty role, decision procedure, political dynamics, how it receives Commission input.

---

## Design decisions

**Why model DGs separately from Commissioners?**
The real Commission separates political direction (Commissioner) from technical administration (DG). A Commissioner can override their DG's recommendation — that tension is interesting and productive. Conflating them loses it.

**Why follow real EU procedures?**
Procedural fidelity is what makes the outputs useful. A "legislative proposal" that skips the impact assessment and subsidiarity check is not an EU legislative proposal. The constraints are features, not friction.

**Why adversarial by design?**
The Commission's college system requires unanimity or qualified majority. That means dissent matters. A system that always converges to agreement misses the entire point of collegiate governance.

**Why no LLM orchestration framework (LangChain, CrewAI…)?**
The system is built as markdown prompts consumed by Claude Code. This keeps it lightweight, inspectable, and version-controllable. Orchestration happens through Claude's native multi-agent capabilities (subagents, MCP). If the project grows, a TypeScript orchestration layer can be added without changing the agent definitions.
