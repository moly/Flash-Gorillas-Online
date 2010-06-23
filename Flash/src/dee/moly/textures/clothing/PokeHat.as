package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Red and white cap
	 * @author moly
	 */
	
	public class PokeHat extends BitmapData{
		
		public function PokeHat() {
			super(12, 7, true, 0x00000000);
			
			fillRect(new Rectangle(3, 4, 7, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 5, 2, 1), 0xFFF40000);
			fillRect(new Rectangle(1, 6, 10, 1), 0xFFF40000);
		}
	}
}