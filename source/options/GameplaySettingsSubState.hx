package options;

#if android
import android.flixel.FlxButton;
#end

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Gameplay Settings';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Downscroll', 'If Checked, Notes Go Down Instead Of Up, Simple Enough.', 'downScroll', 'bool');
		addOption(option);

		var option:Option = new Option('Middlescroll', 'If Checked, Your Notes Get Centered.', 'middleScroll', 'bool');
		addOption(option);

		var option:Option = new Option('Opponent Notes', 'If Unchecked, Opponent Notes Get Hidden.', 'opponentStrums', 'bool');
		addOption(option);

		var option:Option = new Option('Ghost Tapping', "If Checked, You Won't Get Misses From Pressing Keys\nWhile There Are No Notes Able To Be Hit.", 'ghostTapping', 'bool');
		addOption(option);
		
		var option:Option = new Option('Auto Pause', "If Checked, The Game Automatically Pauses If The Screen Isn't On Focus.", 'autoPause', 'bool');
		addOption(option);
		option.onChange = onChangeAutoPause;

		var option:Option = new Option('Disable Reset Button', "If Checked, Pressing Reset Won't Do Anything.", 'noReset', 'bool');
		addOption(option);

		var option:Option = new Option('Hitsound Volume', 'Funny Notes Does \"Tick!\" When You Hit Them."', 'hitsoundVolume', 'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('Rating Offset', 'Changes How Late/Early You Have To Hit For A "Sick!"\nHigher Values Mean You Have To Hit Later.', 'ratingOffset', 'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('Sick! Hit Window', 'Changes The Amount Of Time You Have\nFor Hitting A "Sick!" In Milliseconds.', 'sickWindow', 'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('Good Hit Window', g'Changes The Amount Of Time You Have\nFor Hitting A "Good" In Milliseconds.', 'goodWindow', 'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('Bad Hit Window', 'Changes The Amount Of Time You Have\nFor Hitting A "Bad" In Milliseconds.', 'badWindow', 'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Safe Frames', 'Changes How Many Frames You Have For\nHitting A Note Earlier Or Late.', 'safeFrames', 'float');
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		super();
		
		#if android
		addVirtualPad(LEFT_FULL, A_B_C);
		#end
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);
	}

	function onChangeAutoPause()
	{
		FlxG.autoPause = ClientPrefs.data.autoPause;
	}
}