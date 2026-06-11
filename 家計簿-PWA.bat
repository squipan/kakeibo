@echo off
:: 家計簿 — PWA Server Launcher
:: Starts a local HTTP server so the Service Worker and PWA install work correctly.
:: Requires Node.js to be installed (https://nodejs.org).

setlocal
set "DIR=%~dp0"

echo ============================================
echo  家計簿 Household Finance — PWA Launcher
echo ============================================
echo.

:: Check for Node.js
where node >nul 2>&1
if %errorlevel% neq 0 (
  echo [ERROR] Node.js is not installed or not in PATH.
  echo Please install Node.js from https://nodejs.org
  echo.
  echo Falling back to file:// mode (PWA features limited)...
  call "%DIR%家計簿.bat"
  exit /b
)

:: Use npx http-server to serve the directory on localhost:8080
echo Starting local server at http://localhost:8080 ...
echo Press Ctrl+C to stop the server.
echo.

:: Open the browser first (slight delay to let server start)
timeout /t 2 /nobreak >nul

set "CHROME="
for %%P in (
  "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
  "%LocalAppData%\Google\Chrome\Application\chrome.exe"
) do (
  if exist %%P set "CHROME=%%P"
)

if defined CHROME (
  start "" %CHROME% --app="http://localhost:8080" --window-size=480,900 --window-position=100,50
) else (
  start "" "http://localhost:8080"
)

:: Now start the server (blocking)
cd /d "%DIR%"
npx -y http-server . -p 8080 -c-1 --cors

endlocal
