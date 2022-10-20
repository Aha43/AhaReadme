
function New-Entry {
    param (
        [string]$Title
    )

    [string]$FileName = (($Title.Split([IO.Path]::GetInvalidFileNameChars()) -join '_' -replace ' ','_') + '.md')

    [string]$Date = (Get-Date -Format 'yyyyMMdd')

    Write-Host $FileName
    Write-Host $Date

    if (-not (Test-Path -Path './entries')) {
        mkdir 'entries'
    }
    Push-Location 'entries'

        ('### ' + $Title) | Out-File -FilePath $FileName 
        ($Date) | Out-File -Append -FilePath $FileName 
        (' ') | Out-File -Append -FilePath $FileName 

    Pop-Location
    
}