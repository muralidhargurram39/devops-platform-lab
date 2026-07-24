# Configuration

The DevOps Lab Platform uses an externalized configuration model to separate application logic from environment-specific settings.

All platform behavior is driven by configuration files rather than hardcoded values. This approach makes the platform easier to customize, maintain, and extend across different environments.

The configuration system is designed around the following principles:

- Configuration over hardcoding
- Environment-specific settings
- Centralized service definitions
- Reusable configuration files
- Minimal code changes when adding new services

## Configuration Directory

```
config/

├── environment.conf
├── local.conf
├── aws.conf
└── services.conf
```

Each file has a specific responsibility within the platform.

## Configuration Loading

The platform loads configuration in the following order:

```
Bootstrap
      │
      ▼
environment.conf
      │
      ▼
Selected Environment
(local.conf / aws.conf)
      │
      ▼
services.conf
      │
      ▼
Commands
```

This layered loading process allows common settings to be shared while environment-specific values override defaults where necessary.

## Configuration Files

| File | Purpose |
|------|---------|
| environment.conf | Defines the active platform environment |
| local.conf | Local development configuration |
| aws.conf | AWS-specific configuration |
| services.conf | Service registry and service definitions |

## Environment Profiles

Environment profiles allow the platform to run in different deployment environments without changing application logic.

Examples include:

- Local Development
- AWS
- Future cloud providers

Each environment can define:

- Docker Compose files
- Network settings
- Storage locations
- Platform-specific variables

## Service Registry

All managed services are defined in `services.conf`.

Each service definition includes:

- Service name
- Docker Compose service name
- HTTP endpoint
- Health check support

Example:

```text
Jenkins | jenkins | http://localhost:8080 | true
```

The platform uses these definitions to:

- Start services
- Stop services
- Restart services
- Run diagnostics
- Perform HTTP health checks

## Configuration Variables

Configuration files define variables used throughout the platform.

Typical variables include:

- Project name
- Platform version
- Backup directory
- Configuration directory
- Docker Compose file
- Active environment
- Service registry

Commands consume these variables rather than hardcoding paths or values.

## Configuration Flow

Configuration values flow through the platform as follows:

```
Configuration Files
        │
        ▼
Bootstrap
        │
        ▼
Global Variables
        │
        ▼
Commands
        │
        ▼
Libraries
        │
        ▼
Providers
```

This approach ensures configuration is loaded once and reused throughout the platform.

## Adding a New Service

To add a new managed service:

1. Add the service to `docker-compose.yml`.
2. Add the service definition to `services.conf`.
3. Configure any required environment variables.
4. Update health checks if applicable.
5. Test service lifecycle commands.
6. Update the documentation if new functionality is introduced.

No command changes are required if the service follows the existing service definition format.

## Creating a New Environment

To support a new environment:

1. Create a new configuration file under `config/`.
2. Define environment-specific variables.
3. Update `environment.conf` to reference the new profile.
4. Test platform commands in the new environment.

This approach keeps environment-specific configuration separate from platform logic.

## Best Practices

- Keep configuration outside command implementations.
- Avoid hardcoded file paths.
- Reuse existing variables whenever possible.
- Keep service definitions centralized.
- Validate configuration before executing platform operations.
- Document new configuration options.

## Summary

The configuration system provides a flexible foundation for the DevOps Lab Platform by separating environment-specific settings from application logic.

This design simplifies maintenance, supports multiple deployment environments, and allows new services to be integrated with minimal code changes.
