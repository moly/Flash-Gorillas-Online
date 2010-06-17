package dee.moly.textures {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Black trousers
	 * @author moly
	 */
	
	public class TuxTrousers extends BitmapData{
		
		public function TuxTrousers() {
			
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF000000);
			fillRect(new Rectangle(7, 1, 13, 2), 0xFF000000);
			fillRect(new Rectangle(5, 2, 5, 2), 0xFF000000);
			fillRect(new Rectangle(4, 4, 5, 5), 0xFF000000);
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF000000);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF000000);
			fillRect(new Rectangle(18, 4, 5, 5), 0xFF000000);			
		}
	}
}