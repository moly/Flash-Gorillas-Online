package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Dungarees
	 * @author moly
	 */
	
	public class PlumberShirt extends BitmapData{
		
		public function PlumberShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFF40000);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFF40000);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFFFFFFFF);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 3, 7), 0xFF3F48CC);
			fillRect(new Rectangle(9, 9, 10, 4), 0xFFF40000);
			fillRect(new Rectangle(19, 9, 3, 7), 0xFF3F48CC);
			setPixel32(9, 13, 0xFF3F48CC);
			fillRect(new Rectangle(10, 13, 8, 1), 0xFFF40000);
			setPixel32(18, 13, 0xFF3F48CC);
			fillRect(new Rectangle(8, 14, 12, 6), 0xFF3F48CC);
			
			fillRect(new Rectangle(10, 15, 2, 2), 0xFFFFF200);
			fillRect(new Rectangle(16, 15, 2, 2), 0xFFFFF200);
		}
	}
}