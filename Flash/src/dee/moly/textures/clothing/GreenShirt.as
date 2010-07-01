package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import dee.moly.textures.GorillaTex;
	import flash.geom.Rectangle;
	
	/**
	 * Plain red shirt
	 * @author moly
	 */
	
	public class GreenShirt extends BitmapData{
		
		public function GreenShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF00F400);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF00F400);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF00F400);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF00F400);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF00F400);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF00F400);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF00F400);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF00F400);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF00F400);
		}
	}
}