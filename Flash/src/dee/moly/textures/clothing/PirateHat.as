package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A black bandana
	 * @author moly
	 */
	
	public class PirateHat extends BitmapData{
		
		public function PirateHat() {
			super(12, 9, true, 0x00000000);
			
			fillRect(new Rectangle(3, 5, 6, 1), 0xFF000000);
			fillRect(new Rectangle(2, 6, 8, 1), 0xFF000000);
			fillRect(new Rectangle(0, 5, 2, 1), 0xFF000000);
			setPixel32(0, 8, 0xFF000000);
			setPixel32(1, 7, 0xFF000000);
		}
	}
}