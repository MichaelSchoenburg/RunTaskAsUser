
NAME
    RunTaskAsUser.ps1
    
SYNOPSIS
    This Script runs a task in the context of another UserName.
    
    
SYNTAX
    C:\Users\mschoenburg.CENTER\Desktop\RunTaskAsUser.ps1 [-UserName] <String> [-PathToFile] <String> [[-Arguments] <String>] [-Computer <String>] [<CommonParameters>]
    
    
DESCRIPTION
    This Script uses the task scheduler to create a new task in the context of specified UserName, runs it immediately after and deletes it in the end.
    

PARAMETERS
    -UserName <String>
        The UserName in whose context the File should be executed.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -PathToFile <String>
        The File that is to be executed
        
        Required?                    true
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Arguments <String>
        The Arguments that should be passed along to the File.
        
        Required?                    false
        Position?                    3
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Computer <String>
        The computer/server this should happen on.
        Defaults to localhost.
        
        Required?                    false
        Position?                    named
        Default value                ($env:computername)
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    See parameters.
OUTPUTS
    None.
    
    
NOTES
    
    
        Author: Michael Schönburg
        Current version: 0.1
        Last change: 08.06.2021
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>& 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\TMP\screenshot.lnk' -Computer 'My-RDS-01'
    This runs the link screenshot.lnk in the context of the UserName mschoenburg on the terminal server My-RDS-01.
    
    
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>& 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\TMP\MyProgram.exe'
    This would be executed on the local machine.
    
    
    
    
    
    
    -------------------------- EXAMPLE 3 --------------------------
    
    PS C:\>& 'C:\TMP\RunTaskAsUserName.ps1' -UserName 'mschoenburg' -PathToFile 'C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE' -Arguments '/safe'
    This would start outlook in safe mode.
    
    
    
    
    
    
    
