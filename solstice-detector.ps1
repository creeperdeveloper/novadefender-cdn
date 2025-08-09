$flagPath = 'C:\Users\Public\solstice_detected.flag'

try {
    $found = $false
    $processes = Get-Process -Name Minecraft.Windows -ErrorAction Stop
    foreach ($proc in $processes) {
        try {
            foreach ($mod in $proc.Modules) {
                if ($mod.ModuleName -eq 'Solstice(1.21.100).dll') {
                    $found = $true
                    break
                }
            }
            if ($found) { break }
        } catch {}
    }

    if ($found) {
        if (-not (Test-Path $flagPath)) {
            Add-Type -AssemblyName PresentationFramework
            [System.Windows.MessageBox]::Show('Solstice(1.21.100).dll detected!', 'Warning')
            New-Item $flagPath -ItemType File | Out-Null
        }
    } else {
        if (Test-Path $flagPath) { Remove-Item $flagPath }
    }
} catch {
    Write-Output 'Error: Could not access process modules. Insufficient permissions or UWP app.'
}

Read-Host "Press Enter to exit"
