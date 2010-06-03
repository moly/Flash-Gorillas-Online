package dee.moly.gameobjects {
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import dee.moly.textures.GorillaTex;
	import flash.utils.Timer;
	
	/**
	 * a gorilla
	 * @author moly
	 */
	
	public class Gorilla extends GameObject{
		
		private const left:BitmapData = new GorillaTex(GorillaTex.LEFT_ARM);
		private const right:BitmapData = new GorillaTex(GorillaTex.RIGHT_ARM);
		private const down:BitmapData = new GorillaTex(GorillaTex.ARMS_DOWN);
		
		public function Gorilla(x:int = 0, y:int = 0) {
			
			position = new Point(x, y);
			texture = down;
			
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
			
			texture = (texture == left) ? right : left;
			
		}
		
		public function throwAnimation():void {
			
			if (position.x < Main.SCREEN_WIDTH / 2)
				texture = left;
			else if (position.x > Main.SCREEN_WIDTH / 2)
				texture = right;
				
			var t:Timer = new Timer(200, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, armsDown, false, 0, true);
			t.start();
			
		}
		
	}

}