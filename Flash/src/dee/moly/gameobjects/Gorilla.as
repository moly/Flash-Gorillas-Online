package dee.moly.gameobjects {
	
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
		
		public function get finishedDancing():Boolean {
			if (danceStep > 8) {
				texture = down;
				danceStep = 0;
				return true;
			}
			return false;
		}
		
		public function Gorilla() {
			danceStep = 0;
			texture = down;
			position = new Point();
		}
		
		public function raiseLeftArm():void {
			texture = left;
		}
		
		public function raiseRightArm():void {
			texture = right;
		}
		
		public function armsDown(e:TimerEvent = null):void {
			texture = down;
		}
		
		public function swapArms():void {
			texture = (texture == right) ? left : right;
		}
		
		public function throwAnimation():void {
			
			if (position.x < Main.SCREEN_WIDTH / 2)
				texture = left;
			else if (position.x > Main.SCREEN_WIDTH / 2)
				texture = right;
				
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
			
			texture = (texture == right || texture == down) ? left : right;
			
			if(danceStep++ < 8){
				var t:Timer = new Timer(300, 1);
				t.addEventListener(TimerEvent.TIMER_COMPLETE, danceAnimation, false, 0, true);
				t.start();
			}
			
		}
		
	}

}