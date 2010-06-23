package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Green tank top
	 * @author moly
	 */
	
	public class RamboShirt extends BitmapData{
		
		public function RamboShirt(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// body
			fillRect(new Rectangle(7, 9, 14, 7), 0xFF2C4D28);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF2C4D28);
			fillRect(new Rectangle(10, 9, 8, 2), 0x00FFAD51);
			fillRect(new Rectangle(11, 11, 6, 1), 0xFFFFAD51);
			fillRect(new Rectangle(12, 12, 4, 1), 0xFFFFAD51);
		}
	}
}