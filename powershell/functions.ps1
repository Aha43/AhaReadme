
function New-Entry {
    param (
        [string]$Title
    )

    [string]$FileName = (($Title.Split([IO.Path]::GetInvalidFileNameChars()) -join '_' -replace ' ','_') + '.md')

    [string]$Date = (Get-Date -Format 'yyyyMMdd hh:mm')

    if (-not (Test-Path -Path './entries')) {
        mkdir 'entries'
    }
    Push-Location 'entries'

        ('[TOC (README)](../README.md)') | Out-File -FilePath $FileName  
        ('### ' + $Title) | Out-File -Append -FilePath $FileName 
        ($Date) | Out-File -Append -FilePath $FileName 
        (' ') | Out-File -Append -FilePath $FileName 

    Pop-Location
}

function Update-Readme {

    $Readme = 'README.md'
    ('') | Out-File -FilePath $Readme

    $EntryFiles = (Get-ChildItem -Path 'entries' | Where-Object { -not $_.PsIsContainer } | Sort-Object LastWriteTime -Descending)
    foreach ($File in $EntryFiles) {
        Write-Host ('Processing ' + $File.Name)

        $Content = Get-Content -Path $File.FullName
        $Title = $Content[1].Substring(4)
        $Date = $Content[2].Trim()
        Write-Host ('  Title: ' + $Title)
        Write-Host ('  Date: ' + $Date)

        ($Date + ' **[' + $Title + '](./entries/' + $File.Name + ')**') | Out-File -FilePath $Readme -Append

    }
}
