# Developer Guide

This document provides guidance for developers who want to understand, maintain, or extend the DevOps Lab Platform.

It explains the project architecture, development standards, coding conventions, testing workflow, and release process.

---

# Table of Contents

- Project Philosophy
- Project Structure
- Architecture Overview
- Development Workflow
- Command Contract
- Library Contract
- Provider Contract
- UI Guidelines
- Configuration Guidelines
- Coding Standards
- Adding a New Command
- Adding a New Library
- Adding a New Provider
- Testing
- Debugging
- Git Workflow
- Release Process
- Documentation Standards
- Future Improvements

---

# Project Philosophy

The DevOps Lab Platform is designed around the following principles:

- Separation of Concerns
- Single Responsibility Principle
- Provider Abstraction
- Configuration over Hardcoding
- Modular Design
- Reusable Components
- Consistent User Experience

Business logic should never be tightly coupled to Docker, the filesystem, HTTP requests, or terminal output.

---

# Project Structure

```
devops-lab-platform/

config/
docs/
images/
scripts/

    commands/
    lib/
    platform/
    providers/

services/
backups/
```

Each directory has a single responsibility.

---

# Development Environment

To develop, test, and maintain the DevOps Lab Platform, ensure the following tools are installed on your development machine.

## Required Tools

| Tool | Purpose |
|------|---------|
| Bash 5+ | Primary scripting language used throughout the platform |
| Docker | Container runtime for running platform services |
| Docker Compose | Service orchestration for the DevOps lab environment |
| Git | Version control and collaboration |
| GNU Make | Simplifies common development and maintenance tasks |
| curl | HTTP requests for diagnostics, health checks, and testing |

## Recommended Tools

| Tool | Purpose |
|------|---------|
| ShellCheck | Static analysis for Bash scripts |
| tree | Display the project directory structure |
| jq | Process and format JSON output |
| Visual Studio Code | Recommended editor with Bash support |
| Docker Desktop (Windows/macOS) | Provides Docker Engine and Docker Compose |

## Verify the Development Environment

Before contributing, verify that the required tools are available.

```bash
bash --version
docker --version
docker compose version
git --version
make --version
curl --version
```

If ShellCheck is installed:

```bash
shellcheck --version
```

## Platform Verification

After cloning the repository and completing the initial setup, verify that the platform is functioning correctly.

```bash
platform doctor
```

The diagnostics should confirm:

- Docker is installed and running.
- Docker Compose is available.
- Platform services are healthy.
- HTTP endpoints are reachable.

Resolve any reported issues before making code changes.

## Development Workflow

A typical development workflow is:

```text
Clone Repository
        │
        ▼
Verify Development Environment
        │
        ▼
Run Platform Setup
        │
        ▼
Start Platform
        │
        ▼
Implement Feature
        │
        ▼
Test Changes
        │
        ▼
Update Documentation
        │
        ▼
Commit Changes
        │
        ▼
Push to Repository
```

## Optional Bash Quality Checks

Although not required, it is recommended to validate Bash scripts before committing changes.

Example:

```bash
shellcheck scripts/**/*.sh
```

Static analysis helps identify:

- Quoting issues
- Unused variables
- Incorrect parameter expansion
- Common Bash scripting mistakes

Running ShellCheck before creating a pull request helps maintain code quality across the project.

---

# Architecture Overview

The platform follows a layered architecture.

```
CLI
 │
 ▼
Commands
 │
 ▼
Validation
 │
 ▼
Libraries
 │
 ▼
Providers
 │
 ▼
External Systems
```

Responsibilities:

| Layer | Responsibility |
|--------|----------------|
| CLI | Accept user input |
| Commands | Parse arguments and orchestrate workflows |
| Validation | Validate platform state |
| Libraries | Business logic |
| Providers | External integrations |
| External Systems | Docker, Filesystem, HTTP |

---

# Development Workflow

Every feature should follow this workflow.

```
Requirement

        │

        ▼

Command

        │

        ▼

Validation

        │

        ▼

Library

        │

        ▼

Provider

        │

        ▼

External System
```

Never bypass layers.

---

# Command Contract

Every command must:

1. Accept `"$@"` only.
2. Parse its own arguments.
3. Call `platform_validate()` when required.
4. Never call Docker directly.
5. Never call curl directly.
6. Never manipulate files directly.
7. Call libraries to perform business logic.
8. Use `ui_*()` functions for user output.
9. Use logger functions for logging.
10. Return meaningful exit codes.

