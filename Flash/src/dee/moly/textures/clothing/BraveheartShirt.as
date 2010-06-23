package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Tartan robe
	 * @author moly
	 */
	
	public class BraveheartShirt extends BitmapData{
		
		public function BraveheartShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(23, 6, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(22, 7, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(22, 8, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(23, 6, 1, 5), 0xFFC48D71);
				fillRect(new Rectangle(25, 6, 1, 4), 0xFFC48D71);
				fillRect(new Rectangle(27, 6, 1, 1), 0xFFC48D71);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFC48D71); 
				fillRect(new Rectangle(1, 12, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(1, 13, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(0, 14, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(1, 12, 1, 3), 0xFFC48D71);
				fillRect(new Rectangle(3, 10, 1, 5), 0xFFC48D71);
				fillRect(new Rectangle(5, 10, 1, 3), 0xFFC48D71);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(0, 6, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(1, 7, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(1, 8, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(1, 6, 1, 3), 0xFFC48D71);
				fillRect(new Rectangle(3, 6, 1, 5), 0xFFC48D71);
				fillRect(new Rectangle(5, 7, 1, 4), 0xFFC48D71);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(22, 12, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(22, 13, 5, 1), 0xFFC48D71);
				fillRect(new Rectangle(23, 14, 5, 1), 0xFF6AAD63);
				fillRect(new Rectangle(23, 10, 1, 5), 0xFFC48D71);
				fillRect(new Rectangle(25, 11, 1, 4), 0xFFC48D71);
				fillRect(new Rectangle(27, 14, 1, 1), 0xFFC48D71);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF6AAD63);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF6AAD63);
			
			fillRect(new Rectangle(6, 9, 16, 1), 0xFFC48D71);
			fillRect(new Rectangle(6, 11, 16, 1), 0xFFC48D71);
			fillRect(new Rectangle(6, 13, 16, 1), 0xFFC48D71);
			fillRect(new Rectangle(6, 15, 16, 1), 0xFFC48D71);
			fillRect(new Rectangle(8, 17, 12, 1), 0xFFC48D71);
			fillRect(new Rectangle(8, 19, 12, 1), 0xFFC48D71);
			
			fillRect(new Rectangle(7, 9, 1, 7), 0xFFC48D71);
			fillRect(new Rectangle(9, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(11, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(13, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(15, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(17, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(19, 9, 1, 11), 0xFFC48D71);
			fillRect(new Rectangle(21, 9, 1, 7), 0xFFC48D71);
			
			// belt
			for (var i:int = 0; i < 11; ++i)
				fillRect(new Rectangle(6 + i, 9 + i, 4, 1), 0xFFB97A57);
		}
	}
}