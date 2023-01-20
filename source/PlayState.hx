package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flash.system.System;

class PlayState extends FlxState
{
	var timeAnimation:Float = 0.2;
	var textAnimation:String = "";
	var index:Int = 0;
	var nikitaAnimation:Array<String> = [
		"U", "N", "I", "T", "E", "D", " ", "P", "R", "O", "G", "R", "A", "M", "M", "I", "N", "G"
	];
	var nikitaTexts:List<flixel.text.FlxText> = new List<flixel.text.FlxText>();
	var text:FlxText = new flixel.text.FlxText(0, 0, 0, "", 64);
	var fadeOutAnimation:Int = 255;
	var random:FlxRandom = new FlxRandom();
	var multiplier:Float = 0.01;
	var oneTime:Bool = true;
	var oneTimeFade:Bool = true;
	var times:Int = 300;
	var finalBool:Bool = false;
	var superFinalBool:Bool = false;

	override public function create()
	{
		super.create();
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		timeAnimation -= elapsed;
		if (timeAnimation <= 0)
		{
			if (index >= nikitaAnimation.length)
			{
				if (fadeOutAnimation <= 0)
				{
					if (superFinalBool)
					{
						PlayAppearSound();
						System.exit(0);
					}
					if (finalBool)
					{
						text.text = "BYE!";
						text.color = text.color.setRGB(255, 255, 255);
						text.screenCenter();
						PlayAppearSound();
						superFinalBool = true;
						timeAnimation = 2;
						return;
					}
					if (times <= 0)
					{
						for (i in nikitaTexts)
						{
							remove(i);
						}
						nikitaTexts.clear();
						text.text = "UNITED PROGRAMMING";
						text.color = text.color.setRGB(255, 0, 0);
						text.screenCenter();
						PlayTypeSound();
						timeAnimation = 5;
						finalBool = true;
						return;
					}
					if (!oneTime)
					{
						var r:Int = random.int(0, 255),
							g:Int = random.int(0, 255),
							b:Int = random.int(0, 255);
						var textNikita = new flixel.text.FlxText(random.int(0, 1920), random.int(0, 1080), 0, "UNITED PROGRAMMING", 64);
						textNikita.color = textNikita.color.setRGB(r, g, b);
						add(textNikita);
						nikitaTexts.add(textNikita);
						PlayAppearSound();
						if (timeAnimation == 0)
						{
							return;
						}
						timeAnimation = 1 - multiplier;
						multiplier += 0.01;
						times -= 1;
					}
					else
					{
						var r:Int = random.int(0, 255),
							g:Int = random.int(0, 255),
							b:Int = random.int(0, 255);
						var textNikita = new flixel.text.FlxText(0, 0, 0, "UNITED PROGRAMMING", 64);
						textNikita.color = textNikita.color.setRGB(r, g, b);
						textNikita.screenCenter();
						add(textNikita);
						nikitaTexts.add(textNikita);
						oneTime = false;
						PlayTypeSound();
						timeAnimation = 1;
						times -= 1;
					}
					return;
				}
				if (oneTimeFade)
				{
					PlayAppearSound();
					oneTimeFade = false;
				}
				text.color = text.color.setRGB(0, 0, fadeOutAnimation, 0);
				fadeOutAnimation -= 1;
				timeAnimation = 0.05;
				return;
			}
			textAnimation += nikitaAnimation[index];
			text.text = textAnimation;
			timeAnimation = 0.2;
			index++;
			PlayTypeSound();
			text.screenCenter();
		}
	}

	private function PlayTypeSound()
	{
		var typeSound:FlxSound = new FlxSound();
		typeSound = FlxG.sound.load(AssetPaths.hurt__wav);
		typeSound.play();
	}

	private function PlayAppearSound()
	{
		var appearSound:FlxSound = new FlxSound();
		appearSound = FlxG.sound.load(AssetPaths.step__wav);
		appearSound.play();
		appearSound = null;
	}
}
