package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Red body with claws
	 * @author moly
	 */
	
	public class LobsterBody extends BitmapData{
		
		public function LobsterBody(arms:int) {
			super(28, 25, true, 0x00000000);
			
			// arms
			if (arms == GorillaTex.RIGHT_ARM) {
				fillRect(new Rectangle(20, 0, 3, 1), 0xFF0000AD);
				fillRect(new Rectangle(22, 1, 2, 1), 0xFF0000AD);
				setPixel32(21, 1, 0xFFF40000);
				//fillRect(new Rectangle(22, 0, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(23, 0, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(24, 1, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(21, 2, 6, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 3, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(22, 9, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(21, 10, 4, 1), 0xFFF40000);
			}
			
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 11, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(1, 17, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 18, 6, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 19, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 20, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 21, 3, 1), 0xFFF40000);
				setPixel32(6, 19, 0xFFF40000);
				fillRect(new Rectangle(4, 19, 2, 1), 0xFF0000AD);
				fillRect(new Rectangle(5, 20, 3, 1), 0xFF0000AD);
			}
			
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(5, 0, 3, 1), 0xFF0000AD);
				fillRect(new Rectangle(4, 1, 2, 1), 0xFF0000AD);
				setPixel32(6, 1, 0xFFF40000);
				fillRect(new Rectangle(2, 0, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 1, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 2, 6, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 3, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(2, 9, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 10, 4, 1), 0xFFF40000);
			}
			
			if(arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(21, 10, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 11, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFFF40000);
				fillRect(new Rectangle(22, 17, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(21, 18, 6, 1), 0xFFF40000);
				fillRect(new Rectangle(24, 19, 2, 1), 0xFFF40000);
				fillRect(new Rectangle(23, 20, 3, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 21, 3, 1), 0xFFF40000);
				setPixel32(21, 19, 0xFFF40000);
				fillRect(new Rectangle(22, 19, 2, 1), 0xFF0000AD);
				fillRect(new Rectangle(20, 20, 3, 1), 0xFF0000AD);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFFF40000);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFFF40000);
			
			// chest
			fillRect(new Rectangle(9, 15, 3, 1), 0x000000AD);
			setPixel32(12, 14, 0x000000AD);
			setPixel32(13, 13, 0x000000AD);
			fillRect(new Rectangle(14, 11, 1, 2), 0x000000AD);
			setPixel32(15, 13, 0x000000AD);
			setPixel32(16, 14, 0x000000AD);
			fillRect(new Rectangle(17, 15, 3, 1), 0x000000AD);
			
			fillRect(new Rectangle(9, 19, 3, 1), 0xFF0000AD);
			setPixel32(12, 18, 0xFF0000AD);
			setPixel32(13, 17, 0xFF0000AD);
			fillRect(new Rectangle(14, 15, 1, 2), 0xFF0000AD);
			setPixel32(15, 17, 0xFF0000AD);
			setPixel32(16, 18, 0xFF0000AD);
			fillRect(new Rectangle(17, 19, 2, 1), 0xFF0000AD);
		}
	}
}