package dee.moly.textures {
	
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	
	/**
	 * the eponymous gorillas
	 * it's a nose apparently
	 * @author moly
	 */
	
	public class GorillaTex extends BitmapData{
		
		public static const LEFT_ARM:int = 0;
		public static const RIGHT_ARM:int = 1;
		public static const ARMS_DOWN:int = 2;
		
		public function GorillaTex(arms:int) {
			super(28, 30, true, 0x00);
			
			// draw head
			fillRect(new Rectangle(10, 1, 8, 7), 0xFFFFAD51);
			fillRect(new Rectangle(9, 3, 10, 3), 0xFFFFAD51);
			
			// draw eyes/brow
			fillRect(new Rectangle(11, 3, 6, 1), 0x000000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(14 + i, 5, 0x000000AD);
				setPixel32(17 + i, 5, 0x000000AD);
			}
			
			// neck
			fillRect(new Rectangle(11, 8, 6, 1), 0xFFFFAD51);
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFFFFAD51);
			fillRect(new Rectangle(8, 16, 12, 6), 0xFFFFAD51);
			
			// legs
			fillRect(new Rectangle(7, 21, 4, 2), 0xFFFFAD51);
			fillRect(new Rectangle(5, 22, 5, 2), 0xFFFFAD51);
			fillRect(new Rectangle(4, 24, 5, 5), 0xFFFFAD51);
			fillRect(new Rectangle(5, 29, 5, 1), 0xFFFFAD51);
			
			fillRect(new Rectangle(16, 22, 6, 1), 0xFFFFAD51);
			fillRect(new Rectangle(17, 23, 5, 1), 0xFFFFAD51);
			fillRect(new Rectangle(18, 24, 5, 5), 0xFFFFAD51);
			fillRect(new Rectangle(17, 29, 5, 1), 0xFFFFAD51);

			// chest
			fillRect(new Rectangle(9, 15, 3, 1), 0x000000AD);
			setPixel32(12, 14, 0x000000AD);
			setPixel32(13, 13, 0x000000AD);
			fillRect(new Rectangle(14, 11, 1, 2), 0x000000AD);
			setPixel32(15, 13, 0x000000AD);
			setPixel32(16, 14, 0x000000AD);
			fillRect(new Rectangle(17, 15, 3, 1), 0x000000AD);
			
			// arms
			if(arms == RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFAD51);
			}	
			if(arms == RIGHT_ARM || arms == ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFFFFAD51);
			}
			if (arms == LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFAD51);
			}
			if (arms == LEFT_ARM || arms == ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFFFFAD51);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFFFFAD51);
			}
		}
	}
}