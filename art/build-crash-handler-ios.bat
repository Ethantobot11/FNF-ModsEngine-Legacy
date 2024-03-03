@echo off

cd crashHandler
echo Building crash dialog...
haxelib run lime build ios
copy build\openfl\ios\bin\app\build\ipa\debug\SBCrashHandler.ipa ..\export\release\ios\bin\app\build\outputs\ipa\debug\SBCrashHandler.ipa
cd ..

@echo on
