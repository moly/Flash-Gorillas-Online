package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Super hero shirt
	 * @author moly
	 */
	
	public class SuperShirt extends BitmapData{
		
		public function SuperShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(22, 2, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFF3F48CC);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF3F48CC);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFF3F48CC);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFF3F48CC);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(1, 2, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFF3F48CC);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF3F48CC);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF3F48CC);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF3F48CC);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFF3F48CC);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFF3F48CC);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF3F48CC);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF3F48CC);
			
			// embelm
			fillRect(new Rectangle(11, 11, 7, 1), 0xFFF40000);
			fillRect(new Rectangle(10, 12, 2, 1), 0xFFF40000);
			setPixel32(12, 12, 0xFFFFC90E);
			fillRect(new Rectangle(13, 12, 6, 1), 0xFFF40000);
			fillRect(new Rectangle(10, 13, 3, 1), 0xFFF40000);
			fillRect(new Rectangle(13, 13, 4, 1), 0xFFFFC90E);
			fillRect(new Rectangle(17, 13, 2, 1), 0xFFF40000);
			fillRect(new Rectangle(11, 14, 7, 1), 0xFFF40000);
			setPixel32(12, 15, 0xFFF40000);
			fillRect(new Rectangle(13, 15, 2, 1), 0xFFFFC90E);
			fillRect(new Rectangle(15, 15, 2, 1), 0xFFF40000);
			fillRect(new Rectangle(13, 16, 3, 1), 0xFFF40000);
			setPixel32(14, 17, 0xFFF40000);
			
			// cape
			fillRect(new Rectangle(6, 9, 5, 1), 0xFFF40000);
			fillRect(new Rectangle(17, 9, 5, 1), 0xFFF40000);
			fillRect(new Rectangle(0, 17, 1, 5), 0xFFF40000);
			fillRect(new Rectangle(1, 19, 1, 3), 0xFFF40000);
			setPixel32(2, 20, 0xFFF40000);
			fillRect(new Rectangle(5, 14, 1, 3), 0xFFF40000);
			fillRect(new Rectangle(6, 16, 2, 3), 0xFFF40000);
			setPixel32(7, 19, 0xFFF40000);
			
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(5, 11, 1, 2), 0xFFF40000);
				fillRect(new Rectangle(4, 13, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 14, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 15, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 16, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 20, 3, 1), 0xFFF40000);
			}
		}
	}
}