package dee.moly.gameobjects {
	
	import dee.moly.textures.ContentManager;
	import flash.geom.Point;
	
	/**
	 * the banana that the gorillas throw at each other
	 * @author moly
	 */
	
	public class Banana extends GameObject{
		
		public var inMotion:Boolean;
		
		private var startPos:Point;
		public function get startX():int {
			return startPos.x;
		}
		public function get startY():int {
			return startPos.y;
		}
		public function set startX(value:int):void {
			startPos.x = value;
		}
		public function set startY(value:int):void {
			startPos.y = value;
		}
		
		// the rotated textures for the banana
		private var textures:Array = [ContentManager.bananaL, ContentManager.bananaU, ContentManager.bananaR, ContentManager.bananaD];
		
		private var r:int;
		
		public function Banana() {
			
			r = 0;
			startPos = new Point(0, 0);
			position = new Point(0, 0);
			texture = textures[0];
			
		}
		
		public function set rotation(value:int):void {
			
			texture = textures[int((r = value)) % textures.length];
			
		}
		
		public function get rotation():int {
			return r;
		}
		
	}

}