# Using the EU Skills Plugins — Beginner's Guide

This guide is for European Commission staff (or people learning EU institutional
work) who want to use the skill plugins in this repository. No technical
background is needed. You do not need to understand how AI works.

---

## What this system is

Each **skill** in this repository is a specialist assistant trained to do one
specific job that a Commission official does: draft a legislative text, calculate
a dumping margin, write a CDR objective, respond to a Parliamentary Question.

The skills know EU law, Commission procedures, and the specific formats those
documents take. They produce structured first drafts — faster than starting
from a blank page — with built-in reminders about what needs human review
before anything is used officially.

**Important: every output is a draft.** The system never produces a final
document. It produces a structured starting point for a human official to
review, correct, and take responsibility for. This is by design.

---

## The six skill packages

| Package | Who it is for | What it covers |
|---|---|---|
| **legislative-eu** | Policy officers, legislative drafters, SecGen lawyers | Briefing notes, regulations, ISC contributions, PQ responses, trilogue, impact assessment, consultation, REFIT |
| **competition-eu** | DG COMP lawyers, Legal Service lawyers | Antitrust analysis, state aid (four-limb test, GBER, compatibility), legal opinions, market definition |
| **institutional-management-eu** | Heads of Unit, assistants, HR officers, financial officers | CDR appraisals, ARES workflow, ABAC, contracts, pensions |
| **trade-eu** | DG TRADE investigators | Anti-dumping/anti-subsidy investigations, dumping margins, injury analysis |
| **grants-enforcement-eu** | Grant managers, infringement officers, procurement officers | Horizon Europe grants, Letters of Formal Notice, transposition tracking, infringement assessment |
| **data-communication-eu** | Data analysts, communication officers | Eurostat data notes, press releases, speeches, lines to take |

Each package lives under `plugins/<package-name>/` in the repository. EU
institutional knowledge (Commissioner personas, DG profiles, institutions) is
under `knowledge/`. Shared hook scripts are under `lib/hooks/`.

---

## How a session works

Every session has the same three steps:

```
1. Install the right package
2. Run the cold-start interview (2 minutes)
3. Use the skill
```

That is all. The rest of this guide explains each step with a concrete example.

---

## Core concepts you need to know

### Two types of skill: roles and workflow tools

Skills come in two flavours:

**Role skills** are broad personas — they cover a job function. `/policy-officer`
can draft a briefing note, a negotiating brief, or an ISC contribution. They are
good for open-ended work where you are not sure of the exact output format.

**Workflow skills** are narrow task tools — they produce one specific output
following a defined procedure. `/impact-assessment` produces a SWD following the
Better Regulation methodology. `/treaty-check` produces a legal opinion on legal
basis, subsidiarity, proportionality, and Charter rights. `/infringement` produces
a structured Art. 258 TFEU case assessment. They are good when you know exactly
what document you need.

When in doubt: start with the role skill, then switch to the workflow skill once
you know what output you need.

### Skills are specialists, not generalists

Each skill knows one domain deeply. `/lawyer-legal-service` knows CJEU litigation
and treaty interpretation. `/pq-responder` knows how to draft a Parliamentary
Question response. They do not know each other's domains.

If your task crosses domains — for example, a legal opinion that requires
statistical data — use two skills in sequence: first `/data-analyst` to get the
data note, then `/lawyer-legal-service` to draft the opinion using that data.

### The cold-start interview personalises the output

Before you use any skill, you run `/cold-start-interview`. It asks you 6–7
questions: which DG you are in, what your current dossier is, what language
you need, how sensitive the work is. The answers go into the package's practice
profile and shape every output you get in that session.

Without the cold-start interview, the skill will still work, but the outputs
will use generic defaults instead of your specific context.

### Trust tags tell you what to verify

Every output contains inline tags. These are not decoration — they are
instructions. They tell you exactly which parts of the output you need to check
before using it.

