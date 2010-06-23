package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Green zombie body
	 * @author moly
	 */
	
	public class ZombieBody extends BitmapData{
		
		public function ZombieBody(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFF9FD0A7);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF9FD0A7);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFF9FD0A7);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFF9FD0A7);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFF9FD0A7);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF9FD0A7);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFF9FD0A7);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFF9FD0A7);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFF9FD0A7);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFF9FD0A7);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF9FD0A7);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF9FD0A7);
			
			// chest
			fillRect(new Rectangle(9, 15, 3, 1), 0x000000AD);
			setPixel32(12, 14, 0x000000AD);
			setPixel32(13, 13, 0x000000AD);
			fillRect(new Rectangle(14, 11, 1, 2), 0x000000AD);
			setPixel32(15, 13, 0x000000AD);
			setPixel32(16, 14, 0x000000AD);
			fillRect(new Rectangle(17, 15, 3, 1), 0x000000AD);
		}
	}
}