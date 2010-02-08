package dee.moly.gameobjects {
	
	import flash.geom.Point;
	import dee.moly.textures.ContentManager;
	
	/**
	 * a happy sun
	 * @author moly
	 */
	
	public class Sun extends GameObject{
		
		private var textures:Array = [ContentManager.sunH, ContentManager.sunS];
		
		public function Sun() {
			
			texture = textures[0];
			
			position = new Point((Main.SCREEN_WIDTH / 2) - (texture.width / 2), 20);
			
		}
		
		public function shock():void {
			
			texture = textures[1];
			
		}
		
		public function reset():void {
			
			texture = textures[0];
			
		}
		
	}

}