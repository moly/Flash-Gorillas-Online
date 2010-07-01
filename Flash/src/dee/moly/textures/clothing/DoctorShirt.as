package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import dee.moly.textures.GorillaTex;
	import flash.geom.Rectangle;
	
	/**
	 * Doctor's coat
	 * @author moly
	 */
	
	public class DoctorShirt extends BitmapData{
		
		public function DoctorShirt(arms:int) {
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
			fillRect(new Rectangle(12, 9, 4, 1), 0x00FFFFFF);
			
			// red cross
			fillRect(new Rectangle(17, 12, 3, 1), 0xFFF40000);
			fillRect(new Rectangle(18, 11, 1, 3), 0xFFF40000);
		}
	}
}