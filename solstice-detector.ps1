# solstice-detector.ps1

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
        } catch {
            # モジュール情報取得できない場合は無視（権限不足やUWP制限）
        }
    }

    if ($found) {
        if (-not (Test-Path $flagPath)) {
            Add-Type -AssemblyName PresentationFramework
            [System.Windows.MessageBox]::Show('Solstice(1.21.100).dll が検出されました！','警告')
            New-Item $flagPath -ItemType File | Out-Null
        }
    }
    else {
        # 検出されなければフラグファイルを削除
        if (Test-Path $flagPath) {
            Remove-Item $flagPath
        }
    }
}
catch {
    Write-Output 'エラー: 権限不足かUWPアプリのためモジュール情報を取得できません'
}

# 終了前にEnter待ち（実行ウィンドウが閉じないように）
Read-Host "Enterキーを押して終了"
