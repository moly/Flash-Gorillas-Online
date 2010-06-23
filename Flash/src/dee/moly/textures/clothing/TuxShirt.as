package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * A tuxuedo
	 * @author moly
	 */
	
	public class TuxShirt extends BitmapData{
		
		public function TuxShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(22, 2, 5, 2), 0xFF000000);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFF000000);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF000000);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF000000);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF000000);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF000000);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF000000);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF000000);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFF000000);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFF000000);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(1, 2, 5, 2), 0xFF000000);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFF000000);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF000000);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF000000);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF000000);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF000000);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF000000);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF000000);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFF000000);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFF000000);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF000000);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF000000);
			fillRect(new Rectangle(11, 9, 6, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 12, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(13, 13, 2, 1), 0xFFFFFFFF);
			
			// bow tie
			fillRect(new Rectangle(12, 8, 1, 3), 0xFFED1C24);
			fillRect(new Rectangle(13, 9, 2, 1), 0xFFED1C24);
			fillRect(new Rectangle(15, 8, 1, 3), 0xFFED1C24);
		}
	}
}