package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Clock body
	 * @author moly
	 */
	
	public class ChronoBody extends BitmapData{
		
		public function ChronoBody(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFC60000);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFC60000);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFC60000);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFFC60000);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFC60000);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFC60000);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFC60000);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFFC60000);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFFC60000);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFFC60000);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFFC60000);
			fillRect(new Rectangle(10, 13, 8, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(11, 12, 6, 4), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 11, 4, 6), 0xFFFFFFFF);
			fillRect(new Rectangle(14, 12, 1, 3), 0xFF000000);
			setPixel32(15, 14, 0xFF000000);
			setPixel32(16, 13, 0xFF000000);
		}
	}
}