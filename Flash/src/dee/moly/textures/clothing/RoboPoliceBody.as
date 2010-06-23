package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import dee.moly.textures.*;
	import flash.geom.Rectangle;
	
	/**
	 * Gorilla-robot police armour
	 * @author moly
	 */
	
	public class RoboPoliceBody extends BitmapData{
		
		public function RoboPoliceBody(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFF000000);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFF000000);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFF000000);
				fillRect(new Rectangle(23, 4, 5, 1), 0xFF000000);
				fillRect(new Rectangle(23, 5, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF7F7F7F);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(0, 14, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(0, 16, 5, 1), 0xFF000000);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFF000000);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFF000000);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFF000000);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFF000000);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFF000000);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFF000000);
				fillRect(new Rectangle(0, 4, 5, 1), 0xFF000000);
				fillRect(new Rectangle(0, 5, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF7F7F7F);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF7F7F7F);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(23, 14, 5, 2), 0xFF7F7F7F);
				fillRect(new Rectangle(23, 16, 5, 1), 0xFF000000);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFF000000);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFF000000);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFF000000);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF7F7F7F);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF000000);
			fillRect(new Rectangle(11, 9, 6, 1), 0xFF000000);
			setPixel32(14, 13, 0xFF000000);
			fillRect(new Rectangle(13, 14, 3, 1), 0xFF000000);
			fillRect(new Rectangle(12, 15, 5, 1), 0xFF000000);
		}
	}
}