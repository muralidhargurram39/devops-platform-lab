# DevOps Lab Platform

A modular, Bash-based DevOps platform for provisioning, managing, monitoring, backing up, and restoring a complete local DevOps environment.

The project is designed around a layered architecture with a clear separation of responsibilities, making it maintainable, extensible, and suitable for learning DevOps automation and Bash application design.

---

## Key Features

- Modular layered architecture
- Docker Compose based service orchestration
- Environment-driven configuration
- Service lifecycle management
- Platform diagnostics
- Configuration backup and restore
- Health and readiness checks
- Interactive command-line interface
- Provider abstraction for external integrations
- Extensible command framework

## Technology Stack

| Category | Technology |
|----------|------------|
| Language | Bash |
| Container Runtime | Docker |
| Orchestration | Docker Compose |
| CI/CD | Jenkins |
| Artifact Repository | Nexus Repository |
| Code Quality | SonarQube |
| Database | PostgreSQL |
| Application Server | Apache Tomcat |

## Architecture

The platform follows a layered architecture that separates command handling, validation, business logic, provider integrations, and external systems.

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
Docker • Filesystem • HTTP
```

For a detailed explanation, see:

- `docs/Architecture.md`

## Project Structure

```
devops-platform-lab/

├── config/
├── scripts/
│   ├── commands/
│   ├── lib/
│   ├── platform/
│   └── providers/
│
├── services/
├── backups/
├── docs/
├── images/
├── docker-compose.yml
└── README.md
```

## Prerequisites

Before using the platform, ensure the following software is installed:

- Docker
- Docker Compose
- Bash 5+
- GNU Make
- Git
- curl

## Installation

Clone the repository:

```bash
git clone https://github.com/muralidhargurram39/devops-platform-lab.git
cd devops-platform-lab
```

Initialize the workspace:

```bash
./scripts/platform setup
```

```bash
./scripts/platform deploy --build
```

## Quick Start

Start the platform:

```bash
./scripts/platform start
```

Check platform status:

```bash
./scripts/platform status
```

Run diagnostics:

```bash
./scripts/platform doctor
```

Create a backup:

```bash
./scripts/platform backup
```

Restore a backup:

```bash
./scripts/platform restore
```

## Commands

| Command | Description |
|----------|-------------|
| start | Start services |
| stop | Stop services |
| restart | Restart services |
| status | Show service status |
| doctor | Run diagnostics |
| health | Check service health |
| backup | Create a configuration backup |
| restore | Restore a configuration backup |
| logs | View service logs |
| shell | Open an interactive shell |
| exec | Execute a command inside a service |
| config | Display platform configuration |
| cleanup | Remove temporary resources |

See `docs/Commands.md` for the complete command reference.

## Documentation

- Architecture → `docs/Architecture.md`
- Commands → `docs/Commands.md`
- Configuration → `docs/Configuration.md`
- Backup & Restore → `docs/Backup-Restore.md`
- Developer Guide → `docs/DEVELOPER_GUIDE.md`

## Roadmap

### Version 1.0

- Layered architecture
- Service management
- Backup and restore
- Health diagnostics
- Environment configuration

### Future Enhancements

- Backup listing
- Selective restore
- Backup pruning
- Backup compression
- Plugin architecture
- Multi-environment support
- GitHub Actions
- ShellCheck integration
## Contributing

Contributions are welcome. Please see `CONTRIBUTING.md` for contribution guidelines.

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.
