<#
.SYNOPSIS
    This Script runs a task in the context of another UserName.
.DESCRIPTION
    This Script uses the task scheduler to create a new task in the context of specified UserName, runs it immediately after and deletes it in the end.
.PARAMETER UserName
    The UserName in whose context the File should be executed.
.PARAMETER PathToFile
    The File that is to be executed
.PARAMETER Args
    The Arguments that should be passed along to the File.
.PARAMETER Computer
    The computer/server this should happen on.
    Defaults to localhost.
.OUTPUTS
    None.
.EXAMPLE
    PS C:\> & 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\TMP\screenshot.lnk' -Computer 'My-RDS-01'
    This runs the link screenshot.lnk in the context of the UserName mschoenburg on the terminal server My-RDS-01.
.EXAMPLE
    PS C:\> & 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\TMP\screenshot.lnk'
    This would be executed on the local machine.
.EXAMPLE
    PS C:\> & 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE' -Arguments '/resetsharedfolders'
    This would be executed on the local machine.
.NOTES
    Author: Michael Schönburg
    Current version: 0.1
    Last change: 08.06.2021
#>

param (
    # The UserName in whose context the File should be executed.
    [Parameter(
        Mandatory = $true,
        Position = 0
    )]
    [ParameterType]
    $UserName,

    # The File that is to be executed.
    [Parameter(
        Mandatory = $true,
        Position = 1
    )]
    [string]
    $PathToFile,

    # The Arguments that should be passed along to the File.
    [Parameter(
        Mandatory = $true,
        Position = 2
    )]
    [string]
    $Arguments,

    # The computer/server this should happen on.
    [Parameter(
        Mandatory = $false
    )]
    [string]
    $Computer = ($env:computername)
)

$ScriptTask =
{
 
    param (
        [string]$userName,
        [string]$pathToFile,
        [string]$arguments
     )
 
    #Action
    if ($arguments.Length -gt 0) {
        $action = New-ScheduledTaskAction –Execute $PathToFile -Argument $arguments
    } else {
        $action = New-ScheduledTaskAction –Execute $PathToFile
    }
 
    # Principal
    $p = New-ScheduledTaskPrincipal -UserNameId $UserName -LogonType Interactive -ErrorAction Ignore
 
    # Settings
    $s = New-ScheduledTaskSettingsSet -MultipleInstances Parallel -Hidden
 
    # Create the task.
    task = New-ScheduledTask -Action $Action -Settings $S -Principal $P
 
    # Unregister the old task if there is one that hasn't been cleaned up.
    Unregister-ScheduledTask -TaskName 'TEMPTASK' -ErrorAction Ignore -Confirm:$false
 
    # Register the task.
    Register-ScheduledTask -InputObject $task -TaskPath '\KD\' -TaskName 'TEMPTASK'
 
    # Execute the task.
    Get-ScheduledTask -TaskName 'TEMPTASK' -TaskPath '\KD\' | Start-ScheduledTask
 
    # Unregister the task.
    Unregister-ScheduledTask -TaskName 'TEMPTASK' -ErrorAction Ignore -Confirm:$false
}
 
Invoke-PathToFile -ComputerName $Computer -ScriptBlock $ScriptTask -ArgumentList $UserName, $PathToFile, $Arguments
