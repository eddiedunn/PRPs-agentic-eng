Of course. Here is a comprehensive `CLAUDE.md` guide for Ansible, modeled after the other framework-specific guides in your repository. All conventions and tools mentioned are current best practices as of mid-2025.

---

# CLAUDE.md

This file provides comprehensive guidance to Claude Code when working with Ansible automation projects.

## Core Development Philosophy

### KISS (Keep It Simple, Stupid)
Simplicity should be a key goal in design. Choose straightforward, declarative solutions over complex, imperative scripts. Simple playbooks are easier to understand, maintain, and debug.

### YAGNI (You Aren't Gonna Need It)
Avoid building functionality on speculation. Implement roles and tasks only when they are needed, not when you anticipate they might be useful in the future.

### Design Principles (MUST FOLLOW)
*   **Idempotence**: Every playbook and role must be safely runnable multiple times. Running a playbook a second time should result in zero changes.
*   **Declarative over Imperative**: Define the desired state of the system using modules, not the steps to get there. Avoid `command` and `shell` modules whenever a dedicated module exists.
*   **Agentless & Push-Based**: Remember that Ansible works by pushing configurations from a control node. All logic should reflect this model.

## 🤖 AI Assistant Guidelines

### Context Awareness
*   When implementing features, always check for existing roles or playbooks first.
*   Prefer using collections and roles over writing ad-hoc tasks in a playbook.
*   Use existing inventory variables before defining new ones.
*   Check for similar automation logic in other roles or playbooks before creating new ones.

### Common Pitfalls to Avoid
*   Creating duplicate automation logic.
*   Modifying core roles without understanding their dependencies.
*   Adding collections without updating `requirements.yml`.
*   Hardcoding secrets; always use Ansible Vault.

### Workflow Patterns
*   Preferably create tests (linting, Molecule) BEFORE extensive implementation.
*   Use "think hard" for designing role dependencies and variable structures.
*   Break complex automation into smaller, single-purpose roles.
*   Validate understanding of the desired state before writing tasks.

### Search Command Requirements
**CRITICAL**: Always use `rg` (ripgrep) instead of traditional `grep` and `find` commands:

```bash
# ❌ Don't use grep
grep -r "pattern" .

# ✅ Use rg instead
rg "pattern"

# ❌ Don't use find with name
find . -name "*.yml"

# ✅ Use rg with file filtering
rg --files | rg "\.yml$"
# or
rg --files -g "*.yml"
```
**Enforcement Rules:**
```
(
    r"^grep\b(?!.*\|)",
    "Use 'rg' (ripgrep) instead of 'grep' for better performance and features",
),
(
    r"^find\s+\S+\s+-name\b",
    "Use 'rg --files | rg pattern' or 'rg --files -g pattern' instead of 'find -name' for better performance",
),
```

## 🚀 Ansible Core & Tooling (2025)

### Execution Environments (MANDATORY)
Modern Ansible development uses containerized Execution Environments (EEs) instead of Python virtual environments. EEs package Ansible Core, collections, Python dependencies, and system libraries into a single, portable container image.

*   **MUST** define dependencies in `requirements.yml` (collections) and `requirements.txt` (python).
*   **MUST** use `ansible-builder` to create EEs.
*   **MUST** use `ansible-navigator` to run playbooks within the defined EE.

### Key Features of Modern Ansible
*   **Ansible Core**: A minimal central engine for Ansible. All modules and plugins are delivered via collections.
*   **Collections**: The standard for distributing, managing, and consuming Ansible content.
*   **Fully Qualified Collection Name (FQCN)**: **MUST** be used for all modules to avoid ambiguity (e.g., `ansible.builtin.debug` instead of `debug`). This is enforced by `ansible-lint`.

## 🏗️ Project Structure (Monorepo Best Practice)

A standardized, scalable project structure is **MANDATORY**.

