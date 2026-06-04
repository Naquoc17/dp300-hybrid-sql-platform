// main.bicep — orchestrator for the DP-300 hybrid estate
// Module:    M1
// Level:     L02 (automated deployment of Azure SQL)
// Mode:      HANDS-ON
// Teardown:  delete resource group rg-dp300-capstone
//
// PLACEHOLDER — authored for real during module M1 (deploy & hybrid), step by step.
// Will declare: logical server (sql-dp300-cap), Azure SQL DB (sqldb-cap, serverless,
// Free offer), firewall rules. SQL-on-VM is a separate short-burst deploy.
// Module Bicep lives in ./modules/, parameters in ./parameters/dev.bicepparam.

targetScope = 'resourceGroup'

// params + resources added in M1.
