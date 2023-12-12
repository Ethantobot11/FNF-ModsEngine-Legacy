@echo off

cd crashHandler
echo Building crash dialog...
haxelib run lime build linux
copy build\openfl\linux\bin\SBCrashHandler.exe ..\export\release\linux\bin\SBCrashHandler.exe
cd ..

@echo on