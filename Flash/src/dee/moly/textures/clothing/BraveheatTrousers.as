package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A kilt
	 * @author moly
	 */
	
	public class BraveheatTrousers extends BitmapData{
		
		public function BraveheatTrousers() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF6AAD63);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFFC48D71);
			fillRect(new Rectangle(5, 2, 17, 1), 0xFF6AAD63);
			fillRect(new Rectangle(5, 3, 17, 1), 0xFFC48D71);
			fillRect(new Rectangle(4, 4, 19, 1), 0xFF6AAD63);
			fillRect(new Rectangle(4, 5, 19, 1), 0xFFC48D71);
			
			fillRect(new Rectangle(5, 2, 1, 4), 0xFFC48D71);
			fillRect(new Rectangle(7, 1, 1, 5), 0xFFC48D71);
			fillRect(new Rectangle(9, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(11, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(13, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(15, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(17, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(19, 0, 1, 6), 0xFFC48D71);
			fillRect(new Rectangle(21, 2, 1, 4), 0xFFC48D71);
		}
	}
}