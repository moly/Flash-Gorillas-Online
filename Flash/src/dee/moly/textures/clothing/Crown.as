package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A champion's crown
	 * @author moly
	 */
	
	public class Crown extends BitmapData{
		
		public function Crown() {
			super(12, 9, true, 0x00000000);
			
			fillRect(new Rectangle(2, 6, 8, 1), 0xFFFFF200);
			fillRect(new Rectangle(2, 4, 1, 2), 0xFFFFF200);
			setPixel32(3, 5, 0xFFFFF200);
			setPixel32(5, 5, 0xFFFFF200);
			setPixel32(7, 5, 0xFFFFF200);
			fillRect(new Rectangle(9, 4, 1, 2), 0xFFFFF200);
		}
	}
}