package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Peg leg
	 * @author moly
	 */
	
	public class PirateTrousers extends BitmapData{
		
		public function PirateTrousers() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF000000);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFF000000);
			fillRect(new Rectangle(5, 2, 6, 1), 0xFF000000);
			fillRect(new Rectangle(5, 3, 5, 1), 0xFF000000);
			fillRect(new Rectangle(4, 4, 5, 1), 0xFF000000);
			fillRect(new Rectangle(4, 5, 5, 4), 0xFF0000AD);
			fillRect(new Rectangle(5, 9, 5, 1), 0xFF0000AD);
			fillRect(new Rectangle(5, 5, 3, 1), 0xFF9D6042);
			fillRect(new Rectangle(6, 6, 1, 4), 0xFF9D6042);
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF000000);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF000000);
			fillRect(new Rectangle(18, 4, 5, 2), 0xFF000000);
		}
	}
}