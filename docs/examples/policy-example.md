# [EXAMPLE] Security Policy

> **Note**: This is an example policy. Replace with your actual content.

## Purpose

This policy establishes security requirements for {{COMPANY_NAME}} systems to protect company data, maintain customer trust, and ensure compliance with regulatory requirements.

## Scope

Applies to all employees, contractors, and third-party users with access to {{COMPANY_NAME}} systems and data.

## Definitions

- **MFA**: Multi-factor authentication
- **PII**: Personally Identifiable Information
- **Security Incident**: Any event that compromises the confidentiality, integrity, or availability of information

## Policy Statements

1. **Access Control**
   - Multi-factor authentication is required for all production systems
   - Access must follow the principle of least privilege
   - Access reviews must be conducted quarterly
   - Unused accounts must be disabled within 24 hours of employee departure

2. **Password Requirements**
   - Minimum 12 characters
   - Must include uppercase, lowercase, numbers, and special characters
   - Must be unique (not reused from last 12 passwords)
   - Must be changed every 90 days

3. **Data Protection**
   - All sensitive data must be encrypted at rest and in transit
   - PII must not be stored in non-production environments
   - Data classification must be applied to all documents

4. **Incident Response**
   - Security incidents must be reported within 1 hour of discovery
   - Follow the [Incident Response Procedure](../procedures/incident-response.md)

## Responsibilities

- **All Staff**: Follow security policies, report incidents
- **Security Team**: Maintain policies, conduct audits, respond to incidents
- **Managers**: Ensure team compliance, approve access requests
- **IT Operations**: Implement technical controls, maintain systems

## Compliance

Violations may result in:
- First offense: Written warning
- Second offense: Suspension of access
- Third offense: Termination

## Exceptions

Exceptions must be:
1. Documented with business justification
2. Approved by Security Team and management
3. Reviewed every 90 days
4. Logged in the exception registry

## Related Documents

- [Incident Response Procedure](../procedures/incident-response.md)
- [Data Classification Guide](../guides/data-classification.md)
- [Access Control Procedure](../procedures/access-control.md)

---
*Last Updated: 2024-01-15*  
*Owner: Security Team*  
*Review Cycle: Annual*  
*Next Review: 2025-01-15*
