# Command Reference

This document describes every command provided by the **DevOps Lab Platform**.

Commands are grouped by responsibility to make them easier to discover and use.

---

# General Syntax

```text
platform <command> [options]
```

Examples:

```bash
platform start
platform stop nexus
platform doctor
platform backup
platform restore
platform logs jenkins
```

---

# Command Categories

| Category | Commands |
|----------|----------|
| Workspace | setup, wake, sleep |
| Platform | start, stop, restart, status, doctor, health |
| Operations | backup, restore, cleanup |
| Utilities | logs, shell, exec, config, version, help |

---

# Quick Reference

| Command | Description |
|----------|-------------|
| setup | Initialize the platform |
| wake | Wake the development workspace |
| sleep | Put the workspace into sleep mode |
| start | Start services |
| stop | Stop services |
| restart | Restart services |
| status | Display service status |
| doctor | Run platform diagnostics |
| health | Check service health |
| backup | Create a configuration backup |
| restore | Restore a configuration backup |
| cleanup | Remove temporary files and resources |
| logs | View service logs |
| shell | Open an interactive shell inside a container |
| exec | Execute a command inside a container |
| config | Display platform configuration |
| version | Display platform version |
| help | Display command help |

---

# Workspace Commands

---

## setup

### Purpose

Initializes the DevOps Lab Platform and prepares the workspace.

### Syntax

```text
platform setup
```

### Example

```bash
platform setup
```

### Notes

- Performs initial platform setup.
- Validates required dependencies.
- Creates required directories if necessary.

---

## wake

### Purpose

Wakes the development workspace.

### Syntax

```text
platform wake
```

### Example

```bash
platform wake
```

### Notes

- Intended for development workflows.
- Restores the workspace to an active state.

---

## sleep

### Purpose

Puts the development workspace into sleep mode.

### Syntax

```text
platform sleep
```

### Example

```bash
platform sleep
```

### Notes

- Intended for development workflows.
- Preserves the workspace while reducing resource usage.

---

# Platform Commands

---

## start

### Purpose

Starts platform services.

### Syntax

```text
platform start [service|all]
```

### Examples

```bash
platform start
platform start all
platform start jenkins
platform start sonarqube
```

### Notes

- Starts all services when no service is specified.
- Validates platform configuration before execution.
- Waits for services to become available.

### Related Commands

- stop
- restart
- status

---

## stop

### Purpose

Stops platform services.

### Syntax

```text
platform stop [service|all]
```

### Examples

```bash
platform stop
platform stop all
platform stop nexus
```

### Notes

- Stops all services when no service is specified.
- Gracefully shuts down running containers.

### Related Commands

- start
- restart

---

## restart

### Purpose

Restarts one or more platform services.

### Syntax

```text
platform restart [service|all]
```

### Examples

```bash
platform restart
platform restart tomcat
```

### Notes

- Stops the selected services.
- Starts the selected services again.

### Related Commands

- start
- stop

---

## status

### Purpose

Displays the current status of platform services.

### Syntax

```text
platform status
```

### Example

```bash
platform status
```

### Notes

Displays:

- Running services
- Container state
- Overall platform status

### Related Commands

- doctor
- health

---

## doctor

### Purpose

Runs platform diagnostics.

### Syntax

```text
platform doctor
```

### Example

```bash
platform doctor
```

### Diagnostics Performed

- Docker installation
- Docker daemon
- Docker Compose
- Service availability
- HTTP connectivity
- Platform health

### Related Commands

- status
- health

---

## health

### Purpose

Checks service health.

### Syntax

```text
platform health
```

### Example

```bash
platform health
```

### Notes

Verifies service readiness and reports unhealthy services.

### Related Commands

- doctor
- status

---

# Operations

---

## backup

### Purpose

Creates a timestamped configuration backup.

### Syntax

```text
platform backup
```

### Example

```bash
platform backup
```

### Backup Includes

- Configuration files
- Docker Compose file
- Backup metadata

### Output Structure

```text
backups/

└── YYYYMMDD-HHMMSS/
    ├── config/
    ├── docker-compose.yml
    └── metadata.conf
```

### Related Commands

- restore

---

## restore

### Purpose

Restores the platform configuration from a backup.

### Syntax

```text
platform restore
```

### Example

```bash
platform restore
```

### Restore Workflow

1. Validate backup
2. Display backup information
3. Request confirmation
4. Stop platform
5. Restore configuration
6. Restore docker-compose.yml
7. Start platform
8. Wait for services
9. Run diagnostics

### Notes

The current implementation restores the latest backup after confirmation.

### Related Commands

- backup
- doctor

---

## cleanup

### Purpose

Removes temporary resources created by the platform.

### Syntax

```text
platform cleanup
```

### Example

```bash
platform cleanup
```

### Notes

May remove:

- Temporary files
- Cached data
- Workspace artifacts

---

# Utility Commands

---

## logs

### Purpose

Displays service logs.

### Syntax

```text
platform logs <service>
```

### Examples

```bash
platform logs jenkins
platform logs nexus
platform logs sonarqube
```

### Notes

Useful for troubleshooting service startup and runtime issues.

### Related Commands

- shell
- exec

---

## shell

### Purpose

Opens an interactive shell inside a running service container.

### Syntax

```text
platform shell <service>
```

### Examples

```bash
platform shell jenkins
platform shell nexus
platform shell tomcat
```

### Notes

Provides direct access to the container for debugging.

### Related Commands

- exec
- logs

---

## exec

### Purpose

Executes a command inside a running service container.

### Syntax

```text
platform exec <service> <command>
```

### Examples

```bash
platform exec nexus ls /nexus-data

platform exec tomcat pwd

platform exec jenkins java -version
```

### Notes

Useful for automation and scripting.

### Related Commands

- shell
- logs

---

## config

### Purpose

Displays the current platform configuration.

### Syntax

```text
platform config
```

### Example

```bash
platform config
```

### Notes

Displays the active environment and platform configuration values.

---

## version

### Purpose

Displays the current platform version.

### Syntax

```text
platform version
```

### Example

```bash
platform version
```

---

## help

### Purpose

Displays the platform help screen.

### Syntax

```text
platform help
```

### Example

```bash
platform help
```

### Notes

Provides a categorized overview of available commands and common usage examples.

---

# Common Examples

Start the platform

```bash
platform start
```

Stop Jenkins

```bash
platform stop jenkins
```

Restart SonarQube

```bash
platform restart sonarqube
```

Run diagnostics

```bash
platform doctor
```

Create a backup

```bash
platform backup
```

Restore configuration

```bash
platform restore
```

View Jenkins logs

```bash
platform logs jenkins
```

Open a shell inside Nexus

```bash
platform shell nexus
```

Execute a command inside Tomcat

```bash
platform exec tomcat ls /usr/local/tomcat
```

Display platform configuration

```bash
platform config
```

Display version

```bash
platform version
```

---

# Exit Status

| Exit Code | Meaning |
|-----------|---------|
| 0 | Command completed successfully |
| Non-zero | Command failed due to validation, runtime, or provider errors |

---

# Related Documentation

- `README.md` — Project overview and quick start
- `docs/Architecture.md` — Layered architecture and design
- `docs/Configuration.md` — Configuration files and environments
- `docs/Backup-Restore.md` — Backup and restore workflow
- `docs/DEVELOPER_GUIDE.md` — Development guidelines
