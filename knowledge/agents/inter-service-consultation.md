# Agent: Inter-Service Consultation (ISC)

**Trigger:** `/inter-service-consultation <proposal>`
**Output:** ISC synthesis — DG opinions + revised draft

---

## What this agent does

Simulates the mandatory inter-service consultation through which a lead DG circulates its draft legislative proposal or policy document to all affected DGs for written opinions. This is the internal Commission quality control step before a proposal goes to the College.

---

## Protocol

### Step 1 — Circulation by lead DG (Day 0)
Lead DG circulates:
- Draft legislative text (or policy communication)
- Draft Impact Assessment (SWD)
- Draft explanatory memorandum
- Cover note specifying: consultation deadline (typically 4 weeks), decision sought.

### Step 2 — DG opinions (Days 1-28)

Each DG with a stake in the file submits a written opinion. Format:
- **Agreement:** No substantive comments; draft can proceed.
- **Agreement with comments:** Support the initiative but flag specific issues (legal, technical, policy) that should be addressed.
- **Reservations:** Significant concerns that must be addressed before the proposal can proceed.
- **Opposition:** Fundamental objection to the proposal or a core element; blocks progress.

DGs to be consulted (select relevant ones based on the dossier):

| DG | Consulted when proposal touches… |
|---|---|
| DG COMP | Competition, state aid, market structure |
| DG TRADE | International trade, WTO compatibility |
| DG AGRI | Food, agriculture, rural development |
| DG SANTE | Health, food safety, chemicals |
| DG ENER | Energy, decarbonisation |
| DG MOVE | Transport, mobility |
| DG REGIO | Regional development, cohesion |
| DG RTD | Research, innovation, space |
| DG EMPL | Employment, social rights, ESF+ |
| DG BUDG | Budget implications (financial statement) |
| DG ENV | Environment, biodiversity, DNSH |
| DG JUST | Fundamental rights, data protection, consumer rights |
| DG HOME | Migration, security, border management |
| DG GROW | Internal market, industry, SMEs |
| DG TAXUD | Taxation, customs |
| DG CONNECT | Digital, telecom, data |
| Legal Service | Legal basis, treaty compatibility (mandatory) |
| Secretariat-General | Better Regulation compliance (mandatory) |

### Step 3 — Lead DG synthesis (Days 29-35)

Lead DG produces a synthesis note:
- Summary of all opinions received.
- Points of agreement.
- Issues raised and how they are addressed in the revised draft.
- Reservations outstanding: which ones and what is the lead DG's position.
- Opposition: if any DG maintains opposition, it is flagged to the EVP/President.

### Step 4 — Second round (if reservations outstanding)

If DGs maintain reservations after seeing the revised draft:
- Bilateral meeting between lead DG and objecting DG.
- EVP coordinates if political-level resolution needed.
- If resolved → ISC closed. If unresolved → escalated to College.

---

## Output format

```
INTER-SERVICE CONSULTATION — SYNTHESIS NOTE

Dossier: [title]
Lead DG: [DG name]
Reference: [ISC number]
Circulation date: [date]
Deadline: [date]

OPINIONS RECEIVED:

DG [name]: [Agreement / Agreement with comments / Reservations / Opposition]
Key points: [summary]

[...for each DG consulted]

LEGAL SERVICE: [Opinion — mandatory]
[Legal basis confirmed / Legal concerns raised]

SECRETARIAT-GENERAL: [Better Regulation compliance check]
[Compliant / Issues with IA / Consultation gaps]

SYNTHESIS:

Points of agreement: [summary]

Issues addressed in revised draft:
- [Issue raised by DG X] → [How addressed]
- [...]

Outstanding reservations:
- [DG X]: [Issue] — [Lead DG response]

Opposition maintained:
- [DG X if any]: [Issue] — [Escalation to EVP/President]

CONCLUSION:
[ISC closed — proposal ready for College / Second round needed / Escalated to EVP]

REVISED DRAFT: [attached / will follow by date]
```
