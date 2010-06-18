package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Short black hair
	 * @author moly
	 */
	
	public class SuperHair extends BitmapData{
		
		public function SuperHair() {
			super(12, 9, true, 0x00000000);
			
			fillRect(new Rectangle(2, 6, 8, 1), 0xFF000000);
			setPixel32(1, 8, 0xFF000000);
		}
	}
}