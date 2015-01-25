package
{
	import flash.display.Graphics;
	
	import org.flixel.*;

	
	public class PlayState extends FlxState
	{
		
		//[Embed(source="assets/start.mp3")] 						private var SndStart:Class;
		[Embed(source="assets/monster.mp3")] 					private var SndMonster:Class;
		[Embed(source="assets/loot.mp3")] 						private var SndLoot:Class;
		[Embed(source="assets/coin.mp3")] 						private var SndCoin:Class;
		[Embed(source="assets/pickup.mp3")] 					private var SndPickup:Class;
		[Embed(source="assets/push.mp3")] 						private var SndPush:Class;
		[Embed(source="assets/no.mp3")] 						private var SndNo:Class;
		
		
		[Embed(source="assets/SnowMen2Opacity.png")] 			private	var ImgMonster:Class;
		[Embed(source="assets/CodaRoundTeal.png")] 				private	var ImgAvatar:Class;
		[Embed(source="assets/CodaTeal2.png")] 					private	var ImgCoin:Class;
		[Embed(source="assets/Boots1.png")] 					private	var ImgBoots:Class;

		
		private var TxtDescription:FlxText;
		private var TxtScore:FlxText;
		
		public var avatar:FlxSprite;
		public var monster:FlxSprite;
		public var coin:FlxSprite;
		
		private var avatarColor:int = 0xffffffff;
		private var avatarSpeed:int = 60;
		private var avatarTimer:FlxTimer;
		private var avatarPace:Number = 1;

		private var monsterColor:int = 0xffffffff;
		private var monsterTimer:FlxTimer;
		private var monsterPace:Number = 1;
		

		private var coinTimer:FlxTimer;
		private var coinColor:int = 0xffffffff;
		private var coinType:int = 0;
		
				
		override public function create():void
		{
			FlxG.bgColor = 0xff101010;
			
			TxtDescription = new FlxText(20,FlxG.height/2-70,FlxG.width-40,"''A silent game where you gain more sound by finding items throughout the game''\n- Qdead");
			TxtDescription.alignment = "center";
			TxtDescription.size = 16;
			add(TxtDescription);			
			
			
			TxtScore = new FlxText(10,10,300,"Score: 0");
			TxtScore.alignment = "left";
			TxtScore.size = 16;
			add(TxtScore);			
			
			//FlxG.play(SndStart);
			
			
			avatar = new FlxSprite(FlxG.width/2,FlxG.height*2/3,ImgAvatar);
			avatar.color = avatarColor;
			avatar.maxVelocity.x = avatarSpeed;
			avatar.maxVelocity.y = avatarSpeed;
			avatar.acceleration.y = 0;
			avatar.acceleration.x = 0;
			
			add(avatar);
			
			avatarTimer = new FlxTimer();
			avatarTimer.start(1/avatarPace,1);
			
			
			monster = new FlxSprite(FlxG.width+30,10+FlxG.random()*(FlxG.height-20),ImgMonster);
			
			monster.color = monsterColor;
			monster.maxVelocity.x = 10;
			monster.maxVelocity.y = 10;
			monster.acceleration.y = 0;
			monster.acceleration.x = 0;
			
			add(monster);
			
			monsterTimer = new FlxTimer();
			monsterTimer.start(monsterPace,1);
			
			
			coin = new FlxSprite(10,10+FlxG.random()*(FlxG.height-20),ImgCoin);
			coin.color = 0xffffffff;
						
			coin.moves = false;
			
			add(coin);
			
			coinTimer = new FlxTimer();
			coinTimer.start(0.1,1);
		}

		
		
		
		
		override public function update():void
		{
			var avatarMoved:Boolean = false;
			
			avatar.velocity.x = 0;
			avatar.velocity.y = 0;
			
			if(FlxG.keys.UP) {
				avatar.velocity.y = -avatar.maxVelocity.y;
				avatarMoved = true;
			} 
			if(FlxG.keys.DOWN) {
				avatar.velocity.y = avatar.maxVelocity.y;
				avatarMoved = true;
			} 
			if(FlxG.keys.LEFT) {
				avatar.velocity.x = -avatar.maxVelocity.x;
				avatarMoved = true;
			} 
			if(FlxG.keys.RIGHT) {
				avatar.velocity.x = avatar.maxVelocity.x;
				avatarMoved = true;
			} 

			if (avatarTimer.finished && avatarMoved) {
					FlxG.play(SndLoot,5*(1-avatarPace),false,true); 
					avatarTimer.start(0.25/avatarPace,1);
			}
			
			if (FlxG.score > 0) {
			
				monster.velocity.x = 0;
				monster.velocity.y = 0;
				
				if(monster.x > avatar.x)
					monster.velocity.x = -monster.maxVelocity.x;
				else
					monster.velocity.x = monster.maxVelocity.x;
				
				
				if(monster.y > avatar.y)
					monster.velocity.y = -monster.maxVelocity.y;
				else
					monster.velocity.y = monster.maxVelocity.y;
				
				
				if (monsterTimer.finished) {
					FlxG.play(SndMonster,(FlxG.width-FlxU.getDistance(monster.getMidpoint(),avatar.getMidpoint()))/FlxG.width,false,true); 
					monsterTimer.start(monsterPace,1);
				}
			
				if (FlxG.collide(monster,avatar)) {
					FlxG.switchState(new StartState);
				}
			}

			
			if (FlxG.keys.justPressed("SPACE")) {
				if (FlxG.score > 0) {
					monster.x = FlxG.width+30;
					monster.y = 10+FlxG.random()*(FlxG.height-20);
					FlxG.score--;
					FlxG.play(SndPush);
				} else {
					FlxG.play(SndNo);
				}
			}	
			
			
			if (coinTimer.finished) {
				
				
				FlxG.play(SndCoin,(FlxG.height-FlxU.getDistance(coin.getMidpoint(),avatar.getMidpoint())),false,true); 
				coinTimer.start(2*FlxU.getDistance(coin.getMidpoint(),avatar.getMidpoint())/FlxG.height,1);
			}
			
			TxtScore.text="Score: "+FlxG.score;
			
			if (FlxG.collide(coin,avatar)) {
				coin.x = 10+FlxG.random()*(FlxG.width-20);
				coin.y = 10+FlxG.random()*(FlxG.height-20);
				FlxG.score++;
				
				
				
				if (coinType == 0) 	
					avatarPace*=0.9;
				else if (coinType == 1)
					avatarPace=1;
					
				FlxG.play(SndPickup);
				avatar.maxVelocity.x = avatarSpeed*avatarPace;
				avatar.maxVelocity.y = avatarSpeed*avatarPace;	

				if (FlxG.score > 4)
					TxtDescription.text = "''Items could give you a sonic attack.''\n- Knod";	
				if (FlxG.score > 5) {
					avatar.color = FlxU.makeColor(FlxU.getRGBA(avatarColor)[0]*(10-FlxG.score)/5,FlxU.getRGBA(avatarColor)[1]*(10-FlxG.score)/5,FlxU.getRGBA(avatarColor)[2]*(10-FlxG.score)/5);
					monster.color = FlxU.makeColor(FlxU.getRGBA(monsterColor)[0]*(10-FlxG.score)/5,FlxU.getRGBA(monsterColor)[1]*(10-FlxG.score)/5,FlxU.getRGBA(monsterColor)[2]*(10-FlxG.score)/5);
					coin.color = FlxU.makeColor(FlxU.getRGBA(coinColor)[0]*(10-FlxG.score)/5,FlxU.getRGBA(coinColor)[1]*(10-FlxG.score)/5,FlxU.getRGBA(coinColor)[2]*(10-FlxG.score)/5);
				}
				if (FlxG.score > 7) {
					TxtDescription.text = "Speed could be another item advantage.\n\n- Knod"
					if (FlxG.random() > 0.8) {
						coin.loadGraphic(ImgBoots);
						coinType = 1;
					} else {
						coin.loadGraphic(ImgCoin);
						coinType = 0;
					}

				}
				if (FlxG.score > 10) {
					avatar.color = 0x00000000;
					monster.color = 0x00000000;
					coin.color = 0x00000000;
				}
	
				
			}

			
			
			super.update();
			
		}
	}
}
