package;

#if android
import android.Tools;
#end

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import flash.system.System;

using StringTools;

class SUtil
{
	#if android
	private static var aDir:String = null;
	#end

	public static function getPath():String
	{
		#if android
		if (aDir != null && aDir.length > 0)
			return aDir;
		else
			return aDir = Tools.getExternalStorageDirectory() + '/.ModsEngine/';
		#else
		return '';
		#end
	}

	public static function doTheCheck()
	{
		if (!FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.exists(SUtil.getPath() + 'mods'))
			{
				SUtil.applicationAlert('Uncaught Error!', "Message From Mods Engine\nWhoops, Seems You Didn't Extract The assets/assets And assets/mods Floders From The .APK!\nExtract Them And Put Them In /.ModsEngine/.");
				System.exit(0);
			}
			else
			{
				if (!FileSystem.exists(SUtil.getPath() + 'assets'))
				{
					SUtil.applicationAlert('Uncaught Error!', "Message From Mods Engine\nWhoops, Seems You Didn't Extract The assets/assets Folder From The .APK!\nExtract Them And Put Them In /.ModsEngine/.");
					System.exit(0);
				}

				if (!FileSystem.exists(SUtil.getPath() + 'mods'))
				{
					SUtil.applicationAlert('Uncaught Error!', "Message From Mods Engine\nWhoops, Seems You Didn't Extract The assets/mods Folder From The .APK!\nExtract Them And Put Them In /.ModsEngine/.");
					System.exit(0);
				}
			}
		}
		#end
	}

	private static function applicationAlert(title:String, description:String)
	{
		Application.current.window.alert(description, title);
	}

	#if android
	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json', fileData:String = 'You Forgot Something To Add In Your Code')
	{
		if (!FileSystem.exists(SUtil.getPath() + 'saves'))
			FileSystem.createDirectory(SUtil.getPath() + 'saves');

		File.saveContent(SUtil.getPath() + 'saves/' + fileName + fileExtension, fileData);
	}

	public static function saveClipboard(fileData:String = 'You Forgot Something To Add In Your Code')
	{
		openfl.system.System.setClipboard(fileData);
	}

	public static function copyContent(copyPath:String, savePath:String)
	{
		if (!FileSystem.exists(savePath))
			File.saveBytes(savePath, OpenFlAssets.getBytes(copyPath));
	}
	#end
}
