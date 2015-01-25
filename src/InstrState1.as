package
{
	import flash.display.Graphics;
	
	import org.flixel.*;

	
	public class InstrState1 extends FlxState
	{
		
		
		[Embed(source="assets/coinrh.mp3")] 						private var SndLeft:Class;
		[Embed(source="assets/coinlh.mp3")] 						private var SndRight:Class;

		private var TxtTitle:FlxText;
		
		private var coinLeft:Boolean = true;
		
		private var coinTimer:FlxTimer;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff101010;
			
			TxtTitle = new FlxText(0,FlxG.height/2-70,FlxG.width,"High pitches are above you");
			TxtTitle.alignment = "center";
			TxtTitle.size = 16;
			add(TxtTitle);
			
			coinTimer = new FlxTimer();
			coinTimer.start(0.5,1);
		}

		
		
		override public function update():void
		{
			
			if (coinTimer.finished) {
				if (coinLeft)
					FlxG.play(SndLeft,0.5,false,true); 
				else
					FlxG.play(SndRight,0.5,false,true); 
				coinLeft = !coinLeft;
				coinTimer.start(0.5,1);
			}
			 
			if (FlxG.keys.SPACE || FlxG.mouse.pressed() || FlxG.mouse.justPressed() || FlxG.mouse.justReleased()) {
				FlxG.switchState(new InstrState2);
			}
			
			super.update();
			
		}
	}
}
