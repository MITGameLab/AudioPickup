package
{
	import flash.display.Graphics;
	
	import org.flixel.*;

	
	public class StartState extends FlxState
	{
		
		
		private var TxtStart:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff101010;
			
			TxtStart = new FlxText(0,FlxG.height/2-70,FlxG.width,"Louder\n\nOriginal idea by Qdead\nTitle by Knodding");
			TxtStart.alignment = "center";
			TxtStart.size = 16;
			add(TxtStart);
			
			FlxG.flash();
		}

		
		
		override public function update():void
		{

			 
			if (FlxG.mouse.pressed() || FlxG.mouse.justPressed() || FlxG.mouse.justReleased()) {
				FlxG.switchState(new PlayState);
			}
			
			super.update();
			
		}
	}
}
