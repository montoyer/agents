# Quickstart — agents-for-EU

Get the EU Commission skill plugins running in Claude Code in under 5 minutes.

---

## 1. Prerequisites

- [Claude Code](https://claude.ai/code) installed and authenticated
- Git (to clone the repository)

```bash
git clone https://github.com/EC-Skills-Library/agents-for-EU.git
cd agents-for-EU
```

---

## 2. Choose Your Plugin

| Plugin | Who it is for |
|---|---|
| `legislative-eu` | Policy officers, legislative drafters, SecGen lawyers, impact assessment analysts |
| `competition-eu` | DG COMP antitrust and state aid lawyers, Commission Legal Service lawyers |
| `institutional-management-eu` | Heads of Unit, Deputy HoUs, assistants, HR and financial officers |
| `trade-eu` | DG TRADE trade defence investigators |
| `grants-enforcement-eu` | Grant managers, infringement officers, procurement experts |
| `data-communication-eu` | Data analysts, communication officers |
| `simulation-eu` | Training, scenario planning, and policy stress-testing via multi-agent EU institutional simulation |

---

## 3. Install a Plugin

From Claude Code, install the plugin you need:

```
/plugin install legislative-eu
```

Or combine plugins for a full simulation workflow:

```
/plugin install legislative-eu
/plugin install simulation-eu
```

Or install all plugins at once:

```
/plugin install marketplace.json
```

To see what is available:

```
/plugin list
```

---

## 4. Run the Cold-Start Interview

Every plugin starts with a 2-minute personalisation interview. Run it first:

```
/cold-start-interview
```

You will be asked about your DG, active dossier, procedural stage, and working
language. Your answers are written into the practice profile and used by every
subsequent skill in the package.

---

## 5. Use a Skill

After the interview, invoke any skill by name:

```
/policy-officer       draft a briefing note for the Commissioner
/legislative-drafter  draft the regulation preamble
/lawyer-secgen        check subsidiarity on this proposal
/lawyer-state-aid     run the four-limb test on this measure
/infringement-officer draft a Letter of Formal Notice to Poland
/data-analyst         extract unemployment data from Eurostat for the scoreboard
```

For simulation skills (no cold-start needed):

```
/commissioner digital          speak as the Commissioner for Digital
/college-deliberation          run a full College vote on a dossier
/inter-service-consultation    route a proposal through all affected DGs
/trilogue                      simulate EP/Council/Commission negotiation rounds
/legislative-cycle             run the full OLP from proposal to adoption
```

---

## 6. Read the Output Trust Tags

Every skill output uses inline attribution tags. Check these before acting on any output:

| Tag | Meaning |
|---|---|
| `[EUR-Lex — verify current version]` | Verify the cited text is still current |
| `[CJEU — verify Curia reference]` | Check the case name and number on Curia |
| `[model knowledge — verify]` | This came from training data — cross-check a live source |
| `[Eurostat YYYY-MM — verify]` | Statistical data — check against latest Eurostat extraction |
| `[review — political judgement required]` | Requires an official to make the call |
| `[review — legal uncertainty]` | Law is unsettled — Legal Service consultation recommended |

Every output also ends with:
```
DRAFT — For review by an EU official before use. Not an official Commission position.
```

---

## 7. Connect EU Data Sources (optional)

For live data retrieval, configure the MCP connectors listed in [CONNECTORS.md](CONNECTORS.md).
Connectors enable real-time EUR-Lex text retrieval, Eurostat data extraction,
and TED procurement monitoring directly from within skills.

---

## Common First Tasks by Role

**Policy officer:**
```
/cold-start-interview
/policy-officer  draft a Commissioner briefing note on [dossier]
```

**Competition lawyer:**
```
/cold-start-interview
/lawyer-competition-antitrust  run the Art. 101 four-step assessment on [conduct]
```

**Head of Unit:**
```
/cold-start-interview
/head-of-unit  draft the weekly status note for [week]
```

**Trade defence investigator:**
```
/cold-start-interview
/trade-defence-investigator  calculate the dumping margin for [exporter]
```

**Infringement officer:**
```
/cold-start-interview
/infringement-officer  draft a Letter of Formal Notice to [member state] on [directive]
```

**Policy analyst running a simulation:**
```
/plugin install legislative-eu
/plugin install simulation-eu
/legislative-cycle  [brief: what the proposal is, legal basis, lead Commissioner]
```

Or step by step:
```
/impact-assessment       [policy brief]
/inter-service-consultation  [dossier summary]
/college-deliberation    [decision sought]
/trilogue                [dossier, EP mandate, Council GA]
```

---

## Questions and Issues

- Open an issue: [github.com/EC-Skills-Library/agents-for-EU/issues](https://github.com/EC-Skills-Library/agents-for-EU/issues)
- Read the contributing guide: [CONTRIBUTING.md](CONTRIBUTING.md)
- Full connector setup: [CONNECTORS.md](CONNECTORS.md)
