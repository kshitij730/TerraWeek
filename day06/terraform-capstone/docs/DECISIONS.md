# 📝 DECISIONS.md

# Engineering Decisions

> **Why TerraDeploy was designed the way it is**

This document explains the key engineering decisions made while building the **TerraDeploy Capstone Project**. Rather than simply describing *what* was built, it explains *why* each design choice was made and the trade-offs involved.

---

# 📖 Table of Contents

- Project Goals
- Design Philosophy
- Why Terraform?
- Why AWS?
- Why Modular Architecture?
- Why Terraform Registry Modules?
- Why Custom Modules?
- Why Remote State?
- Why Workspaces?
- Why Native Terraform Testing?
- Why GitHub Actions?
- Why Trivy?
- Why Input Validation?
- Why User Data?
- Why Version Pinning?
- Trade-offs
- Future Improvements
- Conclusion

---

# 🎯 Project Goals

The primary objective of this capstone project was **not** to create the largest AWS infrastructure possible.

Instead, the goal was to build a project that demonstrates:

- Infrastructure as Code (IaC)
- Modular Design
- Reusability
- Automation
- Security
- Testing
- Documentation
- Production-inspired DevOps Practices

Every design decision was evaluated against these goals.

---

# 🌍 Why Terraform?

Terraform was selected because it is one of the most widely adopted Infrastructure as Code tools.

### Benefits

- Cloud Agnostic
- Declarative Configuration
- State Management
- Large Ecosystem
- Massive Community Support

Terraform allows infrastructure to be version controlled just like application code.

---

# ☁️ Why AWS?

AWS was selected because:

- It is the most widely used public cloud platform.
- Rich Terraform provider support.
- Large free-tier ecosystem.
- Enterprise adoption.
- Extensive documentation.

AWS provides all the services required for this project without introducing unnecessary complexity.

---

# 📦 Why Modular Architecture?

Instead of writing all resources inside one `main.tf`, the infrastructure was divided into reusable modules.

```
Root Module

│

├── EC2

├── Security Group

└── S3
```

### Advantages

- Easier Maintenance
- Code Reuse
- Better Organization
- Smaller Files
- Independent Development

In production environments, modules are the preferred approach because they reduce duplication and improve scalability.

---

# 🏗️ Why Terraform Registry Modules?

Instead of manually creating networking resources, the project uses the official Terraform Registry VPC module.

```
terraform-aws-modules/vpc/aws
```

### Reasons

- Community Maintained
- Well Tested
- Production Ready
- Regular Updates
- Reduced Maintenance

Rather than reinventing networking components, using a trusted module reduces the likelihood of configuration errors.

---

# 🧩 Why Custom Modules?

Three reusable custom modules were created.

- EC2 Module
- Security Group Module
- S3 Module

Each module has a single responsibility.

This separation makes infrastructure:

- Easier to extend
- Easier to debug
- Easier to reuse

---

# 🔐 Why Remote State?

Terraform state is critical.

Keeping it locally works for learning purposes, but not for teams.

The project stores Terraform state remotely in Amazon S3.

Benefits include:

- Shared Infrastructure State
- Team Collaboration
- Backup
- Reliability
- Consistency

Remote state also prepares the project for future CI/CD pipelines.

---

# 🌱 Why Terraform Workspaces?

Infrastructure rarely exists in a single environment.

Most organizations manage:

```
Development

↓

Testing

↓

Staging

↓

Production
```

Terraform Workspaces allow these environments to share the same codebase while maintaining isolated state files.

Benefits include:

- Less Code Duplication
- Cleaner Repositories
- Easier Environment Management

---

# 🧪 Why Native Terraform Testing?

Infrastructure should be tested before deployment.

Terraform Native Testing allows infrastructure validation directly within Terraform.

The project validates:

- Variables
- Outputs
- Workspace Configuration
- Resource Creation

Automated testing improves confidence and reduces deployment failures.

---

# ⚙️ Why GitHub Actions?

Manual verification is error-prone.

GitHub Actions automatically executes quality checks whenever code is pushed.

Pipeline:

```
Push

↓

Terraform Format

↓

Terraform Validate

↓

Terraform Test

↓

Terraform Plan

↓

Trivy Scan
```

Benefits:

- Automation
- Faster Reviews
- Consistent Quality
- Reduced Human Error

---

# 🛡️ Why Trivy?

Security should be integrated into Infrastructure as Code.

Rather than discovering issues after deployment, Trivy scans Terraform configuration before infrastructure reaches production.

Benefits:

- Misconfiguration Detection
- Security Best Practices
- Compliance Checks

This follows the **Shift Left Security** principle.

---

# ✅ Why Input Validation?

Variables include validation rules to prevent invalid user input.

Example:

```
Environment

↓

Allowed

dev

staging

prod
```

This prevents accidental deployments caused by incorrect values.

---

# ⚡ Why User Data?

Instead of manually connecting to the EC2 instance after deployment, **User Data** automatically:

- Updates packages
- Installs Nginx
- Starts the service
- Deploys the landing page

Benefits:

- Fully Automated
- Repeatable
- Faster Provisioning

---

# 📌 Why Version Pinning?

Terraform and provider versions are pinned.

Example:

```hcl
required_version = ">= 1.10"

version = "~> 6.0"
```

Version pinning ensures:

- Reproducible Builds
- Stable Deployments
- Consistent Team Environments

---

# ⚖️ Trade-offs

Every engineering decision has trade-offs.

| Decision | Benefit | Trade-off |
|----------|----------|-----------|
| Registry Module | Less maintenance | Less customization |
| Custom Modules | Reusable | More files |
| Remote State | Collaboration | Backend setup required |
| GitHub Actions | Automation | Initial configuration effort |
| Trivy | Better security | Slightly longer pipeline |
| Workspaces | Environment isolation | Workspace management |

Understanding trade-offs is an important part of designing production infrastructure.

---

# 🚀 Future Improvements

Potential future enhancements include:

- Application Load Balancer
- Auto Scaling Group
- Route 53
- ACM SSL Certificates
- CloudWatch Monitoring
- ECS / Fargate
- AWS WAF
- Terraform Cloud
- Policy as Code
- Cost Estimation

These additions would make the project even closer to enterprise-scale cloud deployments.

---

# 📚 Key Takeaways

The most important lesson from this project is that Infrastructure as Code is much more than writing Terraform files.

Production infrastructure requires:

- Planning
- Modularity
- Automation
- Testing
- Security
- Documentation

Every decision made in this project reflects those principles.

---

# 🎉 Conclusion

The engineering decisions documented here were made with one objective in mind:

> **Build infrastructure that is maintainable, reproducible, secure, and easy to understand.**

Rather than optimizing only for functionality, the project prioritizes **clarity, automation, reliability, and scalability**.

This document complements the source code by explaining the reasoning behind the architecture and demonstrates that every major implementation choice was intentional.