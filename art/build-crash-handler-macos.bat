@echo off

cd crashHandler
echo Building crash dialog...
haxelib run lime build macos
copy build\openfl\macos\bin\SBCrashHandler.exe ..\export\release\macos\bin\SBCrashHandler.exe
cd ..

@echo on