```
ansible-monorepo/
├── ansible.cfg                # Global Ansible configuration
├── execution-environment.yml  # EE definition for ansible-builder
├── inventory/                 # Inventory files and variables
│   ├── production
│   ├── staging
│   └── group_vars/
│       ├── all/
│       │   ├── vars.yml
│       │   └── vault.yml
│       └── webservers.yml
├── playbooks/                 # Entry point playbooks
│   └── setup_webserver.yml
├── roles/                     # Project-specific roles
│   └── nginx/
│       ├── tasks/
│       │   └── main.yml
│       ├── defaults/
│       │   └── main.yml
│       ├── meta/
│       │   └── main.yml
│       └── molecule/          # Molecule tests for this role
│           └── default/
│               ├── molecule.yml
│               └── converge.yml
└── requirements.yml           # Collection requirements
```

## 🎯 YAML & Task Syntax (STRICT REQUIREMENTS)

### YAML Style Guide
*   **Indent**: 2 spaces.
*   **Quotes**: Use quotes for strings that contain special characters or look like numbers/booleans (e.g., `"0.10"`, `"yes"`). Be consistent.
*   **Booleans**: Use `true` and `false` (lowercase).

### Task Naming Convention (MANDATORY)
*   All plays and tasks **MUST** have a `name`.
*   Names must be descriptive and start with an uppercase letter.
*   Format: `Role Name | Action being performed`

```yaml
# ✅ CORRECT
- name: Nginx | Ensure Nginx package is installed
  ansible.builtin.package:
    name: nginx
    state: present
```

### Module Syntax (MANDATORY)
*   **MUST** use FQCN for all modules (e.g., `ansible.builtin.copy`).
*   **MUST** use the multi-line `key: value` format for module arguments. Avoid one-line `key=value` syntax.

```yaml
# ✅ CORRECT: Multi-line format
- name: Nginx | Copy configuration file
  ansible.builtin.template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'

# ❌ FORBIDDEN: One-line format
- name: Copy configuration file
  ansible.builtin.template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf```

## 🔐 Secrets Management (Ansible Vault)

*   **MANDATORY**: All secrets (passwords, API keys, tokens) **MUST** be encrypted using Ansible Vault.
*   **BEST PRACTICE**: Encrypt variable files (e.g., `group_vars/all/vault.yml`), not entire playbooks.
*   Use `ansible-vault` to create, edit, encrypt, and decrypt files.
*   In CI/CD, provide the vault password via a secure file or environment variable (`ANSIBLE_VAULT_PASSWORD_FILE`).

```bash
# Create a new encrypted file
ansible-vault create group_vars/all/vault.yml

# Edit an existing encrypted file
ansible-vault edit group_vars/all/vault.yml

# Run a playbook with a vault password file
ansible-playbook --vault-password-file .vault_pass playbooks/main.yml
```

## 🧪 Testing Strategy (MANDATORY REQUIREMENTS)

### 1. Linting with `ansible-lint`
*   **MANDATORY**: All code must pass `ansible-lint` with zero warnings before merging.
*   Configuration is stored in `.ansible-lint` or `.config/ansible-lint.yml`.

```yaml
# .ansible-lint
---
# Disallow the use of command/shell
warn_list:
  - command-instead-of-module

# Enforce FQCN for all modules
enable_list:
  - fqcn[all]

# Exclude molecule scenarios from some rules
exclude_paths:
  - "molecule/"
```

### 2. Syntax Check
*   Always run `ansible-playbook --syntax-check` on new or modified playbooks.

### 3. Idempotency & State Testing with Molecule
*   **MANDATORY**: All roles **MUST** have Molecule tests.
*   Molecule provides a structured way to create a test instance, converge it with your role, verify its state, and destroy it.

```bash
# Inside a role directory
molecule init scenario default -d docker
molecule test
```
The `molecule test` command runs a full sequence: dependency, create, prepare, converge, idempotence, verify, destroy.

### 4. Dry Runs
*   **MUST** use `--check` (check mode) and `--diff` to see potential changes before applying them.

## 📊 Variable Management & Precedence

