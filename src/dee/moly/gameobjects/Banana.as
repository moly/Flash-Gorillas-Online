package dee.moly.gameobjects {
	
	import dee.moly.textures.ContentManager;
	import flash.geom.Point;
	
	/**
	 * the banana that the gorillas throw at each other
	 * @author moly
	 */
	
	public class Banana extends GameObject{
		
		// the rotated textures for the banana
		private var textures:Array = [ContentManager.bananaL, ContentManager.bananaR, ContentManager.bananaU, ContentManager.bananaD];
		
		private var i:int;
		
		public function Banana() {
			
			i = 0;
			position = new Point(0, 0);
			texture = textures[i];
			
		}
		
		public function rotate():void {
			
			if (++i > textures.length - 1)
				i = 0;
			
			texture = textures[i];
			
		}
		
	}

}