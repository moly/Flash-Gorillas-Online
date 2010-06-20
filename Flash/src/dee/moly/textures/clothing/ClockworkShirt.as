package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * White shirt
	 * @author moly
	 */
	
	public class ClockworkShirt extends BitmapData{
		
		public function ClockworkShirt() {
			super(28, 12, true, 0x00000000);
			
			// sleves
			fillRect(new Rectangle(3, 2, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFFFFFFFF);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFFFFFFFF);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFFFFFFFF);
			fillRect(new Rectangle(13, 1, 2, 1), 0x00FFFFFF);
		}
	}
}