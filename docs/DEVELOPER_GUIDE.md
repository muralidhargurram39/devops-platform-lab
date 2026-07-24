## Command Contract

Every command must:

1. Accept "$@" only.
2. Parse its own arguments.
3. Call platform_validate() if required.
4. Never call Docker or curl directly.
5. Use providers for external interactions.
6. Use ui_* functions for output.
7. Use logger functions for logging.
