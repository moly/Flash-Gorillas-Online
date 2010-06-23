package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.GorillaTex;
	
	/**
	 * Stripey shirt
	 * @author moly
	 */
	
	public class PirateShirt extends BitmapData{
		
		public function PirateShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// sleves
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 4, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(23, 6, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 7, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(22, 8, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 9, 4, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 10, 3, 1), 0xFFFFFFFF);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 12, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(1, 13, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 14, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 15, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(0, 4, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(0, 6, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 7, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 8, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFFFFFFFF);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 12, 5, 1), 0xFFF40000);
				fillRect(new Rectangle(22, 13, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 14, 5, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 15, 5, 2), 0xFFF40000);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFFFFFFFF);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 10, 4, 2), 0xFFF40000);
			fillRect(new Rectangle(10, 11, 9, 2), 0xFFF40000);
			fillRect(new Rectangle(18, 10, 4, 2), 0xFFF40000);
			fillRect(new Rectangle(6, 14, 3, 2), 0xFFF40000);
			fillRect(new Rectangle(9, 15, 10, 2), 0xFFF40000);
			fillRect(new Rectangle(19, 14, 3, 2), 0xFFF40000);
			fillRect(new Rectangle(8, 19, 12, 1), 0xFFF40000);
			setPixel32(8, 18, 0xFFF40000);
			setPixel32(19, 18, 0xFFF40000);
			fillRect(new Rectangle(12, 9, 4, 1), 0x00FFFFFF);
		}
	}
}