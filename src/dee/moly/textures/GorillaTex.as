package dee.moly.textures {
	
	import flash.geom.Rectangle;
	
	/**
	 * the eponymous gorillas
	 * it's a nose apparently
	 * @author moly
	 */
	
	public class GorillaTex extends DrawingBitmap{
		
		public static const LEFT_ARM:int = 0;
		public static const RIGHT_ARM:int = 1;
		public static const ARMS_DOWN:int = 2;
		
		public function GorillaTex(arms:int) {
			
			super(28, 30, true, 0x00);
			
			// draw head
			fillRect(new Rectangle(10, 1, 8, 7), 0xFFFFAD51);
			fillRect(new Rectangle(9, 3, 10, 3), 0xFFFFAD51);
			
			// draw eyes/brow
			fillRect(new Rectangle(11, 3, 6, 1), 0xFF0000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel(14 + i, 5, 0x0000AD);
				setPixel(17 + i, 5, 0x0000AD);
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
			circle(10, 11, 4, 0x0000AD);
			circle(18, 11, 4, 0x0000AD);
			
			for (i = -5; i <= -1; i++) {
				switch(arms) {
					case RIGHT_ARM:
						circle(13 + i, 15, 8, 0xFFAD51);
						circle(20 + i, 5, 8, 0xFFAD51);
						break;
					case LEFT_ARM:
						circle(13 + i, 5, 8, 0xFFAD51);
						circle(20 + i, 15, 8, 0xFFAD51);
						break;
					case ARMS_DOWN:
						circle(13 + i, 15, 8, 0xFFAD51);
						circle(20 + i, 15, 8, 0xFFAD51);
						break;						
				}
			}
			
			if(arms == RIGHT_ARM || arms == ARMS_DOWN){
				setPixel(2, 10, 0x0000AD);
				setPixel(1, 11, 0x0000AD);
				setPixel(1, 19, 0x0000AD);
				setPixel(2, 20, 0x0000AD);
				setPixel(6, 19, 0xFFAD51);
				setPixel(7, 20, 0xFFAD51);
			}
			
			if(arms == RIGHT_ARM){
				setPixel(20, 0, 0xFFAD51);
				setPixel(21, 1, 0xFFAD51);
				setPixel(25, 0, 0x0000AD);
				setPixel(26, 1, 0x0000AD);
				setPixel(26, 9, 0x0000AD);
				setPixel(25, 10, 0x0000AD);
			}
			
			if (arms == LEFT_ARM || arms == ARMS_DOWN) {
				setPixel(25, 10, 0x0000AD);
				setPixel(26, 11, 0x0000AD);
				setPixel(26, 19, 0x0000AD);
				setPixel(25, 20, 0x0000AD);
				setPixel(21, 19, 0xFFAD51);
				setPixel(20, 20, 0xFFAD51);
			}
			
			if (arms == LEFT_ARM) {
				setPixel(2, 0, 0x0000AD);
				setPixel(1, 1, 0x0000AD);
				setPixel(1, 9, 0x0000AD);
				setPixel(2, 10, 0x0000AD);
				setPixel(7, 0, 0xFFAD51);
				setPixel(6, 1, 0xFFAD51);
			}

		}
		
	}

}