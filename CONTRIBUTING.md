# Contributing

Thank you for your interest in contributing to the DevOps Lab Platform.

Contributions of all sizes are welcome, including:

- Bug fixes
- Documentation improvements
- New features
- Performance improvements
- Refactoring
- Testing
- Developer tooling

This document explains the recommended development workflow and contribution standards.

---

# Code of Conduct

Please be respectful and constructive when interacting with other contributors.

When reviewing code:

- Focus on the code, not the person.
- Be open to feedback.
- Assume positive intent.
- Encourage learning and collaboration.

---

# Prerequisites

Before contributing, ensure the following tools are installed.

| Tool | Version |
|-------|----------|
| Bash | 5+ |
| Docker | Latest |
| Docker Compose | Latest |
| Git | Latest |
| GNU Make | Latest |
| curl | Latest |

Recommended:

- ShellCheck
- Visual Studio Code
- tree
- jq

---

# Development Environment

Clone the repository.

```bash
git clone https://github.com/muralidhargurram39/devops-platform-lab.git

cd devops-platform-lab
```

Initialize the platform.

```bash
./scripts/platform setup
```

Verify your environment.

```bash
./scripts/platform doctor
```

---

# Branch Strategy

Never develop directly on the main branch.

Create a feature branch.

```bash
git checkout -b feature/my-feature
```

Examples:

```
feature/http-provider
feature/backup-compression
feature/plugin-system
```

Bug fixes:

```
bugfix/restore-validation
bugfix/docker-provider
```

Documentation:

```
docs/architecture
docs/readme
```

---

# Commit Message Convention

Use meaningful commit messages.

Examples:

```
feat: add backup compression

fix: improve restore validation

docs: update architecture guide

refactor: simplify provider layer

test: add backup regression tests
```

Avoid:

```
update

changes

fixed

test
```

---

# Coding Standards

Follow the project architecture.

```
CLI

↓

Commands

↓

Validation

↓

Libraries

↓

Providers

↓

External Systems
```

Never bypass layers.

Commands should never call Docker, curl, or filesystem commands directly.

Providers should isolate all external interactions.

---

# Command Contract

Every command should:

- Parse its own arguments.
- Validate inputs.
- Delegate business logic.
- Use shared UI functions.
- Return meaningful exit codes.

---

# Testing

Before submitting changes:

Run diagnostics.

```bash
./scripts/platform doctor
```

Test:

```bash
./scripts/platform start

./scripts/platform stop

./scripts/platform restart

./scripts/platform backup

./scripts/platform restore

./scripts/platform status
```

Verify:

- Services start correctly.
- Services stop correctly.
- HTTP endpoints are reachable.
- Backups complete successfully.
- Restores complete successfully.

---

# Documentation

If your change affects users or developers, update the relevant documentation.

Possible documents include:

- README.md
- Architecture.md
- Commands.md
- Configuration.md
- Backup-Restore.md
- Developer Guide
- CHANGELOG.md

Documentation should always remain synchronized with the implementation.

---

# Pull Requests

Before opening a Pull Request:

- Ensure your branch is up to date.
- Resolve merge conflicts.
- Run platform diagnostics.
- Test affected commands.
- Update documentation.
- Update the changelog if necessary.

Provide a clear description of:

- What changed
- Why it changed
- How it was tested

---

# Issue Reporting

When reporting an issue, include:

- Operating System
- Bash version
- Docker version
- Docker Compose version
- Platform version
- Steps to reproduce
- Expected behavior
- Actual behavior
- Relevant logs

---

# Feature Requests

Feature requests should include:

- Problem statement
- Proposed solution
- Expected benefits
- Possible implementation approach

---

# Release Process

Before publishing a release:

- Run all regression tests.
- Update documentation.
- Update CHANGELOG.md.
- Commit changes.
- Create a Git tag.
- Push commits and tags.
- Publish a GitHub Release.

---

# Getting Help

Useful resources:

- README.md
- docs/Architecture.md
- docs/Commands.md
- docs/Configuration.md
- docs/Backup-Restore.md
- docs/DEVELOPER_GUIDE.md

---

# Thank You

Thank you for contributing to the DevOps Lab Platform.

Your contributions help improve the project for the entire community.

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.
