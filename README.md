# dor-hprc-venv-manager
ModuLair - a Python virtual environment (venv) management tool suite

# Installation
Clone this repository into a directory of your choice. Once cloned, enter the repo directory and run the **setup.sh** script. The ModuLair scripts will be installed in a bin sub-directory.
We suggest adding this bin directory to the PATH environment variable for more convenient use.
```bash
$ cd <directory of your choice>
$ git clone git@github.com:tamu-edu/dor-hprc-venv-manager.git ModuLair
$ cd ModuLair
$ ./setup.sh
```

# Usage
The lifecycle of a virtual environment on the context of these tools is shown in the commands below. 
```bash
$ create_venv newEnv -d "Cool new environment"
$ list_venvs
$ source activate_venv newEnv
$ delete_venv newEnv
```
This example creates a new environment called **newEnv** with an apt description. Then, the user's environments are listed to confirm successful creation and the venv is activated. After it is no longer needed, the venv is deleted. 
