@echo off
setlocal enabledelayedexpansion

:: Yêu cầu quyền Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Yeu cau quyen Administrator...
    PowerShell -Command "Start-Process -FilePath '%~0' -Verb RunAs"
    exit /b
)

:: Đường dẫn thư mục Fonts
set "fontsDir=%windir%\Fonts"

:: Xử lý từng file font
for %%F in (*.ttf *.otf) do (
    set "fontFile=%%~nxF"
    set "fontName=%%~nF"
    set "fontType=%%~xF"
    
    :: Xác định loại font
    if /i "!fontType!" == ".ttf" (
        set "regSuffix= (TrueType)"
    ) else if /i "!fontType!" == ".otf" (
        set "regSuffix= (OpenType)"
    )
    
    :: Copy font vào hệ thống
    echo Dang cai dat: !fontFile!
    copy /Y "%%F" "%fontsDir%\%%~nxF" >nul
    
    :: Thêm registry entry
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "!fontName!!regSuffix!" /t REG_SZ /d "!fontFile!" /f >nul
)

:: Làm mới cache font
echo Lam moi cache font...
PowerShell -Command "Add-Type -AssemblyName PresentationCore; [Windows.Media.Fonts]::GetFontFamilies('C:\Windows\Fonts')" >nul 2>&1

echo Cai dat thanh cong!
pause 2>nul & Exit /b 0