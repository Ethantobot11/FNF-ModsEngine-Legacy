package android.flixel;

import openfl.display.BitmapData;
import openfl.display.Shape;
import android.flixel.FlxButton;

class FlxNewHitbox extends FlxSpriteGroup {
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);
    
	public function new():Void {
		super();
        
		var buttonLeftColor:Array<FlxColor>;
        var buttonDownColor:Array<FlxColor>;
		var buttonUpColor:Array<FlxColor>;
		var buttonRightColor:Array<FlxColor>;
		
		if (ClientPrefs.dynamicColours) {
			buttonLeftColor = ClientPrefs.arrowHSV[0];
			buttonDownColor = ClientPrefs.arrowHSV[1];
			buttonUpColor = ClientPrefs.arrowHSV[2];
			buttonRightColor = ClientPrefs.arrowHSV[3];
		}
		else {
			buttonLeftColor = ClientPrefs.arrowHSV[0];
			buttonDownColor = ClientPrefs.arrowHSV[1];
			buttonUpColor = ClientPrefs.arrowHSV[2];
			buttonRightColor = ClientPrefs.arrowHSV[3];
		}
        {
            add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), buttonLeftColor[0]));
            add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), buttonDownColor[0]));
            add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), buttonUpColor[0]));
            add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), buttonRightColor[0]));
            }
	}
        scrollFactor.set();
	}
    
	override function destroy():Void {
		super.destroy();
        
		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
    
	private function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFFFF):BitmapData {
		var shape:Shape = new Shape();
		shape.graphics.beginFill(Color);
		shape.graphics.lineStyle(10, Color, 1);
		shape.graphics.drawRect(0, 0, Width, Height);
		shape.graphics.endFill();
    
		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}
    
	private function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFFFF):FlxButton {
		var hint:FlxButton = new FlxButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height, Color));
		hint.solid = false;
		hint.immovable = true;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.onDown.callback = hint.onOver.callback = function() {
			if (hint.alpha != ClientPrefs.hitboxAlpha)
				hint.alpha = ClientPrefs.hitboxAlpha;
		}
		hint.onUp.callback = hint.onOut.callback = function() {
			if (hint.alpha != 0.00001)
				hint.alpha = 0.00001;
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}
}
