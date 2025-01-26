#!/bin/bash
# This script will create a virtual environment for Python
echo 
clear
echo "************************************************"
echo "* Welcome to HPRC's Python Environment Creator *"
echo "************************************************"
echo "Make sure you have already loaded the proper modules required for your Python application. To search for which versions of Python are available, please use the \"module spider Python\" command."
echo "You are currently running the following version of python: "
echo
python3 --version
echo
read -p "If your desired version of Python is already loaded, press enter. If not, press ctrl + C to exit." x
echo
read -p "Please enter the name of your new Environment without spaces or special characters: " venv_name 
echo

venv_path="$SCRATCH/virtual_envs/$venv_name"

echo
clear
echo "Creating virtual environment $venv_name in your scratch directory, with system site packages. This may take a minute."

# Create venv
python3 -m venv --system-site-packages $venv_path

echo

# Activate venv for the user
venv_activate="$venv_path/bin/activate"
source $venv_activate
pip install --upgrade pip

echo
clear
echo "If your Python Evironment has been created and activated succefully, you will see ($venv_name) in front of your bash profile. You may now pip install any packages you may need."
echo
echo "Note: To exit your virtual environment you need to use the following command: "
echo
echo "   deactivate"
echo
echo "Use the following command in your job files and your terminal to activate your virtual environment: "
echo
echo "   source $venv_path/bin/activate"
echo
echo "Note: You will need to load all required modules every time you are activating your virtual environment."
echo
