@echo off

cd crashHandler
echo Building crash dialog...
haxelib run lime build android
copy build\openfl\android\bin\app\build\apk\debug\SBCrashHandler.apk ..\export\release\android\bin\app\build\outputs\apk\debug\SBCrashHandler.apk
cd ..

@echo on