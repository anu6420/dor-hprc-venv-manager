# dor-hprc-venv-manager

ModuLair - a Python virtual environment (venv) management tool suite
---

## Table of Contents
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Creating Environments](#creating-environments)
  - [Default Behavior](#default-behavior)
  - [Specify Python Version (-p flag)](#-p--specify-python-version)
  - [Custom Toolchain (-t flag)](#-t--custom-toolchain)
- [Managing Environments](#managing-environments)
  - [Listing Environments](#listing-environments)
  - [Activating an Environment](#activating-an-environment)
  - [Deleting an Environment](#deleting-an-environment)
- [Sharing Environments](#sharing-environments)
  - [Group Sharin (-g flag)](#group-sharing)
- [Key Features](#key-features)

---

## Installation
Clone this repository and run the `setup.sh` script. The ModuLair tools will be installed in a `bin` subdirectory.  
Add this `bin` directory to your `PATH` for convenience.

```bash
cd <directory of your choice>
git clone git@github.com:tamu-edu/dor-hprc-venv-manager.git ModuLair
cd ModuLair
./setup.sh
````

---

## Quick Start

```bash
create_venv newEnv -d "Cool new environment"
list_venvs
source activate_venv newEnv
delete_venv newEnv
```

**What happens:**

* Creates an environment named `newEnv` with a description
* Lists environments to verify creation
* Activates the environment
* Deletes it when no longer needed

---

## Creating Environments

### Default Behavior

ModuLair detects the current Python interpreter and compiler toolchain using EasyBuild by reading EBROOT-prefixed variables (e.g., EBROOTPYTHON, EBROOTGCCCORE).

```bash
create_venv my_env
```

It will:

* Detect loaded Python and compiler modules
* Record toolchain info in metadata
* Create a compatible environment

---

### -p — Specify Python Version

```bash
create_venv -p 3.11.5 my_env
```

* Skips EBROOT detection
* Uses toolchains to find matching GCCcore and dependencies
* Loads required modules
* Saves metadata for reproducibility

---

### -t — Custom Toolchain

```bash
create_venv -t "intelpython/2023b custom_module" my_env
```

* Records listed modules in metadata
* Auto-loads them during activation
* Useful for non-EasyBuild or custom HPC stacks

---

## Managing Environments

### Listing Environments

```bash
list_venvs
```

Displays:

* Name
* Description
* Python and GCCcore versions/toolchains
* Owner

**Metadata Source:**
`metadata.json` stored in:

* User registry (default: `$SCRATCH`)
* Group registry (via `-g`)

**Flags:**

* `-a` — List user and group environments
* `-u` — List user environments
* `-g` — List group environments
* `-n` — Names only

---

### Activating an Environment

```bash
source activate_venv my_env
```

* Loads modules from metadata
* Sources `bin/activate`

---

### Deleting an Environment

```bash
delete_venv my_env
```

* Removes the environment
* Updates registry
* Deletes related files

---

## Sharing Environments

### Group Sharing

```bash
create_venv -g my_group my_env
```

* Stores venv in group registry
* Accessible to all group members
* Works with `-p` or `-t`

---

## Key Features

* Automatic detection of Python & toolchains via EBROOT
* Customizable Python version or toolchain selection
* Shared environments for seamless collaboration
* Metadata-driven management for reproducibility and GUI integration
* Seamless activation with correct module loading

```

