param(
    [Parameter(Mandatory=$true)][string]$MapJson
)

$ErrorActionPreference = "Stop"

$docPath = (Resolve-Path "DK24TTK2- bao cao_NguyenVanKhanh.doc").Path
$map = ConvertFrom-Json -InputObject ([System.IO.File]::ReadAllText((Resolve-Path $MapJson), [System.Text.Encoding]::UTF8)
)

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$doc = $word.Documents.Open($docPath, $false, $false)

$visible = 0
foreach ($p in $doc.Paragraphs) {
    $text = ($p.Range.Text -replace "`r|`a", "").Trim()
    if ($text.Length -gt 0) {
        $visible++
        foreach ($item in $map) {
            if ([int]$item.index -eq $visible) {
                $range = $p.Range
                $range.End = $range.End - 1
                try {
                    $range.Text = [string]$item.text
                } catch {
                    Write-Host "Skip ${visible}: $($_.Exception.Message)"
                }
                break
            }
        }
    }
}

$doc.Save()
$doc.Close($true)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($doc) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
