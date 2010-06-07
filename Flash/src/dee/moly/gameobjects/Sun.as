package dee.moly.gameobjects {
	
	import flash.geom.Point;
	import flash.display.BitmapData;
	import dee.moly.textures.SunTex;
	
	/**
	 * a happy sun
	 * @author moly
	 */
	
	public class Sun extends GameObject{
		
		private static const happy:BitmapData = new SunTex(SunTex.HAPPY);
		private static const shocked:BitmapData = new SunTex(SunTex.SHOCKED);
		
		public function Sun() {
			
			texture = happy;
			position = new Point((Main.SCREEN_WIDTH / 2) - (texture.width / 2), 20);
			
		}
		
		public function shock():void {
			
			texture = shocked;
			
		}
		
		public function reset():void {
			
			texture = happy;
			
		}
		
	}

}