| Tag | What it means | What you should do |
|---|---|---|
| `[EUR-Lex — verify current version]` | The cited regulation or directive text came from training data, not a live retrieval | Open EUR-Lex and confirm the article still reads as quoted |
| `[CJEU — verify Curia reference]` | A case name and number were cited from training data | Check the case exists and the citation is accurate on curia.europa.eu |
| `[model knowledge — verify]` | A figure, date, or fact was generated from training data | Cross-check against the primary source before using |
| `[review — legal uncertainty]` | The law on this point is unsettled or contested | Get a second opinion; consider Legal Service consultation |
| `[review — political judgement required]` | This is a policy call, not a legal deduction | A human official needs to make this decision |
| `[review — cleared lines required]` | This communication has not been through the clearance chain | Do not send externally until cleared |

### Every output ends with a DRAFT notice

```
---
DRAFT — For review by an EU official before use. Not an official Commission position.
```

This is not a formality. It is a reminder that the document has legal and
institutional consequences only when a human official takes responsibility for it.

---

## Step-by-step example: responding to a personal data request

### The scenario

You are a legal officer at **DG GROW** (Internal Market, Industry,
Entrepreneurship and SMEs). A staff member from another DG — DG EMPL — has
submitted a formal **Subject Access Request** under **Regulation (EU) 2018/1725**
(the data protection regulation for EU institutions, equivalent to the GDPR).

The request asks:
> "I request access to all personal data held about me by DG GROW, including
> data relating to a procurement evaluation in which I participated as an
> external evaluator in 2023."

You need to draft DG GROW's formal reply.

The reply must:
- Identify what data is held
- Apply the access rights under Regulation 2018/1725 (Art. 17)
- Note any exceptions that may apply (Art. 25 — limitations on access rights)
- Be sent within **one month** (Art. 12(3) of Regulation 2018/1725)
- Be cleared by DG GROW's Data Protection Officer (DPO) before sending

---

### Step 1: Install the right package

This task is legal work — drafting a formal reply based on a specific legal
framework (Regulation 2018/1725). The right package is **`competition-eu`**
because it contains the `lawyer-legal-service` skill, which handles legal
analysis and formal legal documents.

In Claude Code:

```
/plugin install competition-eu
```

---

### Step 2: Run the cold-start interview

```
/cold-start-interview
```

The interview will ask you several questions. Here is how to answer them for
this scenario:

> **"Which DG and unit are you in?"**
> DG GROW — Legal Affairs unit

> **"What type of work are you doing?"**
> Legal analysis and drafting — not a competition case; a data protection
> response under Regulation 2018/1725

> **"What is the case reference or dossier name?"**
> Subject Access Request from [DG EMPL staff member] — received [date]

> **"What stage is the case or opinion at?"**
> Initial assessment — need to draft the formal reply

> **"What is the confidentiality level?"**
> NORMALE for the reply itself; the underlying personal data is sensitive

> **"What language do you need?"**
> English

The interview writes these answers into the package's practice profile. Every
output in this session will be calibrated to: DG GROW, data protection reply,
Regulation 2018/1725.

---

### Step 3: Use the skill

You now invoke the `lawyer-legal-service` skill with your specific request:

```
/lawyer-legal-service

A staff member from DG EMPL has submitted a Subject Access Request under
Regulation (EU) 2018/1725. They are requesting access to all personal data
held by DG GROW relating to their participation as an external evaluator in
a 2023 procurement procedure.

I need:
1. A legal assessment of our obligations under Regulation 2018/1725
2. An identification of what categories of data are likely held
3. A draft formal reply to the data subject
4. A note on any applicable exceptions (Art. 25) and whether they apply here
```

---

### Step 4: Read the output

The skill produces a structured output. Here is what a realistic output looks like:

---

