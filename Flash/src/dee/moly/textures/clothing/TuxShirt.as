package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A tuxuedo
	 * @author moly
	 */
	
	public class TuxShirt extends BitmapData{
		
		public function TuxShirt() {
			super(28, 12, true, 0x00000000);
			
			// sleves
			fillRect(new Rectangle(3, 2, 4, 1), 0xFF000000);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFF000000);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFF000000);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFF000000);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFF000000);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFF000000);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFF000000);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFF000000);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFF000000);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFF000000);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFF000000);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFF000000);
			fillRect(new Rectangle(11, 1, 6, 3), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 4, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(13, 5, 2, 1), 0xFFFFFFFF);
			
			// bow tie
			fillRect(new Rectangle(12, 0, 1, 3), 0xFFED1C24);
			fillRect(new Rectangle(13, 1, 2, 1), 0xFFED1C24);
			fillRect(new Rectangle(15, 0, 1, 3), 0xFFED1C24);
		}
	}
}