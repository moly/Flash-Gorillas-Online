package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Plain green hat
	 * @author moly
	 */
	
	public class GreenHat extends BitmapData{
		
		public function GreenHat() {
			super(12, 12, true, 0x00000000);
			
			fillRect(new Rectangle(4, 4, 6, 1), 0xFF00F400);
			fillRect(new Rectangle(2, 5, 8, 2), 0xFF00F400);
			setPixel32(10, 6, 0xFF00F400);
		}
	}
}