```
LEGAL ASSESSMENT — SUBJECT ACCESS REQUEST
Regulation (EU) 2018/1725 of the European Parliament and of the Council
[EUR-Lex — verify current version: OJ L 295, 21.11.2018, p. 39]

DG / Unit:    DG GROW — Legal Affairs
Request type: Subject Access Request — Art. 17 Regulation 2018/1725
Deadline:     One month from receipt (Art. 12(3)) — extendable to three months
              for complex or numerous requests (Art. 12(4))
DPO consultation: Required before sending — flag to DPO immediately

─────────────────────────────────────────────────────────
I. LEGAL OBLIGATIONS UNDER REGULATION 2018/1725
─────────────────────────────────────────────────────────

Article 17 of Regulation 2018/1725 [EUR-Lex — verify current version] gives the
data subject the right to obtain from the controller:

(a) confirmation of whether personal data concerning them is being processed;
(b) access to that personal data; and
(c) the information listed in Art. 17(2): the purpose of processing, the
    categories of data, the recipients or categories of recipient, the
    retention period, the existence of the rights to rectification, erasure,
    and restriction, and the right to lodge a complaint with the EDPS.

DG GROW is the controller for data processed in connection with procurement
procedures it conducts. The data subject has a right of access to their
personal data held in that capacity.

─────────────────────────────────────────────────────────
II. CATEGORIES OF DATA LIKELY HELD
─────────────────────────────────────────────────────────

For an external evaluator in a 2023 procurement procedure, DG GROW is likely
to hold the following categories of personal data:

1. Identity data: name, institutional affiliation, contact details
   (provided on registration as evaluator)

2. Conflict of interest declaration: signed declaration submitted before
   evaluation — this document contains personal data and is subject to
   the access right

3. Evaluation scores and individual comments: scores given by the evaluator
   on individual tender criteria — [review — legal uncertainty: see Section III]

4. Attendance and participation records: dates, meeting records

5. Correspondence: emails or formal communications with the evaluator

6. Contractual documents: if the evaluator was remunerated, any contract
   or reimbursement claim will contain financial personal data

─────────────────────────────────────────────────────────
III. APPLICABLE EXCEPTION — ART. 25(1)(c): PROTECTION OF OTHERS' DATA
─────────────────────────────────────────────────────────

[review — legal uncertainty: this is the central legal question in this request]

Article 25(1)(c) of Regulation 2018/1725 [EUR-Lex — verify current version]
permits restriction of the access right where it is necessary to protect
"the rights and freedoms of others."

EVALUATION SCORES AND COMMENTS: The evaluation report will typically contain
the scores and comments of all evaluators collectively. Disclosing the individual
scores of the requesting evaluator may also reveal, or allow inference about,
the scores of other evaluators, thereby disclosing their personal data.

Assessment: DG GROW may restrict access to the collective evaluation report
under Art. 25(1)(c) if disclosure would reveal the individual assessments of
other evaluators. However, DG GROW should provide access to the requesting
evaluator's own scores and comments (those attributable solely to them) where
these can be separated.

[review — legal uncertainty: the EDPS has issued guidance on this balance;
consult DPO and check EDPS Decision on access to evaluation documents
[model knowledge — verify against current EDPS guidance]]

OTHER CATEGORIES: No exception appears to apply to identity data, conflict of
interest declarations, attendance records, and correspondence. These should
be disclosed in full.

─────────────────────────────────────────────────────────
IV. DRAFT FORMAL REPLY
─────────────────────────────────────────────────────────

[DG GROW letterhead]
[Reference: ARES(20XX)XXXXXXX]
[Classification: NORMALE]

[City], [DD Month YYYY]

Subject: Reply to your Subject Access Request under Regulation (EU) 2018/1725

Dear [Name],

DG GROW acknowledges receipt of your Subject Access Request dated [date],
received on [date of receipt]. This reply is provided in accordance with
Article 17 of Regulation (EU) 2018/1725 [EUR-Lex — verify current version].

1. PERSONAL DATA HELD BY DG GROW

DG GROW has identified the following categories of personal data held in
connection with your participation as an external evaluator in procurement
procedure [reference / description], conducted in [year]:

  — Your name, institutional affiliation, and contact details, as provided
    at registration;
  — Your signed conflict of interest declaration dated [date];
  — Records of your attendance and participation in the evaluation sessions
    on [dates];
  — Your individual evaluation scores and written comments on the tenders
    evaluated, to the extent these are separately identifiable as your own;
  — Correspondence exchanged between you and DG GROW in connection with
    the procedure.

Copies of these documents are enclosed / available upon request [choose].

2. PARTIAL RESTRICTION UNDER ARTICLE 25(1)(c)

Access to [the full collective evaluation report / specific document] is
partially restricted under Article 25(1)(c) of Regulation (EU) 2018/1725,
as disclosure of [specify the specific parts] would reveal personal data
of other evaluators who participated in the same procedure.

DG GROW has provided you with the portions of the evaluation documentation
that contain exclusively your own assessments. The restricted portions
relate solely to the assessments of other individuals and do not affect
your right of access to your own data.

3. YOUR FURTHER RIGHTS

You have the right to:
  — Request rectification of inaccurate personal data (Art. 18);
  — Request erasure of data no longer necessary (Art. 19);
  — Lodge a complaint with the European Data Protection Supervisor (EDPS)
    at edps.europa.eu if you consider that the processing of your personal
    data does not comply with Regulation 2018/1725.

4. CONTACT

For any questions regarding this reply or the processing of your personal data
by DG GROW, please contact: [DG GROW DPO contact details].

Yours sincerely,

[Name]
[Title]
DG GROW — [Unit]
On behalf of the Data Controller

─────────────────────────────────────────────────────────
V. ACTIONS BEFORE SENDING
─────────────────────────────────────────────────────────

□ DPO consultation — mandatory before sending; DPO must confirm the Art. 25
  restriction is correctly applied [review — DPO clearance required]
□ Attach or make available the identified data (see Section I categories)
□ Redact other evaluators' data from any shared documents before enclosing
□ Record the reply in ARES with ARES reference
□ Note the one-month deadline: reply must be sent by [calculate date]

[EUR-Lex — verify current version of Regulation 2018/1725]
[model knowledge — verify: check current EDPS guidance on access to
evaluation documents and any relevant EDPS decisions on Art. 25(1)(c)]
[review — legal uncertainty: the partial restriction analysis should be
confirmed with DPO before relying on it]

---
DRAFT — For review by DG GROW's DPO and the responsible legal officer before
sending to the data subject. Not an official Commission position.
```

