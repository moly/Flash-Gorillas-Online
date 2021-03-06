package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Red shorts
	 * @author moly
	 */
	
	public class GreenTrousers extends BitmapData{
		
		public function GreenTrousers() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF00F400);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFF00F400);
			fillRect(new Rectangle(5, 2, 6, 1), 0xFF00F400);
			fillRect(new Rectangle(5, 3, 5, 1), 0xFF00F400);
			fillRect(new Rectangle(4, 4, 5, 2), 0xFF00F400);
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF00F400);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF00F400);
			fillRect(new Rectangle(18, 4, 5, 2), 0xFF00F400);
		}
	}
}