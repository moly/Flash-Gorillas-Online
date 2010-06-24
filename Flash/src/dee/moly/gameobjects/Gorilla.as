package dee.moly.gameobjects {
	
	import dee.moly.textures.clothing.ClothingDatabase;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import dee.moly.textures.GorillaTex;
	import flash.utils.Timer;
	import flash.media.Sound;
	
	/**
	 * a gorilla
	 * @author moly
	 */
	
	public class Gorilla extends GameObject {
		
		[Embed(source="/dee/moly/sounds/throw.mp3")] private static const ThrowSound:Class;
		private static const throwSound:Sound = new ThrowSound();
		
		[Embed(source="/dee/moly/sounds/armDance1.mp3")] private static const ArmDance1Sound:Class;
		private static const armDance1Sound:Sound = new ArmDance1Sound();
		
		[Embed(source="/dee/moly/sounds/armDance2.mp3")] private static const ArmDance2Sound:Class;
		private static const armDance2Sound:Sound = new ArmDance2Sound();
		
		private static const left:BitmapData = new GorillaTex(GorillaTex.LEFT_ARM);
		private static const right:BitmapData = new GorillaTex(GorillaTex.RIGHT_ARM);
		private static const down:BitmapData = new GorillaTex(GorillaTex.ARMS_DOWN);
		
		private var danceStep:int
		
		private var clothes:ClothingDatabase;
		
		public function get finishedDancing():Boolean {
			if (danceStep > 8) {
				armsDown();
				danceStep = 0;
				return true;
			}
			return false;
		}
		
		override public function set x(value:int):void {
			clothes.x = value;
			super.x = value;
		}
		
		override public function set y(value:int):void {
			clothes.y = value;
			super.y = value;
		}
		
		public function Gorilla() {
			danceStep = 0;
			texture = down;
			clothes = new ClothingDatabase(9999, 0, 0);
			position = new Point();
		}
		
		public function setClothes(hat:int, shirt:int, trousers:int):void {
			clothes.setClothes(hat, shirt, trousers);
			trace(hat + " " + shirt + " " + trousers);
		}
		
		override public function draw(canvas:BitmapData):void {
			super.draw(canvas);
			clothes.draw(canvas);
		}
		
		public function raiseLeftArm():void {
			texture = left;
			clothes.armState = GorillaTex.LEFT_ARM;
		}
		
		public function raiseRightArm():void {
			texture = right;
			clothes.armState = GorillaTex.RIGHT_ARM;
		}
		
		public function armsDown(e:TimerEvent = null):void {
			texture = down;
			clothes.armState = GorillaTex.ARMS_DOWN;
		}
		
		public function swapArms():void {
			(texture == right) ? raiseLeftArm() : raiseRightArm();
		}
		
		public function throwAnimation():void {
			
			if (position.x < Main.SCREEN_WIDTH / 2)
				raiseLeftArm();
			else if (position.x > Main.SCREEN_WIDTH / 2)
				raiseRightArm();
				
			var t:Timer = new Timer(100, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, armsDown, false, 0, true);
			t.start();
			
			throwSound.play();
		}
		
		public function danceAnimation(e:TimerEvent = null):void {
			
			// don't update if it's called somewhere other than a timer while dancing
			if (e == null && danceStep > 0) return;
			
			if (danceStep == 0 || danceStep == 7)
				armDance1Sound.play();
			else if (danceStep == 1 || danceStep == 3 || danceStep == 5)
				armDance2Sound.play();
			
			(texture == right || texture == down) ? raiseLeftArm() : raiseRightArm();
			
			if(danceStep++ < 8){
				var t:Timer = new Timer(300, 1);
				t.addEventListener(TimerEvent.TIMER_COMPLETE, danceAnimation, false, 0, true);
				t.start();
			}	
		}	
	}
}