# [EXAMPLE] Deploy to Production Procedure

> **Note**: This is an example procedure. Replace with your actual content.

## Purpose
This procedure outlines the steps to safely deploy application changes to the production environment.

## Scope
Applies to all production deployments for the {{COMPANY_NAME}} main application.

## Prerequisites
- [ ] Changes approved via pull request
- [ ] All tests passing in CI/CD pipeline
- [ ] Deployment approved by team lead
- [ ] Access to production AWS console
- [ ] PagerDuty on-call schedule confirmed

## Procedure

### Step 1: Pre-Deployment Checks

Run the pre-deployment verification script:

```bash
./scripts/pre-deploy-check.sh production
```

**Expected Result:** All checks should pass with green status.

### Step 2: Create Deployment Ticket

1. Go to JIRA
2. Create new ticket with type "Deployment"
3. Fill in:
   - Version number
   - Changes summary
   - Rollback plan
   - Risk assessment

**Expected Result:** Ticket created with ID (e.g., DEPLOY-123)

### Step 3: Backup Current Version

```bash
# Tag current production version
git tag -a "backup-$(date +%Y%m%d-%H%M%S)" -m "Pre-deployment backup"
git push origin --tags

# Backup database
aws rds create-db-snapshot \
  --db-instance-identifier prod-db \
  --db-snapshot-identifier "pre-deploy-$(date +%Y%m%d-%H%M%S)"
```

**Expected Result:** Backup tag created and database snapshot initiated.

### Step 4: Deploy to Production

1. Navigate to GitHub Actions
2. Go to "Deploy to Production" workflow
3. Click "Run workflow"
4. Enter:
   - Branch: `main`
   - Environment: `production`
   - Ticket ID: `DEPLOY-123`
5. Click "Run workflow"

**Expected Result:** Deployment pipeline starts and shows green progress.

### Step 5: Monitor Deployment

Watch the deployment progress:

```bash
# Monitor logs
kubectl logs -f deployment/app -n production

# Check health endpoints
curl https://api.{{COMPANY_NAME}}.com/health
```

> **Warning:** If errors appear, proceed immediately to Rollback section.

**Expected Result:** All pods healthy, health check returns 200 OK.

### Step 6: Smoke Test

Run the smoke test suite:

```bash
npm run test:smoke:production
```

**Expected Result:** All smoke tests pass.

### Step 7: Update Status

1. Update JIRA ticket to "Deployed"
2. Post in {{SLACK_CHANNEL}}:
   ```
   ✅ Production deployment complete
   Version: X.Y.Z
   Ticket: DEPLOY-123
   Status: Successful
   ```
3. Update the deployment log spreadsheet

**Expected Result:** All stakeholders notified.

## Troubleshooting

| Issue | Possible Cause | Solution |
|-------|---------------|----------|
| Health check fails | Service not started | Check pod logs, restart if needed |
| Database migration error | Schema conflict | Rollback and fix migration script |
| High error rate | Bug in new code | Immediate rollback |
| Slow response times | Resource constraints | Scale up pods, check metrics |

## Verification

Run the full verification suite:

```bash
./scripts/verify-deployment.sh production
```

Success criteria:
- All health checks passing
- Error rate < 0.1%
- Response time < 200ms p95
- No critical alerts in monitoring

## Rollback

If issues occur, rollback immediately:

```bash
# Trigger rollback workflow
gh workflow run rollback.yml \
  -f environment=production \
  -f target_version=PREVIOUS_VERSION

# Verify rollback
curl https://api.{{COMPANY_NAME}}.com/version
```

Then:
1. Update JIRA ticket with rollback reason
2. Notify team in {{SLACK_CHANNEL}}
3. Schedule post-mortem

## Related Documents
- [Deployment Policy](../policies/deployment-policy.md)
- [Incident Response Procedure](./incident-response.md)
- [Production Architecture](../architecture/production-architecture.md)
- [Monitoring Guide](../guides/monitoring-guide.md)

---
*Last Updated: 2024-01-15*  
*Owner: DevOps Team*  
*Estimated Time: 30 minutes*  
*Risk Level: Medium*
