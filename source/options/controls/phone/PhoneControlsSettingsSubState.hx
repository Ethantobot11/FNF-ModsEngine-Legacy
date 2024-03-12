package options.controls.phone;

import flixel.addons.transition.FlxTransitionableState;
import lime.utils.Assets;
import flixel.util.FlxSave;
import haxe.Json;
import options.BaseOptionsMenu;
import options.Option;
import openfl.Lib;

using StringTools;

class PhoneControlsSettingsSubState extends BaseOptionsMenu {
	public function new() {
		title = 'Phone Settings For Virtual Pads And Hitbox';
		rpcTitle = 'Virtual Pads And Hitbox Menu';
        
		var option:Option = new Option('Hitbox Style:', "Choose Your Hitbox Style How Are Want To Look Like On Gameplay.", 'hitboxSelection', 'string', 'Original', ['Original', 'New']);
		addOption(option);
        
		var option:Option = new Option('Hitbox Opacity:', 'Change Hitbox Opacity\nNote: (Using To Much Opacity Its Gonna Be So Weird On Gameplay!)', 'hitboxAlpha', 'float', 0.2);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
        
		var option:Option = new Option('Virtual Pad Opacity:', 'Changes Virtual Pad Opacity', 'virtualPadAlpha', 'float', 0.5);
		option.scrollSpeed = 1.6;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.01;
		option.decimals = 2;
		addOption(option);
        
		var option:Option = new Option('Dynamic Colours', "If Unchecked, Disables Colours From Note.", 'dynamicColours', 'bool', true);
		addOption(option);
        
		super();
	}
}
