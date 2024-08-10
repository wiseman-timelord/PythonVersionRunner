# PythonVersionRunner
Status: ALPHA. Conceptual, testing not advised currently, it will potentially break your registry. work is currently...
- Powershell system folder update script has not been worked on since being created as standalone some time ago. Needs analysis, then decide direction for streamlining and coordination with the batch.
- Batch search and launch code, analyze and determine if everything looks correct, consolidate sections, improve comments.
- Dark cube must be safe, setup second computer for windows, and test there for this project .

### Description:
A project to create some code, to insert into batch scripts, to ensure that the correct version of python is loading the script.The batch script detects the specified Python version on the system, launches a PowerShell script to update the environment variables for that Python version, and then runs a Python script using the correct Python interpreter. The PowerShell script checks for administrator rights, lists available Python versions, updates the system's environment variables to point to the selected Python version, and saves or restores these settings as needed. 

# Usage:
- As I said, do not run this code, it is considered dangerous at this stage of developing scripts that have the potential of altering your registry.
- The one that does the batch env only could potentially work at this stage, so long as the relating python.exe script uses that form of PYTHON definition. 

# Disclaimer:
- If you run this code, when I advised not to, then that is not the fault of Wiseman-Timelord.
