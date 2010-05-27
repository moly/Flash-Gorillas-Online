package dee.moly.gameobjects {
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import dee.moly.textures.GorillaTex;
	
	/**
	 * a gorilla
	 * @author moly
	 */
	
	public class Gorilla extends GameObject{
		
		private static const left:BitmapData = new GorillaTex(GorillaTex.LEFT_ARM);
		private static const right:BitmapData = new GorillaTex(GorillaTex.RIGHT_ARM);
		private static const down:BitmapData = new GorillaTex(GorillaTex.ARMS_DOWN);
		
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
		
		public function swapArms():void {
			
			texture = (texture == left) ? right : left;
			
		}
		
	}

}