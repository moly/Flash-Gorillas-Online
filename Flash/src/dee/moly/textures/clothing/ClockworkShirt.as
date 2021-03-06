package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * White shirt
	 * @author moly
	 */
	
	public class ClockworkShirt extends BitmapData{
		
		public function ClockworkShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFFFFF);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFFFFFFFF);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFFFFFFFF);
			fillRect(new Rectangle(13, 9, 2, 1), 0x00FFFFFF);
		}
	}
}