Understanding variable precedence is critical to avoiding bugs. The last loaded variable wins.
A simplified hierarchy from lowest to highest priority is:

1.  Role defaults (`roles/my_role/defaults/main.yml`).
2.  Inventory variables (`group_vars/`, `host_vars/`).
3.  Role variables (`roles/my_role/vars/main.yml`).
4.  Play variables (`vars:` section in a playbook).
5.  Extra vars passed on the command line (`-e "key=value"`).

**MANDATORY Rules:**
*   **MUST** define default values for all role variables in `defaults/main.yml`.
*   **MUST** use `group_vars` and `host_vars` to separate data (variables) from logic (tasks).
*   **NEVER** define a variable in more than one place unless you are intentionally overriding it according to precedence rules.

## 🚀 Performance Guidelines

*   **Fact Caching**: Enable fact caching to avoid redundant fact gathering on every run. Use Redis or a JSON file.
*   **SSH Pipelining**: Enable in `ansible.cfg` to reduce SSH connection overhead.
*   **Forks**: Increase the number of parallel processes (`forks`) in `ansible.cfg` for faster execution on multiple hosts.
*   **Execution Strategy**: For playbooks without cross-host dependencies, use `strategy: free` to avoid waiting for the slowest host.
*   **Async Tasks**: Use `async` and `poll` for long-running tasks that don't need to block the entire play.

```ini
# ansible.cfg
[defaults]
inventory = ./inventory/
roles_path = ./roles
forks = 20
gathering = smart
fact_caching = jsonfile
fact_caching_connection = ./.ansible_facts_cache
fact_caching_timeout = 86400

[ssh_connection]
pipelining = True
```

## ⚠️ CRITICAL GUIDELINES (MUST FOLLOW ALL)

1.  **ENFORCE Idempotency**: Every task, role, and playbook must be idempotent.
2.  **VALIDATE with `ansible-lint`**: Zero warnings or errors are permitted.
3.  **USE Ansible Vault**: No unencrypted secrets in the repository.
4.  **TEST with Molecule**: All roles must have a passing Molecule test scenario.
5.  **USE FQCN**: All module calls must use their Fully Qualified Collection Name.
6.  **AVOID `command` & `shell`**: Use dedicated modules whenever possible.
7.  **DOCUMENT Roles**: Every role **MUST** have a `meta/main.yml` with `author`, `description`, and dependencies.
8.  **USE Execution Environments**: Do not rely on system-wide or user-level Python environments.
9.  **SEPARATE Data from Logic**: Use `group_vars` and `host_vars` extensively.
10. **NAME Everything**: All plays and tasks must have a descriptive name.

## 📋 Pre-commit Checklist (MUST COMPLETE ALL)

- [ ] All YAML files are valid and pass a syntax check.
- [ ] `ansible-lint` passes with ZERO warnings or errors.
- [ ] Role passes `molecule test` sequence.
- [ ] All secrets are encrypted with Ansible Vault.
- [ ] `requirements.yml` is updated with any new collections.
- [ ] `execution-environment.yml` is updated with any new dependencies.
-   [ ] Playbook has been tested with `--check` and `--diff` modes.
-   [ ] All new variables have defaults defined in `defaults/main.yml`.
-   [ ] All tasks and plays have descriptive names.

### FORBIDDEN Practices
*   **NEVER** hardcode secrets in playbooks, templates, or variable files.
*   **NEVER** use `command` or `shell` when a specific module exists for the task.
*   **NEVER** disable `ansible-lint` rules without explicit justification and approval.
*   **NEVER** rely on implicit variable precedence; be explicit about where variables are defined.
*   **NEVER** use `latest` as the state for packages; pin to specific versions.
*   **NEVER** modify files directly in `/etc/ansible`; all configuration should be project-local in `ansible.cfg`.

---
_This guide is a living document. Update it as new patterns emerge and tools evolve._
_Focus on reliability and maintainability over clever, complex solutions._
_Last updated: August 2025_