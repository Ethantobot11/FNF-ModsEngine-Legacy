package states;

#if android
import android.flixel.FlxButton
#end

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		#if android
		addVirtualPad(NONE, A_B);
		#end
		
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

        #if android
        warnText = new FlxText(0, 0, FlxG.width,
            "Message From Mods Engine\n
            Hey, Watch Out!\n
            This Mod Contains Some Flashing Lights!\n
            Press A To Disable Them Now Or Go To Options Menu.\n
            Press B To Ignore This Message.\n
            You've Been Warned!",
            32);
        #end

		warnText = new FlxText(0, 0, FlxG.width,
			"Message From Mods Engine\n
			Hey, Watch Out!\n
			This Mod Contains Some Flashing Lights!\n
			Press ENTER To Disable Them Now Or Go To Options Menu.\n
			Press ESCAPE To Ignore This Message.\n
			You've Been Warned!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.data.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
