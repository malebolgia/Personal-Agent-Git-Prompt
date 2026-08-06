function sgu {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$ProfileName
    )

    powershell -ExecutionPolicy Bypass -File "$PSScriptRoot\sgu.ps1" $ProfileName
}