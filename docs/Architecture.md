# Architecture

## Project Goals

The DevOps Lab Platform is designed as a modular Bash application that manages a complete local DevOps environment.

The architecture aims to:

- Separate responsibilities into well-defined layers.
- Minimize coupling between components.
- Maximize code reuse.
- Simplify maintenance and testing.
- Make it easy to add new commands and providers.
- Keep command implementations lightweight by delegating business logic to libraries.

## Design Principles

The platform follows these core principles:

- Single Responsibility Principle
- Separation of Concerns
- Provider Abstraction
- Configuration over Hardcoding
- Modular Design
- Reusable Libraries
- Consistent Command Structure
- Fail Fast Validation

## High-Level Architecture

```
                 User
                   │
                   ▼
          CLI (scripts/platform)
                   │
                   ▼
             Commands Layer
                   │
                   ▼
           Validation Layer
                   │
                   ▼
          Business Logic Layer
                   │
                   ▼
            Provider Layer
                   │
                   ▼
 Docker • Filesystem • HTTP • Compose
```

Each layer has a single responsibility and communicates only with the layer directly below it.

## Layer Responsibilities

| Layer | Responsibility |
|--------|----------------|
| CLI | Accepts user input and dispatches commands |
| Commands | Parse arguments and orchestrate workflows |
| Validation | Validate user input and platform state |
| Libraries | Implement business logic |
| Providers | Wrap external systems and tools |
| External Systems | Docker, Filesystem, HTTP endpoints |

## Execution Flow

When a user executes a command, the request flows through multiple layers.

Example:

```
platform backup
        │
        ▼
platform_backup()
        │
        ▼
platform_validate()
        │
        ▼
backup_create()
        │
        ▼
filesystem_provider
        │
        ▼
Backup Directory
```

This layered execution keeps business logic independent of external implementations.

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| config | Environment and service configuration |
| scripts/commands | CLI command implementations |
| scripts/lib | Shared business logic |
| scripts/providers | Wrappers for external systems |
| services | Service-specific resources |
| backups | Configuration backups |
| docs | Project documentation |
| images | Architecture diagrams and screenshots |

## Provider Pattern

The provider layer isolates all interactions with external systems.

Examples include:

- Docker Provider
- Docker Compose Provider
- Filesystem Provider
- HTTP Provider

Libraries call providers instead of invoking system commands directly.

For example, backup and restore operations interact with the filesystem through the filesystem provider rather than calling `cp`, `rm`, or `mkdir` directly.

This abstraction improves maintainability and allows implementation details to change without affecting business logic.

## Design Decisions

The following decisions shape the architecture:

- Commands contain orchestration logic only.
- Validation is centralized.
- Business logic resides in reusable libraries.
- Providers encapsulate all external interactions.
- Configuration is externalized.
- Service definitions are centralized.
- User-facing output is handled through the UI library.

## Extending the Platform

To add a new command:

1. Create a command under `scripts/commands`.
2. Implement business logic in `scripts/lib`.
3. Reuse existing providers or add a new provider if required.
4. Register the command in the platform dispatcher.
5. Update the help command.
6. Document the command in `docs/Commands.md`.

Following this process keeps the architecture consistent.

## Summary

The DevOps Lab Platform follows a layered, modular architecture that separates command handling, validation, business logic, provider integrations, and external systems.

This design makes the project easier to maintain, test, extend, and understand while providing a consistent foundation for future enhancements.