---

### Step 5: What to do with the output

The skill has produced:
- A legal analysis of your obligations (Section I)
- A list of the data categories you are likely holding (Section II)
- An analysis of whether an exception applies and why (Section III)
- A complete draft reply ready to populate with the real details (Section IV)
- A pre-send checklist (Section V)

**Your work now is:**

1. **Fill in the placeholders** in the draft reply — `[date]`, `[reference]`,
   `[DG GROW DPO contact]`, and so on

2. **Check the trust tags:**
   - `[EUR-Lex — verify current version]` appears on the Regulation citation.
     Open EUR-Lex and confirm Regulation 2018/1725 still contains the articles
     as described. Regulations can be amended.
   - `[model knowledge — verify]` appears on the EDPS guidance reference.
     Search the EDPS website for any decisions or guidance on Art. 25(1)(c)
     and evaluation documents.
   - `[review — legal uncertainty]` appears on the partial restriction analysis.
     This is the hardest legal question in the file. Do not rely on the draft
     analysis without the DPO's view.

3. **Send the draft to your DPO** — the DPO's clearance is flagged as
   mandatory in the output. Do not send the reply to the data subject without it.

4. **Register in ARES** — the draft reminds you to register the reply with an
   ARES reference.

---

---

## Second example: using a workflow skill directly

The previous example used a role skill (`/lawyer-legal-service`). This example
shows how a **workflow skill** works differently — it follows a fixed procedure
and always produces the same output structure, regardless of what you ask.

### The scenario

You are a policy officer at DG ENV preparing the Better Regulation package for
a new directive on industrial water reuse. The proposal is at the options-analysis
stage and you need to produce the impact assessment SWD.

### Using `/impact-assessment` directly

Workflow skills do not need a long prompt — they run a defined procedure on
whatever brief you give them:

