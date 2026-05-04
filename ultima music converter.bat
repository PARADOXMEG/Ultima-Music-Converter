@echo off
:: Enable UTF-8 to correctly read Japanese, Emojis, and box characters
chcp 65001 >nul
setlocal disabledelayedexpansion

:: Enable ANSI colors and escape sequences for Windows 10/11 terminals
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:menu
cls
echo %ESC%[96m╔═════════════════════════════════════════════════════════════╗%ESC%[0m
echo %ESC%[96m║%ESC%[0m                   %ESC%[1m%ESC%[92mULTIMA MUSIC CONVERTER%ESC%[0m                    %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m                     (Powered by ffmpeg)                     %ESC%[96m║%ESC%[0m
echo %ESC%[96m╠═════════════════════════════════════════════════════════════╣%ESC%[0m
echo %ESC%[96m║%ESC%[0m %ESC%[97mSelect the conversion type you want to perform:%ESC%[0m             %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m                                                             %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m1.%ESC%[0m FLAC to MP3    %ESC%[90m(Max Quality: 320kbps CBR)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m2.%ESC%[0m FLAC to M4A    %ESC%[90m(Max Quality: 320kbps AAC)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m3.%ESC%[0m FLAC to Opus   %ESC%[90m(Max Quality: 320kbps)%ESC%[0m                   %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m4.%ESC%[0m MP3 to Opus    %ESC%[90m(Max Quality: 320kbps)%ESC%[0m                   %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m5.%ESC%[0m MP3 to M4A     %ESC%[90m(Max Quality: 320kbps AAC)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m6.%ESC%[0m M4A to MP3     %ESC%[90m(Max Quality: 320kbps CBR)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m7.%ESC%[0m M4A to Opus    %ESC%[90m(Max Quality: 320kbps)%ESC%[0m                   %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m8.%ESC%[0m Opus to M4A    %ESC%[90m(Max Quality: 320kbps AAC)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[93m9.%ESC%[0m Opus to MP3    %ESC%[90m(Max Quality: 320kbps CBR)%ESC%[0m               %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m %ESC%[93m10.%ESC%[0m MP3 to FLAC    %ESC%[90m(Lossless wrapping)%ESC%[0m                      %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m %ESC%[93m11.%ESC%[0m Opus to FLAC   %ESC%[90m(Lossless wrapping)%ESC%[0m                      %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m %ESC%[93m12.%ESC%[0m M4A to FLAC    %ESC%[90m(Lossless wrapping)%ESC%[0m                      %ESC%[96m║%ESC%[0m
echo %ESC%[96m╚═════════════════════════════════════════════════════════════╝%ESC%[0m
echo.

set /p choice="%ESC%[97mEnter your choice (1-12): %ESC%[0m"

:: Define Codecs
set "SRC="
if "%choice%"=="1"  (set "SRC=flac" & set "DST=mp3" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k")
if "%choice%"=="2"  (set "SRC=flac" & set "DST=m4a" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k")
if "%choice%"=="3"  (set "SRC=flac" & set "DST=opus" & set "CODEC=-map 0:a -map_metadata 0 -c:a libopus -b:a 320k")
if "%choice%"=="4"  (set "SRC=mp3"  & set "DST=opus" & set "CODEC=-map 0:a -map_metadata 0 -c:a libopus -b:a 320k")
if "%choice%"=="5"  (set "SRC=mp3"  & set "DST=m4a" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k")
if "%choice%"=="6"  (set "SRC=m4a"  & set "DST=mp3" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k")
if "%choice%"=="7"  (set "SRC=m4a"  & set "DST=opus" & set "CODEC=-map 0:a -map_metadata 0 -c:a libopus -b:a 320k")
if "%choice%"=="8"  (set "SRC=opus" & set "DST=m4a" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k")
if "%choice%"=="9"  (set "SRC=opus" & set "DST=mp3" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k")
if "%choice%"=="10" (set "SRC=mp3"  & set "DST=flac" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a flac")
if "%choice%"=="11" (set "SRC=opus" & set "DST=flac" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a flac")
if "%choice%"=="12" (set "SRC=m4a"  & set "DST=flac" & set "CODEC=-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a flac")

if "%SRC%"=="" (
    echo %ESC%[91m[!] Invalid choice. Please try again.%ESC%[0m
    timeout /t 2 >nul
    goto menu
)

echo.
:thread_select
set /p MaxThreads="%ESC%[97mEnter number of parallel tasks (1-5): %ESC%[0m"
if %MaxThreads% LSS 1 goto thread_select
if %MaxThreads% GTR 5 goto thread_select

echo.
set /p TARGET_DIR="%ESC%[97mEnter target directory path (leave blank for current): %ESC%[0m"
if "%TARGET_DIR%"=="" set "TARGET_DIR=%CD%"
if "%TARGET_DIR:~-1%"=="\" set "TARGET_DIR=%TARGET_DIR:~0,-1%"

if not exist "%TARGET_DIR%\" (
    echo %ESC%[91m[!] Error: The specified path does not exist.%ESC%[0m
    pause
    exit /b
)

:: FAST PASS: Count total files using dir
set "TotalFiles=0"
for /f %%A in ('dir /b /s /a-d "%TARGET_DIR%\*.%SRC%" 2^>nul ^| find /c /v ""') do set "TotalFiles=%%A"

if %TotalFiles% EQU 0 (
    echo %ESC%[91m[!] Error: No .%SRC% files found.%ESC%[0m
    pause
    exit /b
)

:: Prepare Temporary Directory for Queue Management
set "LOCK_DIR=%TEMP%\AudioConverterQueue"
if exist "%LOCK_DIR%" rmdir /s /q "%LOCK_DIR%"
mkdir "%LOCK_DIR%"

cls
echo %ESC%[96m╔═════════════════════════════════════════════════════════════╗%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[1m%ESC%[92mSTARTING PARALLEL CONVERSION:%ESC%[0m %ESC%[97m.%SRC% --^> .%DST%%ESC%[0m             %ESC%[96m║%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[90mTarget: "%TARGET_DIR%"%ESC%[0m
echo %ESC%[96m║%ESC%[0m  %ESC%[90mFiles: %TotalFiles%   ^|   Max Threads: %MaxThreads%%ESC%[0m
echo %ESC%[96m╚═════════════════════════════════════════════════════════════╝%ESC%[0m
echo %ESC%[?25l
:: Print initial empty lines to establish HUD canvas
echo.
echo.

set "SpawnedJobs=0"
set "SpinIdx=0"

:: Process files recursively
for /f "delims=" %%F in ('dir /b /s /a-d "%TARGET_DIR%\*.%SRC%" 2^>nul') do (
    call :WaitQueue
    call :SpawnJob "%%F"
)

:: Wait for final background tasks to complete
call :FinalWait

:: Tally Errors
set "FailedFiles=0"
for /f %%A in ('dir /b /a-d "%LOCK_DIR%\*.err" 2^>nul ^| find /c /v ""') do set "FailedFiles=%%A"

:: Final Completion UI
echo %ESC%[2A%ESC%[2K
if %FailedFiles% GTR 0 (
    echo %ESC%[91m[!] Completed with errors: %FailedFiles% file(s) failed to convert.%ESC%[0m
) else (
    echo %ESC%[92m[SUCCESS] All %TotalFiles% files converted flawlessly!%ESC%[0m
)
echo %ESC%[2K%ESC%[96m Progress: [%ESC%[92m████████████████████████████████████████%ESC%[96m] 100%% (%TotalFiles%/%TotalFiles%)%ESC%[0m
echo.
echo %ESC%[96m═══════════════════════════════════════════════════════════════%ESC%[0m
echo.

:: Cleanup and Exit
rmdir /s /q "%LOCK_DIR%" 2>nul
echo %ESC%[?25h
pause
exit /b

:: ==========================================
:: BACKGROUND TASK MANAGER
:: ==========================================

:WaitQueue
setlocal enabledelayedexpansion
:wq_loop
set "ActiveJobs=0"
for /f %%A in ('dir /b /a-d "%LOCK_DIR%\*.lock" 2^>nul ^| find /c /v ""') do set "ActiveJobs=%%A"

set /a Completed=SpawnedJobs - ActiveJobs
set /a pct=(Completed * 100) / TotalFiles
set /a filled=(pct * 40) / 100
set /a empty=40 - filled

:: Generate Two-Tone Progress Bar
set "bar_filled="
set "bar_empty="
if !filled! GTR 0 for /L %%A in (1,1,!filled!) do set "bar_filled=!bar_filled!█"
if !empty! GTR 0 for /L %%A in (1,1,!empty!) do set "bar_empty=!bar_empty!░"

:: Advance Spinner Animation
set /a SpinIdx=(SpinIdx+1) %% 4
if !SpinIdx! EQU 0 set "SpinChar=|"
if !SpinIdx! EQU 1 set "SpinChar=/"
if !SpinIdx! EQU 2 set "SpinChar=-"
if !SpinIdx! EQU 3 set "SpinChar=\"

:: Render HUD (Move cursor UP 2 lines, clear line, and overwrite)
echo !ESC![2A!ESC![2K!ESC![93m [!SpinChar!] Active Threads: !ActiveJobs! / %MaxThreads%!ESC![0m
echo !ESC![2K!ESC![96m Progress: [!ESC![92m!bar_filled!!ESC![90m!bar_empty!!ESC![96m] !pct!%% (!Completed!/%TotalFiles%)!ESC![0m

if !ActiveJobs! GEQ %MaxThreads% (
    timeout /t 1 /nobreak >nul
    goto wq_loop
)
endlocal & set "SpinIdx=%SpinIdx%"
exit /b

:SpawnJob
set /a SpawnedJobs+=1
:: Safely grab the file paths without expanding special characters yet
setlocal disabledelayedexpansion
set "IN_FILE=%~1"
set "OUT_FILE=%~dpn1.%DST%"

:: Enable delayed expansion safely write the temporary worker script
setlocal enabledelayedexpansion
set "JOB_FILE=%LOCK_DIR%\job_!SpawnedJobs!.cmd"
set "LOCK_FILE=%LOCK_DIR%\!SpawnedJobs!.lock"

echo 1 > "!LOCK_FILE!"
echo @echo off> "!JOB_FILE!"
echo chcp 65001 ^>nul>> "!JOB_FILE!"
:: Suppress all output so background workers don't destroy the main UI
echo ffmpeg -y -v error -i "!IN_FILE!" !CODEC! "!OUT_FILE!" ^>nul 2^>nul>> "!JOB_FILE!"
:: If success, delete original. If fail, write an error file for the tally.
echo if %%ERRORLEVEL%% EQU 0 ^( del "!IN_FILE!" ^) else ^( echo 1 ^> "%LOCK_DIR%\!SpawnedJobs!.err" ^)>> "!JOB_FILE!"
:: Worker deletes its own lock when finished
echo del "!LOCK_FILE!">> "!JOB_FILE!"

start "" /B cmd /c "!JOB_FILE!"
endlocal
endlocal
exit /b

:FinalWait
setlocal enabledelayedexpansion
:fw_loop
set "ActiveJobs=0"
for /f %%A in ('dir /b /a-d "%LOCK_DIR%\*.lock" 2^>nul ^| find /c /v ""') do set "ActiveJobs=%%A"

set /a Completed=SpawnedJobs - ActiveJobs
set /a pct=(Completed * 100) / TotalFiles
set /a filled=(pct * 40) / 100
set /a empty=40 - filled

set "bar_filled="
set "bar_empty="
if !filled! GTR 0 for /L %%A in (1,1,!filled!) do set "bar_filled=!bar_filled!█"
if !empty! GTR 0 for /L %%A in (1,1,!empty!) do set "bar_empty=!bar_empty!░"

set /a SpinIdx=(SpinIdx+1) %% 4
if !SpinIdx! EQU 0 set "SpinChar=|"
if !SpinIdx! EQU 1 set "SpinChar=/"
if !SpinIdx! EQU 2 set "SpinChar=-"
if !SpinIdx! EQU 3 set "SpinChar=\"

echo !ESC![2A!ESC![2K!ESC![93m [!SpinChar!] Active Threads: !ActiveJobs! / %MaxThreads% (Finishing up...)!ESC![0m
echo !ESC![2K!ESC![96m Progress: [!ESC![92m!bar_filled!!ESC![90m!bar_empty!!ESC![96m] !pct!%% (!Completed!/%TotalFiles%)!ESC![0m

if !ActiveJobs! GTR 0 (
    timeout /t 1 /nobreak >nul
    goto fw_loop
)
endlocal
exit /b