package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Denim jeans and white trainers
	 * @author moly
	 */
	
	public class PokeTrousers extends BitmapData{
		
		public function PokeTrousers() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF3F48CC);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFF3F48CC);
			fillRect(new Rectangle(5, 2, 6, 1), 0xFF3F48CC);
			fillRect(new Rectangle(5, 3, 5, 1), 0xFF3F48CC);
			fillRect(new Rectangle(4, 4, 5, 5), 0xFF3F48CC);
			fillRect(new Rectangle(4, 8, 5, 1), 0xFF000000);
			fillRect(new Rectangle(5, 8, 3, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(5, 9, 5, 1), 0xFF000000);
			fillRect(new Rectangle(6, 9, 3, 1), 0xFFFFFFFF);
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF3F48CC);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF3F48CC);
			fillRect(new Rectangle(18, 4, 5, 5), 0xFF3F48CC);
			fillRect(new Rectangle(18, 8, 5, 1), 0xFF000000);
			fillRect(new Rectangle(19, 8, 3, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(17, 9, 5, 1), 0xFF000000);
			fillRect(new Rectangle(18, 9, 3, 1), 0xFFFFFFFF);
		}
	}
}