```
/impact-assessment

Policy brief: The Commission is considering a directive requiring industrial
operators with water discharge above 10,000 m³/year to implement closed-loop
water recycling systems. The objective is to reduce industrial freshwater
abstraction by 30% by 2035 in water-stressed regions (currently affecting 11
member states). The legal basis is proposed as Art. 192 TFEU (environment).
```

The skill will run all eight workflow steps automatically:

1. Problem definition + subsidiarity
2. Baseline (business as usual)
3. Objectives (general/specific/operational)
4. Policy options (Option 0 → Option 3+)
5. Impact analysis — economic, social, environmental for each option
6. Comparison matrix
7. Preferred option with proportionality statement
8. Monitoring framework

You do not need to ask for each step separately. The output will be the full
SWD structure, with trust tags on every data figure and a pre-submission
quality checklist at the end.

### When to use `/impact-assessment` vs `/impact-assessment-analyst`

| | `/impact-assessment` | `/impact-assessment-analyst` |
|---|---|---|
| Type | Workflow — fixed procedure | Role — open-ended |
| Output | Always: full SWD structure | Depends on what you ask |
| Best for | When you need the complete document | When you need analysis of one step (e.g., just the SME test, just the comparison matrix) |

---

## Other tasks you can do with the same package

Once your cold-start interview has set the competition-eu context, you can
continue the same session with related tasks without re-interviewing:

```
/lawyer-legal-service

The data subject has now replied to our letter asking for clarification on
why the collective evaluation report was partially withheld. They are
threatening to file a complaint with the EDPS. Draft a holding response and
assess whether we should proactively share more of the evaluation report.
```

Or:

```
/lawyer-legal-service

Separately, DG GROW's DPO has asked whether the retention period for external
evaluator data is correctly set. Currently we retain the data for 5 years after
the procedure. Is this consistent with Regulation 2018/1725 and the applicable
procurement record-keeping rules?
```

The skill will handle follow-up questions within the same session, building
on the context already set.

---

## Common mistakes and how to avoid them

### "I skipped the cold-start interview"

You can. The skill will still produce an output. But it will not know your DG,
your specific document, or your sensitivity level. The output will be more
generic and will need more editing. Run the interview — it takes two minutes
and saves much more time in editing.

### "The output said something I know is wrong"

This is why trust tags exist. The skill drew on training data that may be
outdated. Any citation tagged `[EUR-Lex — verify]` or `[model knowledge — verify]`
must be checked against the live source. The skill gives you the structure and
the legal reasoning; you verify the specific provisions.

### "The skill answered a slightly different question"

Rephrase your request more specifically. Skills respond to what you ask.
If you want a formal reply letter and not a legal analysis, say "draft the
formal reply letter" not "help me with this data request." The more specific
your instruction, the more targeted the output.

### "The skill used GDPR terminology, not Regulation 2018/1725"

EU institutions are not governed by GDPR (Regulation 2016/679). They are governed
by **Regulation (EU) 2018/1725**, which is the institutions-specific equivalent.
If the output uses GDPR instead of Regulation 2018/1725, correct it explicitly:

```
Note: the applicable regulation is Regulation (EU) 2018/1725, not GDPR
(Regulation 2016/679). GDPR applies to member state authorities; Regulation
2018/1725 applies to EU institutions. Please revise the analysis accordingly.
```

### "I don't know which package to use"

Use this quick-decision question: *What kind of official would normally do this task?*

- A DG COMP or Legal Service lawyer → `competition-eu`
- A policy officer working on a legislative file → `legislative-eu`
- A Head of Unit or HR officer → `institutional-management-eu`
- A DG TRADE investigator → `trade-eu`
- A grant manager or infringement officer → `grants-enforcement-eu`
- A data analyst or press officer → `data-communication-eu`

If in doubt, `legislative-eu` with `policy-officer` is the closest to a generalist
Commission policy function.

---

## Quick reference: skills in each package

