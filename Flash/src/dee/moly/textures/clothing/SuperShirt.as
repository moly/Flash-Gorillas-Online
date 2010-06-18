package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Super hero shirt
	 * @author moly
	 */
	
	public class SuperShirt extends BitmapData{
		
		public function SuperShirt() {
			super(28, 14, true, 0x00000000);
			
			// sleves
			fillRect(new Rectangle(3, 2, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFF3F48CC);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFF3F48CC);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFF3F48CC);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFF3F48CC);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFF3F48CC);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFF3F48CC);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFF3F48CC);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFF3F48CC);
			
			// embelm
			fillRect(new Rectangle(11, 3, 7, 1), 0xFFFD330F);
			fillRect(new Rectangle(10, 4, 2, 1), 0xFFFD330F);
			setPixel32(12, 4, 0xFFFFC90E);
			fillRect(new Rectangle(13, 4, 6, 1), 0xFFFD330F);
			fillRect(new Rectangle(10, 5, 3, 1), 0xFFFD330F);
			fillRect(new Rectangle(13, 5, 4, 1), 0xFFFFC90E);
			fillRect(new Rectangle(17, 5, 2, 1), 0xFFFD330F);
			fillRect(new Rectangle(11, 6, 7, 1), 0xFFFD330F);
			setPixel32(12, 7, 0xFFFD330F);
			fillRect(new Rectangle(13, 7, 2, 1), 0xFFFFC90E);
			fillRect(new Rectangle(15, 7, 2, 1), 0xFFFD330F);
			fillRect(new Rectangle(13, 8, 3, 1), 0xFFFD330F);
			setPixel32(14, 9, 0xFFFD330F);
			
			// cape
			fillRect(new Rectangle(6, 1, 5, 1), 0xFFFD330F);
			fillRect(new Rectangle(17, 1, 5, 1), 0xFFFD330F);
			fillRect(new Rectangle(0, 9, 1, 5), 0xFFFD330F);
			fillRect(new Rectangle(1, 11, 1, 3), 0xFFFD330F);
			setPixel32(2, 12, 0xFFFD330F);
			fillRect(new Rectangle(5, 6, 1, 3), 0xFFFD330F);
			fillRect(new Rectangle(6, 8, 2, 3), 0xFFFD330F);
			setPixel32(7, 11, 0xFFFD330F);
		}
	}
}