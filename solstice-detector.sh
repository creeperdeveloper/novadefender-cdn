powershell.exe -NoExit -Command ^
"$flag='C:\Users\Public\horion_notified.flag';" ^
"try {" ^
"  $found = $false;" ^
"  $proc = Get-Process -Name Minecraft.Windows -ErrorAction Stop;" ^
"  foreach ($p in $proc) {" ^
"    try {" ^
"      $mods = $p.Modules -ErrorAction Stop;" ^
"      foreach ($m in $mods) {" ^
"        if ($m.ModuleName -eq 'Solstice(1.21.100).dll') {" ^
"          $found = $true;" ^
"          break" ^
"        }" ^
"      }" ^
"    } catch {}" ^
"    if ($found) { break }" ^
"  }" ^
"  if ($found) {" ^
"    if (-not (Test-Path $flag)) {" ^
"      Add-Type -AssemblyName PresentationFramework;" ^
"      [System.Windows.MessageBox]::Show('Solstice(1.21.100).dllが検出されました！','警告');" ^
"      New-Item $flag -ItemType File | Out-Null;" ^
"    }" ^
"  } else {" ^
"    if (Test-Path $flag) { Remove-Item $flag }" ^
"  }" ^
"} catch {" ^
"  Write-Output 'エラー: 権限不足かUWPアプリのためモジュール情報を取得できません'" ^
"};" ^
"pause"
