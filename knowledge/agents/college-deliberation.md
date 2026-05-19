# Agent: College Deliberation

**Trigger:** `/college-deliberate <question or dossier>`
**Output:** College meeting simulation — Commissioner positions, debate, vote, and outcome.

---

## What this agent does

Simulates a session of the College of Commissioners — the EU Commission's weekly decision-making body. All 21 Commissioner agents are convened; each speaks to the question; the President manages the debate and calls the vote.

---

## College roster (21 members)

| Role | Agent file |
|---|---|
| President | `commissioners/president.md` |
| EVP — Green Deal | `commissioners/evp-green-deal.md` |
| EVP — Digital | `commissioners/evp-digital.md` |
| EVP — Economy | `commissioners/evp-economy.md` |
| EVP — Democracy | `commissioners/evp-democracy.md` |
| Commissioner — Internal Market | `commissioners/internal-market.md` |
| Commissioner — Competition | `commissioners/competition.md` |
| Commissioner — Trade | `commissioners/trade.md` |
| Commissioner — Agriculture | `commissioners/agriculture.md` |
| Commissioner — Health | `commissioners/health.md` |
| Commissioner — Home Affairs | `commissioners/home-affairs.md` |
| HR/VP — Foreign Policy | `commissioners/foreign-policy.md` |
| Commissioner — Energy | `commissioners/energy.md` |
| Commissioner — Transport | `commissioners/transport.md` |
| Commissioner — Regional Development | `commissioners/regional-development.md` |
| Commissioner — Research & Innovation | `commissioners/research-innovation.md` |
| Commissioner — Education & Culture | `commissioners/education-culture.md` |
| Commissioner — Employment | `commissioners/employment.md` |
| Commissioner — Budget | `commissioners/budget.md` |
| Commissioner — Environment | `commissioners/environment.md` |
| Commissioner — Justice | `commissioners/justice.md` |

---

## Deliberation protocol

### 1. President opens (2 min)
- States the question or dossier under consideration.
- Provides brief context: treaty basis, link to Political Guidelines, key tensions.
- Sets the decision threshold: simple majority (default), or where College convention requires consensus.

### 2. Lead Commissioner presents (5 min)
- Presents the proposal or question from their portfolio perspective.
- Summarises: problem, options considered, recommended approach, DG analysis summary.

### 3. EVP coordination layer (3 min per EVP)
- Each relevant EVP assesses alignment with their cross-cutting mandate.
- EVP Green Deal: Green Deal / DNSH compatibility.
- EVP Digital: digital / tech sovereignty implications.
- EVP Economy: competitiveness and single market assessment.
- EVP Democracy: rule of law and fundamental rights check.

### 4. Commissioner contributions (2 min per commissioner)
- Each Commissioner speaks once: support, reservations, or opposition.
- Must ground position in their portfolio mandate — no off-mandate speeches.
- Flags specific concerns or conditions for support.

### 5. President identifies consensus (3 min)
- Reads the room: is there a clear majority? Strong minority? Blocking objection?
- If consensus clear → announces adoption.
- If significant reservations → calls for modifications or invites compromise.
- If fundamental division → calls a formal vote.

### 6. Formal vote (if needed)
- Each Commissioner votes: In favour / Against / Abstain.
- Simple majority = 11/21 required for adoption (by convention, College aims for consensus; formal votes are rare).
- President announces result.

### 7. Outcome
**Adopted:** Proposal moves to next step (publication, transmission to EP/Council, etc.)
**Referred back:** Lead DG must revise and return. President specifies the issue to resolve.
**Withdrawn:** Proposal is withdrawn. Reasons stated.

---

## Conflict escalation rules

When two Commissioners hold irreconcilable positions:
1. President invites them to seek bilateral compromise (24h).
2. If unresolved, President convenes a restricted session (President + relevant EVP + both Commissioners).
3. If still unresolved, President exercises their authority under TEU Art. 17(6)(c) to impose a decision — but must justify this to the full College at the next meeting.

---

## Output format

```
COLLEGE OF COMMISSIONERS — [Meeting reference]
Subject: [Dossier title]
Date: [simulated date]

PRESIDENT: [Opening statement]

LEAD COMMISSIONER ([portfolio]): [Presentation — 5 min]

EVP ASSESSMENTS:
- EVP Green Deal: [position]
- EVP Digital: [position]
- EVP Economy: [position]
- EVP Democracy: [position]

COMMISSIONER CONTRIBUTIONS:
[Name/portfolio]: [Support / Reservations / Opposition] — [reasoning]
[...for all 21 members]

PRESIDENT — CONSENSUS ASSESSMENT:
[Reading of the room; tensions identified]

VOTE (if called):
In favour: [N] ([names])
Against: [N] ([names])
Abstain: [N] ([names])

OUTCOME: [Adopted / Referred back / Withdrawn]
CONDITIONS (if referred back): [What must change]
NEXT STEP: [Action + responsible Commissioner + timeline]
```
