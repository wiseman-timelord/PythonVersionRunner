# PythonVersionRunner
Status: ALPHA. Conceptual, testing not advised currently, work is currently...
- Check, powershell system folder update and Batch search and launch code.
- Dark cube must be safe, setup second computer for windows, and test/improve/optimize. .

### Description:
A project to create some code, to insert into batch scripts, to ensure that the correct version of python is loading the script.The batch script detects the specified Python version on the system, launches a PowerShell script to update the environment variables for that Python version, and then runs a Python script using the correct Python interpreter. The PowerShell script checks for administrator rights, lists available Python versions, updates the system's environment variables to point to the selected Python version, and saves or restores these settings as needed.
