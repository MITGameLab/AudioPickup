package
{
	import flash.display.Graphics;
	
	import org.flixel.*;

	
	public class StartState extends FlxState
	{
		
		
		[Embed(source="assets/boom.mp3")] 						private var SndBoom:Class;
		[Embed(source="assets/CodaTeal2.png")] 					private	var ImgEar:Class;
		private var TxtStart:FlxText;
		private var TxtTitle:FlxText;
		
		private var ear1:FlxSprite = new FlxSprite(35,FlxG.height-60,ImgEar);
		private var ear2:FlxSprite = new FlxSprite(FlxG.width-55,FlxG.height-60,ImgEar);
		
		
		override public function create():void
		{
			FlxG.bgColor = 0xff101010;
			
			TxtTitle = new FlxText(0,FlxG.height/2-120,FlxG.width,"Louder");
			TxtTitle.alignment = "center";
			TxtTitle.size = 24;
			add(TxtTitle);
			
			TxtStart = new FlxText(0,FlxG.height/2-50,FlxG.width,"''Twitch Plays GGJ15''\n\nOriginal idea by William Färlin (Qdead)\nArt & Title by Knod\nCode & Music by Philip Tan\n\n\nHeadphones recommended!");
			TxtStart.alignment = "center";
			TxtStart.size = 16;
			add(TxtStart);
			
			FlxG.score = 0;
			ear2.scale = new FlxPoint(-1,1);
			add(ear1);
			add(ear2);
			
			FlxG.flash();
			//FlxG.play(SndBoom,0.5);
		}

		
		
		override public function update():void
		{

			 
			if (FlxG.keys.SPACE || FlxG.mouse.pressed() || FlxG.mouse.justPressed() || FlxG.mouse.justReleased()) {
				FlxG.switchState(new InstrState1);
			}
			
			super.update();
			
		}
	}
}
