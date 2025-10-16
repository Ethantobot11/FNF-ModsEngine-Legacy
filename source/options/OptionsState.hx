package options;

#if android
import android.flixel.FlxButton;
#end

import states.MainMenuState;
import backend.StageData;

class OptionsState extends MusicBeatState
{
    #if (android && ios)
    var options.Array<String> = ['Note Colors', 'Android Controls', 'Android Controls Settings', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
    #else
	var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
	#end
    private var grpOptions:FlxTypedGroup<Alphabet>;
    private static var curSelected:Int = 0;
    public static var menuBG:FlxSprite;
    public static var onPlayState:Bool = false;

    function openSelectedSubstate(label:String) {
    #if (android && ios)
    switch(label) {
	    case 'Note Colors':
                openSubState(new options.NotesSubState());
            case 'Android Controls':
                openSubState(new options.controls.android.AndroidControlsSubState());
            case 'Android Controls Settings':
                openSubState(new options.controls.android.AndroidControlsSettingsSubState());
            case 'Graphics':
                openSubState(new options.GraphicsSettingsSubState());
            case 'Visuals and UI':
                openSubState(new options.VisualsUISubState());
            case 'Gameplay':
                openSubState(new options.GameplaySettingsSubState());
            case 'Adjust Delay and Combo':
                openSubState(new options.NoteOffsetState());
            	}
	}
    #else
    switch(label) {
	    case 'Note Colors':
		openSubState(new options.NotesSubState());
	    case 'Controls':
		openSubState(new options.controls.desktop.ControlsSubState());
	    case 'Graphics':
		openSubState(new options.GraphicsSettingsSubState());
	    case 'Visuals and UI':
		openSubState(new options.VisualsUISubState());
	    case 'Gameplay':
		openSubState(new options.GameplaySettingsSubState());
	    case 'Adjust Delay and Combo':
		MusicBeatState.switchState(new options.NoteOffsetState());
	    }
	}
	end

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFF000080;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();
		
		#if android
		addVirtualPad(UP_DOWN, A_B_C);
		#end

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}