### `legislative-eu`
| Skill | Type | Use for |
|---|---|---|
| `/policy-officer` | Role | Briefing notes, negotiating briefs, options papers |
| `/legislative-drafter` | Role | Regulations, directives, decisions |
| `/lawyer-secgen` | Role | ISC legal quality review, subsidiarity check |
| `/comitology-officer` | Role | Delegated/implementing acts |
| `/impact-assessment-analyst` | Role | Better Regulation impact assessments (broad analysis) |
| `/economist` | Role | Economic analysis, market failure, CBA |
| `/isc-contributor` | Workflow | ISC opinions with textual amendments — Agreement / Reservations / Opposition |
| `/pq-responder` | Workflow | EP Parliamentary Question responses (Rules 138/139) |
| `/subsidiarity-checker` | Workflow | Art. 5 TEU subsidiarity and proportionality test with Protocol No. 2 risk |
| `/trilogue-position-tracker` | Workflow | Four-column document, pre-round mandate briefs |
| `/impact-assessment` | Workflow | Full SWD — problem definition, options, CBA, SME test, DNSH, matrix |
| `/legislative-proposal` | Workflow | Complete regulation or directive — legal basis, recitals, operative articles, EM |
| `/treaty-check` | Workflow | Legal basis, subsidiarity, proportionality, Charter rights — mirrors CLS check |
| `/better-regulation` | Workflow | REFIT fitness check — five criteria, overall score, simplification opportunities |
| `/consultation` | Workflow | Simulate or draft a 12-week public consultation with stakeholder synthesis |

### `competition-eu`
| Skill | Type | Use for |
|---|---|---|
| `/lawyer-competition-antitrust` | Role | Arts. 101–102 TFEU analysis, fines, dawn raids |
| `/lawyer-state-aid` | Role | Four-limb test, GBER, recovery |
| `/lawyer-legal-service` | Role | Legal opinions, litigation, Written Observations |
| `/gber-screener` | Workflow | Pre-screen a measure against GBER conditions — all chapters |
| `/market-definer` | Workflow | Relevant market definition — SSNIP test, demand/supply substitutability |
| `/state-aid-review` | Workflow | Full Art. 107(1) four-limb test → de minimis → GBER → compatibility |

### `institutional-management-eu`
| Skill | Type | Use for |
|---|---|---|
| `/head-of-unit` | Role | Work programme, CDR, staff management |
| `/deputy-head-of-unit` | Role | Quality review, deadline tracking, A.I. acting |
| `/assistant-hod` | Role | ARES, missions, SYSPER, action trackers |
| `/hr-contract-manager-ta` | Role | TA/CA contracts, renewals |
| `/financial-officer` | Role | ABAC commitments, payment orders |
| `/pmo-pension-specialist` | Role | Annex VIII pension calculations |
| `/cdr-drafter` | Workflow | SMART CDR objectives and end-year appraisal narratives |

### `grants-enforcement-eu`
| Skill | Type | Use for |
|---|---|---|
| `/grant-manager` | Role | Horizon Europe MGA, payments, corrections |
| `/infringement-officer` | Role | Art. 258 procedure — EU Pilot, LFN, RO, ECJ referral |
| `/procurement-expert` | Role | FR 2018/1046 procurement |
| `/lfn-drafter` | Workflow | Draft Letters of Formal Notice — non-transposition / incorrect transposition |
| `/transposition-tracker` | Workflow | 27-MS transposition status table, conformity assessment, escalation |
| `/infringement` | Workflow | Art. 258–260 TFEU case assessment — type classification, procedural stage, penalty estimate |

### `data-communication-eu`
| Skill | Type | Use for |
|---|---|---|
| `/data-analyst` | Role | Eurostat data, indicators, scoreboards |
| `/communication-officer` | Role | Press releases, speeches, social media |
| `/lines-to-take-drafter` | Workflow | Full Q&A package for press conferences and Commissioner hearings |

---

## Where to go next

- [QUICKSTART.md](../QUICKSTART.md) — technical installation steps
- [CONTRIBUTING.md](../CONTRIBUTING.md) — how to add a skill or extend a package
- [CONNECTORS.md](../CONNECTORS.md) — connect live EU data sources (Eurostat, EUR-Lex, TED)
- [docs/glossary.md](glossary.md) — EU terminology reference
