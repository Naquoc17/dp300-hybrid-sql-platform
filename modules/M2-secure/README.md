# M2 — Secure (Domain 2: L06–L09) — closes PI-02

⏳ Planned

---

## Planned Tasks

| Task | Level | Artifact | Mode |
|------|-------|----------|------|
| M2.1–M2.3 Entra auth + least privilege | L06 | `entra-auth.sql`, `least-privilege-roles.sql`, `authz-checks.sql` | HANDS-ON |
| M2.4 TDE verify | L07 | `tde-check.sql` | HANDS-ON |
| M2.5 Firewall rules | L07 | `firewall-rules.sql` | HANDS-ON |
| M2.6 Always Encrypted | L07 | `always-encrypted.sql` + `runbook-ae.md` | FLOW-ONLY |
| M2.7 Service/private endpoints | L07 | `runbook-endpoints.md` | FLOW-ONLY |
| M2.8 Data classification | L08 | `data-classification.sql` | HANDS-ON |
| M2.9 Auditing | L08 | `auditing.sql` | HANDS-ON |
| M2.10 CT + CDC | L08 | `ct-cdc.sql` | HANDS-ON |
| M2.11 Dynamic Data Masking | L08 | `ddm.sql` | HANDS-ON |
| M2.12 Ledger | L08 | `ledger.sql` | HANDS-ON |
| M2.13 RLS patient/doctor | L08 | `rls-patient-doctor.sql` | HANDS-ON (PI-02) |
| M2.14 Security consolidation | L09 | `verify-security-consolidation.sql` | HANDS-ON |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `entra-auth.sql` | ⏳ Planned | `CREATE USER FROM EXTERNAL PROVIDER` — no LOGIN needed | Run in SSMS against sqldb-cap | Entra user appears in `sys.database_principals` |
| `least-privilege-roles.sql` | ⏳ Planned | `ALTER ROLE db_datareader ADD MEMBER` for read-only analyst | Run in SSMS | User can SELECT but not INSERT/UPDATE; `HAS_PERMS_BY_NAME` confirms |
| `authz-checks.sql` | ⏳ Planned | Verify effective permissions per principal | Run in SSMS | `fn_my_permissions` / `sys.database_permissions` output |
| `tde-check.sql` | ⏳ Planned | Verify TDE is enabled (default in Azure SQL) | Run in SSMS | `sys.databases.is_encrypted = 1` |
| `firewall-rules.sql` | ⏳ Planned | Show server-level vs database-level firewall rules | Run in SSMS against master | `sys.firewall_rules` lists current allow-list |
| `runbook-ae.md` | ⏳ Planned | Always Encrypted wizard — client-side column encryption | Read-only (FLOW-ONLY — enclaves not in Free tier) | Step-by-step: CMK in Key Vault → CEK → encrypt column |
| `runbook-endpoints.md` | ⏳ Planned | Service Endpoint vs Private Endpoint decision + setup | Read-only | Decision: public IP (SE) vs private IP in VNet (PE) |
| `data-classification.sql` | ⏳ Planned | ADD SENSITIVITY CLASSIFICATION on PII columns | Run in SSMS | `sys.sensitivity_classifications` lists classified columns |
| `auditing.sql` | ⏳ Planned | Enable server audit → Blob Storage + view audit log | Run in SSMS | Audit log shows SELECT on classified columns |
| `ct-cdc.sql` | ⏳ Planned | Enable Change Tracking (lightweight) + CDC (full history) | Run in SSMS | CT: `CHANGETABLE(CHANGES ...)` returns changed row IDs; CDC: change table shows before/after values |
| `ddm.sql` | ⏳ Planned | ADD MASKED WITH (FUNCTION = 'default()') on sensitive column | Run in SSMS; test with low-priv user | Low-priv user sees `xxxx`; admin sees real value |
| `ledger.sql` | ⏳ Planned | Create append-only ledger table; verify tamper-evidence | Run in SSMS | `sp_verify_database_ledger_from_digest_storage` returns PASSED |
| `rls-patient-doctor.sql` | ⏳ Planned | Predicate function + security policy filtering rows per doctor | Run in SSMS; `EXECUTE AS USER` to switch context | Same `SELECT * FROM Patients` returns different row sets |
| `verify-security-consolidation.sql` | ⏳ Planned | Post-M2 audit: verify all security objects are in place | Run in SSMS | All objects present; permissions correct |

---

Flags closed when: RLS returns correct filtered rows per doctor; DDM masks display for unprivileged user; ledger verification passes; Entra user authenticates via `EXTERNAL PROVIDER`.
