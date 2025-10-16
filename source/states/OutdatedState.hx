package states;

#if (android && ios)
import android.flixel.FlxButton;
#end

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{

		#if (android && ios)
		addVirtualPad(NONE, A_B);
		#end

		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
		    #if (android && ios)
		    "
		    Message From Mods Engine\n
		    Sup Bro, Looks Like You're Running An\n
		    Outdated Version Of Mods Engine (" + MainMenuState.psychEngineVersion + "),\n
		    Please Update To " + TitleState.updateVersion + "!\n
		    Press A To Proceed Anyway.\n
		    Press B To Ignore Anyway.\n
		    \n
		    Thank You For Using The Engine!"
		    #else
			"
			Message From Mods Engine\n
			Sup Bro, Looks Like You're Running An\n
			Outdated Version Of Mods Engine (" + MainMenuState.psychEngineVersion + "),\n
			Please Update To " + TitleState.updateVersion + "!\n
			Press ENTER To Proceed Anyway.\n
			Press ESCAPE To Ignore Anyway.\n
			\n
			Thank You For Using The Engine!",
			#end
			32);
		warnText.setFormat("vcr.ttf", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/AliAlafandy/FNF-ModsEngine/releases");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
