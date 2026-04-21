@echo off
chcp 65001 >nul
echo ========================================
echo  Subiendo archivos a GitHub...
echo ========================================
echo.

set BASE=C:\Users\info\Documents\Claude\Projects\TSI-Sovereign195
set OWNER=calory89
set REPO=tsi-sovereign195
set TOKEN=PON_TOKEN_AQUI

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$t='%TOKEN%';$b='%BASE%';$o='%OWNER%';$r='%REPO%';" ^
"$h=@{'Authorization'=\"token $t\";'Accept'='application/vnd.github.v3+json';'Content-Type'='application/json'};" ^
"$files='web/sovereign195/index.html','web/sovereign195/privacy.html','web/sovereign195/cookies.html','web/sovereign195/terms.html','web/sovereign195/thank-you.html','web/sovereign195/seats.json','web/thestartupisland/index.html','web/thestartupisland/privacy.html','web/thestartupisland/cookies.html','web/thestartupisland/terms.html';" ^
"foreach($f in $files){$lp=\"$b\"+'\'+($f-replace'/','\');if(!(Test-Path $lp)){Write-Host \"SKIP: $f\" -Fore Yellow;continue};$b64=[Convert]::ToBase64String([IO.File]::ReadAllBytes($lp));$url=\"https://api.github.com/repos/$o/$r/contents/$f\";$sha=$null;try{$sha=(Invoke-RestMethod $url -Headers $h).sha}catch{};$body=@{message=\"Add $f\";content=$b64};if($sha){$body['sha']=$sha};try{Invoke-RestMethod $url -Method Put -Headers $h -Body($body|ConvertTo-Json)|Out-Null;Write-Host \"OK: $f\" -Fore Green}catch{Write-Host \"ERR: $f - $_\" -Fore Red}}"

echo.
echo ========================================
echo  Listo! Pulsa una tecla para cerrar.
echo ========================================
pause
