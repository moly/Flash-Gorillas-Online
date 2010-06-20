package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Dungarees
	 * @author moly
	 */
	
	public class PlumberShirt extends BitmapData{
		
		public function PlumberShirt() {
			super(28, 13, true, 0x00000000);
			
			// arms
			fillRect(new Rectangle(3, 2, 4, 1), 0xFFF40000);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFFF40000);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFFF40000);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFFF40000);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFFF40000);
			fillRect(new Rectangle(2, 11, 5, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(3, 12, 5, 1), 0xFFFFFFFF);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFFF40000);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFFF40000);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFFF40000);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFFF40000);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFFF40000);
			fillRect(new Rectangle(21, 11, 5, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(20, 12, 5, 1), 0xFFFFFFFF);
			
			// body
			fillRect(new Rectangle(6, 1, 3, 7), 0xFF3F48CC);
			fillRect(new Rectangle(9, 1, 10, 4), 0xFFF40000);
			fillRect(new Rectangle(19, 1, 3, 7), 0xFF3F48CC);
			setPixel32(9, 5, 0xFF3F48CC);
			fillRect(new Rectangle(10, 5, 8, 1), 0xFFF40000);
			setPixel32(18, 5, 0xFF3F48CC);
			fillRect(new Rectangle(8, 6, 12, 6), 0xFF3F48CC);
			
			fillRect(new Rectangle(10, 7, 2, 2), 0xFFFFF200);
			fillRect(new Rectangle(16, 7, 2, 2), 0xFFFFF200);
		}
	}
}