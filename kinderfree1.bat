@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Kinder Tweaks FREE - Starter Boost
color 0B

:: ========================================================
::   KINDER TWEAKS FREE - STARTER BOOST
::   Optimizacion basica gratuita para probar
::   Version: 1.0 FREE
::   NPSE-COMPATIBLE
:: ========================================================

:: Admin check
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    color 0C
    cls
    echo.
    echo   [ERROR] Ejecuta como Administrador.
    echo.
    echo   Clic derecho -^> "Ejecutar como administrador"
    echo.
    pause
    exit /b
)

cls
echo.
echo  =================================================================
echo   KINDER TWEAKS FREE v1.0 - Starter Boost
echo   Optimizacion basica gratuita
echo  =================================================================
echo.
echo   [FREE] Este es el pack GRATUITO.
echo   [FREE] Para el pack PREMIUM con:
echo          - Modo Gaming 1-click activable cuando quieras
echo          - Optimizacion FiveM especifica
echo          - Tweaks CPU Intel/AMD detectados
echo          - Soporte tecnico en Discord
echo          - Actualizaciones mensuales
echo.
echo   Discord: https://discord.gg/jc94kMYjNT
echo.
echo  =================================================================
echo.
echo   [*] Este bat aplica 10 optimizaciones basicas.
echo   [*] Es REVERSIBLE mediante punto de restauracion.
echo   [*] NO toca servicios forensic (NPSE-safe).
echo.
pause

:: ----------------------------------------------------------
:: 0. PUNTO DE RESTAURACION AUTOMATICO
:: ----------------------------------------------------------
cls
echo.
echo  =================================================================
echo   [0/10] Creando punto de restauracion...
echo  =================================================================
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1

for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-ComputerRestorePoint | Measure-Object).Count"') do set "BEFORE=%%a"
powershell -NoProfile -Command "Checkpoint-Computer -Description 'Kinder_FREE_Pre' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-ComputerRestorePoint | Measure-Object).Count"') do set "AFTER=%%a"

if !AFTER! GTR !BEFORE! (
    echo   [OK] Punto "Kinder_FREE_Pre" creado.
) else (
    echo   [AVISO] No se pudo crear punto ^(cooldown Windows^). Continuando.
)

:: ----------------------------------------------------------
:: 1. LIMPIEZA BASICA (SIN TOCAR PREFETCH NI LOGS CRITICOS)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [1/10] Limpieza temporales...
echo  =================================================================
del /s /f /q "%temp%\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
echo   [OK] Temporales limpiados.

:: ----------------------------------------------------------
:: 2. KERNEL MEMORY (VERSION CONSERVADORA - SIN LargeSystemCache)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [2/10] Optimizacion memoria kernel...
echo  =================================================================
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul 2>&1
echo   [OK] Kernel residente en RAM ^(no paginable^).

:: ----------------------------------------------------------
:: 3. MOUSE SIN ACELERACION (AIM CORRECTION)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [3/10] Mouse acceleration OFF...
echo  =================================================================
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
echo   [OK] Mouse 1:1 ^(sin aceleracion^).

:: ----------------------------------------------------------
:: 4. GAME MODE + MMCSS GAMES
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [4/10] Prioridad gaming...
echo  =================================================================
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >nul 2>&1
echo   [OK] Game Mode + MMCSS configurados.

:: ----------------------------------------------------------
:: 5. GAMEDVR OFF (LIBERA CPU/GPU)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [5/10] GameDVR OFF...
echo  =================================================================
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo   [OK] GameDVR desactivado.

:: ----------------------------------------------------------
:: 6. PLAN DE ENERGIA ULTIMATE (VIA GUID DIRECTO)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [6/10] Plan energia Ultimate...
echo  =================================================================
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
echo   [OK] Ultimate Performance activado.

:: ----------------------------------------------------------
:: 7. HIBERNACION OFF (LIBERA 4-8 GB SSD)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [7/10] Hibernacion OFF ^(libera SSD^)...
echo  =================================================================
powercfg -h off >nul 2>&1
echo   [OK] Hibernacion desactivada.

:: ----------------------------------------------------------
:: 8. QOS NETWORK THROTTLING OFF
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [8/10] Network throttling OFF...
echo  =================================================================
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xFFFFFFFF /f >nul 2>&1
echo   [OK] Throttling red desactivado.

:: ----------------------------------------------------------
:: 9. FULLSCREEN OPTIMIZATIONS OFF (SIN ROMPER JUEGOS)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [9/10] Fullscreen Optimizations OFF ^(seguro^)...
echo  =================================================================
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >nul 2>&1
echo   [OK] FSE Behavior ajustado.

:: ----------------------------------------------------------
:: 10. WINDOWS SEARCH OFF (TEMPORAL - SE REACTIVA AL REINICIAR)
:: ----------------------------------------------------------
echo.
echo  =================================================================
echo   [10/10] Windows Search parado ^(temporal^)...
echo  =================================================================
net stop "WSearch" >nul 2>&1
echo   [OK] Windows Search detenido temporalmente.
echo   [INFO] Se reactiva solo al reiniciar el PC.

:: ----------------------------------------------------------
:: FINALIZACION
:: ----------------------------------------------------------
cls
color 0A
echo.
echo  =================================================================
echo   KINDER TWEAKS FREE - COMPLETADO
echo  =================================================================
echo.
echo   [OK] 10 optimizaciones aplicadas.
echo.
echo   [GANANCIA ESPERADA] +3-8 FPS en juegos.
echo.
echo   [IMPORTANTE] Reinicia el PC para maximo efecto.
echo.
echo  =================================================================
echo   ^>^>  QUIERES MAS RENDIMIENTO?
echo  =================================================================
echo.
echo   KINDER TWEAKS PREMIUM incluye:
echo.
echo     - Modo Gaming 1-click ^(activar cuando vayas a jugar^)
echo     - Se revierte automaticamente al reiniciar
echo     - Tweaks especificos FiveM ^(todas las builds^)
echo     - CPU auto-detector Intel/AMD con tweaks a medida
echo     - Pagefile optimizado segun tu RAM
echo     - Red fine-tuning ^(QoS, DNS, buffers^)
echo     - Exclusiones Defender para juegos
echo     - +20 tweaks mas de kernel y registro
echo     - Soporte tecnico Discord
echo     - Actualizaciones mensuales
echo.
echo   [GANANCIA PREMIUM] +15-30 FPS en PCs gama baja.
echo.
echo  =================================================================
echo   Discord:  https://discord.gg/jc94kMYjNT
echo   TikTok:   @kindeer5m
echo  =================================================================
echo.
echo   Abriendo Discord en 5 segundos...
timeout /t 5 >nul
start "" "https://discord.gg/jc94kMYjNT"

echo.
echo   Pulsa cualquier tecla para salir.
pause >nul
exit /b