Example:

```
platform_backup()
        │
        ▼
platform_validate()
        │
        ▼
backup_create()
```

---

# Library Contract

Libraries implement business logic.

Libraries should:

- Never parse CLI arguments.
- Never print directly to the terminal.
- Never call Docker commands.
- Never call curl.
- Never access configuration directly if already provided.
- Reuse providers.

Libraries may:

- Validate business rules.
- Orchestrate providers.
- Return success or failure.

---

# Provider Contract

Providers isolate external dependencies.

Examples:

- Docker Provider
- Docker Compose Provider
- Filesystem Provider
- HTTP Provider

Providers may execute:

- docker
- docker compose
- cp
- rm
- mkdir
- curl

Only providers interact with external systems.

---

# UI Guidelines

User-facing output should always use the shared UI library.

Preferred functions:

```
ui_header
ui_section
ui_success
ui_warning
ui_error
ui_info
ui_command_row
```

Avoid raw `echo` statements for formatted output.

This keeps the entire platform visually consistent.

---

# Configuration Guidelines

Configuration belongs under:

```
config/
```

Never hardcode:

- file paths
- URLs
- ports
- service names

Instead, load values from configuration files.

---

# Coding Standards

Follow these conventions.

## Functions

Use:

```
platform_start
backup_create
docker_container_exists
```

Avoid:

```
StartPlatform
Backup()
DoStuff()
```

---

## Variables

Use descriptive names.

Good:

```
backup_directory
service_name
http_endpoint
```

Avoid:

```
tmp
data
foo
```

---

## Quoting

Always quote variables.

Good:

```bash
cp "$source" "$destination"
```

Avoid:

```bash
cp $source $destination
```

---

## Error Handling

Always validate before execution.

Fail fast.

Return meaningful exit codes.

Avoid silent failures.

---

# Adding a New Command

To add a new command:

1. Create a file under `scripts/commands`.
2. Implement the command function.
3. Parse arguments.
4. Call validation.
5. Delegate business logic to libraries.
6. Register the command in the dispatcher.
7. Update the help command.
8. Document the command.

---

# Adding a New Library

Libraries belong under:

```
scripts/lib/
```

Responsibilities:

- Business logic
- Workflow implementation
- Provider orchestration

Libraries should remain independent of the CLI.

---

# Adding a New Provider

Providers belong under:

```
scripts/providers/
```

Examples:

```
docker_provider.sh
filesystem_provider.sh
http_provider.sh
```

Providers wrap all external commands.

Avoid duplicating provider logic.

---

# Testing

Before committing code:

Run:

```bash
platform doctor
```

Verify:

- Docker
- Docker Compose
- Services
- HTTP endpoints

Test:

- start
- stop
- restart
- backup
- restore

Ensure no regressions.

---

# Debugging

Useful commands:

```bash
platform status
platform doctor
platform logs jenkins
platform shell nexus
```

Use provider functions instead of executing commands manually whenever possible.

---

# Git Workflow

Recommended workflow:

```bash
git checkout -b feature/my-feature

git add .

git commit -m "feat: add my feature"

git push origin feature/my-feature
```

Merge through Pull Requests whenever collaborating.

---

# Release Process

Before creating a release:

- Run diagnostics.
- Test all commands.
- Update documentation.
- Update CHANGELOG.
- Commit changes.
- Create a version tag.
- Push commits and tags.

Example:

```bash
git tag -a v1.1.0 -m "Release v1.1.0"

git push origin main --tags
```

---

# Documentation Standards

Every new feature should update:

- README.md (if user-facing)
- Commands.md
- Architecture.md (if architecture changes)
- Configuration.md (if configuration changes)
- Backup-Restore.md (if backup logic changes)
- CHANGELOG.md

Documentation should remain synchronized with implementation.

---

# Future Improvements

Potential future enhancements include:

- Plugin architecture
- Backup compression
- Scheduled backups
- GitHub Actions
- ShellCheck integration
- Multi-environment deployments
- Automated testing
- Restore by backup name
- Backup pruning

---

# Summary

The DevOps Lab Platform follows a modular layered architecture designed to encourage clean separation of responsibilities.

By following the contracts and standards described in this guide, contributors can extend the platform while maintaining consistency, readability, and long-term maintainability.
