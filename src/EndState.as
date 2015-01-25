package
{
	import flash.display.Graphics;
	
	import org.flixel.*;

	
	public class EndState extends FlxState
	{
		
		
		[Embed(source="assets/boom.mp3")] 						private var SndBoom:Class;
		private var TxtStart:FlxText;
		private var TxtTitle:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff101010;
			
			TxtTitle = new FlxText(0,FlxG.height/2-70,FlxG.width,"Game Over");
			TxtTitle.alignment = "center";
			TxtTitle.size = 24;
			add(TxtTitle);
			
			TxtStart = new FlxText(0,FlxG.height/2-10,FlxG.width,"Final Score: " + FlxG.score);
			TxtStart.alignment = "center";
			TxtStart.size = 16;
			add(TxtStart);
			
			FlxG.score = 0;
			
			FlxG.flash();
			FlxG.play(SndBoom,0.5);
		}

		
		
		override public function update():void
		{

			 
			if (FlxG.mouse.pressed() || FlxG.mouse.justPressed() || FlxG.mouse.justReleased()) {
				FlxG.switchState(new StartState);
			}
			
			super.update();
			
		}
	}
}
