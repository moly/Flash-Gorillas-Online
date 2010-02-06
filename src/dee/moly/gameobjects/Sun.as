package dee.moly.gameobjects {
	
	import flash.geom.Point;
	import dee.moly.textures.ContentManager;
	
	/**
	 * a happy sun
	 * @author moly
	 */
	
	public class Sun extends GameObject{
		
		public function Sun() {
			
			texture = ContentManager.sunH;
			
			position = new Point((Main.SCREEN_WIDTH / 2) - (texture.width / 2), 20);
			
		}
		
	}

}