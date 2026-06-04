# Verification checklists

Each module proves it works with a five-part check (mirrors the vault success criteria). Fill the results as each module is built.

| Part | What it proves |
|------|----------------|
| Existence | Object exists — catalog views (`sys.databases`, `sys.partitions`, `sys.security_policies`, `sys.dm_database_encryption_keys`). |
| Behavior | Feature actually works — RLS rows differ per user; plan shows partition elimination; FG fails over. |
| Negative | Controls block what they should — unauthorized user denied; masked column hidden. |
| Artifact | Script saved in the right `modules/<M>/` folder with its header block. |
| Teardown | Any paid resource deleted and logged in the vault Cost Tracker. |

## Per-module results

- **M1** — _(pending)_
- **M1B** — _(pending — closes PI-01a, PI-01b)_
- **M2** — _(pending — closes PI-02)_
- **M3** — _(pending)_
- **M4** — _(pending)_
- **M5** — _(pending)_

Capstone is complete only when every module passes here, every flag in the vault registry is Closed (verified), and the L22 mock ≥ 700.
