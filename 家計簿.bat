@echo off
:: 家計簿 — Desktop Launcher
:: Opens the app as a standalone window using Chrome's --app flag.
:: If Chrome is not found, falls back to the default browser.

setlocal

set "FILE=%~dp0index.html"
set "URL=file:///%FILE:\=/%"

:: Try Google Chrome first (--app flag removes browser chrome for a desktop-app feel)
set "CHROME="
for %%P in (
  "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
  "%LocalAppData%\Google\Chrome\Application\chrome.exe"
) do (
  if exist %%P set "CHROME=%%P"
)

if defined CHROME (
  echo Starting 家計簿 in app mode...
  start "" %CHROME% --app="%URL%" --window-size=480,900 --window-position=100,50
) else (
  :: Try Microsoft Edge as fallback
  set "EDGE="
  for %%P in (
    "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
    "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
  ) do (
    if exist %%P set "EDGE=%%P"
  )

  if defined EDGE (
    echo Starting 家計簿 in app mode via Edge...
    start "" %EDGE% --app="%URL%" --window-size=480,900 --window-position=100,50
  ) else (
    echo Chrome/Edge not found. Opening in default browser...
    start "" "%URL%"
  )
)

endlocal
