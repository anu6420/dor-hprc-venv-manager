# dor-hprc-venv-manager
Python virtual environment (venv) management tool suite

# Installation
Clone this repository into a root directory of choice. The scripts will be installed in a "bin" subfolder of this directory.
Then, run the *setup.sh* script in the root directory to run the installation the scripts.
```bash
$ cd /sw/local
$ git clone git@github.com:tamu-edu/dor-hprc-venv-manager.git
$ ./setup.sh
```

# Usage
The lifecycle of a virtual environment on the context of these tools is shown in the commands below. 
```bash
$ create_venv newEnv -d "Cool new environment" -p 3.12
$ list_venvs
$ source activate_venv newEnv
$ delete_venv newEnv
```
This example creates a new environment called *newEnv* with Python version 3.12.0 and an apt description. Then, the user's environment's are listed to confirm successful creation and the venv is activated. After it is no longer needed, the venv is deleted. 
