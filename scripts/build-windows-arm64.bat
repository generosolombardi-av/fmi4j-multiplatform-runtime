@echo off
setlocal

set ROOT_DIR=%~dp0..
set SRC_DIR=%ROOT_DIR%\fmi-native-import\src\main\cpp
set BUILD_DIR=%ROOT_DIR%\build\native\win-arm64

if "%JAVA_HOME%"=="" (
  echo JAVA_HOME must be set to a Windows ARM64 JDK.
  exit /b 1
)

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

cl /nologo /EHsc /O2 /LD /DWIN32 ^
  /I"%JAVA_HOME%\include" ^
  /I"%JAVA_HOME%\include\win32" ^
  /I"%SRC_DIR%" ^
  /I"%SRC_DIR%\fmi1" ^
  /I"%SRC_DIR%\fmi2" ^
  "%SRC_DIR%\fmi1\fmi1.cpp" ^
  "%SRC_DIR%\fmi2\fmi2.cpp" ^
  /Fe:"%BUILD_DIR%\fmi4j-import.dll"

dumpbin /headers "%BUILD_DIR%\fmi4j-import.dll" | findstr machine
