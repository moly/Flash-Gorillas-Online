package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Super hero trousers
	 * @author moly
	 */
	
	public class SuperTrousers extends BitmapData{
		
		public function SuperTrousers() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFFFFC90E);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFFF40000);
			fillRect(new Rectangle(8, 2, 3, 1), 0xFFF40000);
			fillRect(new Rectangle(16, 2, 3, 1), 0xFFF40000);
			setPixel32(9, 3, 0xFFF40000);
			setPixel32(17, 3, 0xFFF40000);
			
			fillRect(new Rectangle(5, 2, 3, 1), 0xFF3F48CC);
			fillRect(new Rectangle(5, 3, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(4, 4, 5, 4), 0xFF3F48CC);
			fillRect(new Rectangle(4, 8, 5, 1), 0xFFF40000);
			fillRect(new Rectangle(5, 9, 5, 1), 0xFFF40000);
			
			fillRect(new Rectangle(19, 2, 3, 1), 0xFF3F48CC);
			fillRect(new Rectangle(18, 3, 4, 1), 0xFF3F48CC);
			fillRect(new Rectangle(18, 4, 5, 4), 0xFF3F48CC);
			fillRect(new Rectangle(18, 8, 5, 1), 0xFFF40000);
			fillRect(new Rectangle(17, 9, 5, 1), 0xFFF40000);
		}
	}
}