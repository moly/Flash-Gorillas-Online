package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Clock body
	 * @author moly
	 */
	
	public class ChronoBody extends BitmapData{
		
		public function ChronoBody() {
			super(28, 13, true, 0x00000000);
			
			// arms
			fillRect(new Rectangle(3, 2, 4, 1), 0xFFC60000);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFFC60000);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFFC60000);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(2, 11, 5, 1), 0xFFC60000);
			fillRect(new Rectangle(3, 12, 5, 1), 0xFFC60000);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFFC60000);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFFC60000);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFFC60000);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(21, 11, 5, 1), 0xFFC60000);
			fillRect(new Rectangle(20, 12, 5, 1), 0xFFC60000);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFFC60000);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFFC60000);
			fillRect(new Rectangle(10, 5, 8, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(11, 4, 6, 4), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 3, 4, 6), 0xFFFFFFFF);
			fillRect(new Rectangle(14, 4, 1, 3), 0xFF000000);
			setPixel32(15, 6, 0xFF000000);
			setPixel32(16, 5, 0xFF000000);
		}
	}
}