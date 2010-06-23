package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import dee.moly.textures.*;
	import flash.geom.Rectangle;
	
	/**
	 * A blue shirt with white sleeves
	 * @author moly
	 */
	
	public class PokeShirt extends BitmapData{
		
		public function PokeShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(21, 1, 5, 1), 0xFF2C4D28);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFFFFF);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFF2C4D28);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(2, 1, 5, 1), 0xFF2C4D28);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFF2C4D28);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF242C84);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF242C84);
			fillRect(new Rectangle(10, 9, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(17, 9, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(9, 10, 3, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(17, 10, 3, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 9, 5, 1), 0x00000000);
			fillRect(new Rectangle(12, 10, 5, 10), 0xFF0C0E29);
		}
	}
}