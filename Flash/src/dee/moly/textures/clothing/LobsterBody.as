package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Red body with claws
	 * @author moly
	 */
	
	public class LobsterBody extends BitmapData{
		
		public function LobsterBody() {
			super(28, 14, true, 0x00000000);
			
			// arms
			fillRect(new Rectangle(3, 2, 4, 1), 0xFFFD330F);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFFFD330F);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFFFD330F);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFFFD330F);
			fillRect(new Rectangle(1, 9, 5, 1), 0xFFFD330F);
			fillRect(new Rectangle(1, 10, 6, 1), 0xFFFD330F);
			fillRect(new Rectangle(2, 11, 2, 1), 0xFFFD330F);
			fillRect(new Rectangle(2, 12, 3, 1), 0xFFFD330F);
			fillRect(new Rectangle(3, 13, 3, 1), 0xFFFD330F);
			setPixel32(6, 11, 0xFFFD330F);
			fillRect(new Rectangle(4, 11, 2, 1), 0xFF0000AD);
			fillRect(new Rectangle(5, 12, 3, 1), 0xFF0000AD);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFFFD330F);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFFFD330F);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFFFD330F);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFFFD330F);
			fillRect(new Rectangle(22, 9, 5, 1), 0xFFFD330F);
			fillRect(new Rectangle(21, 10, 6, 1), 0xFFFD330F);
			fillRect(new Rectangle(24, 11, 2, 1), 0xFFFD330F);
			fillRect(new Rectangle(23, 12, 3, 1), 0xFFFD330F);
			fillRect(new Rectangle(22, 13, 3, 1), 0xFFFD330F);
			setPixel32(21, 11, 0xFFFD330F);
			fillRect(new Rectangle(22, 11, 2, 1), 0xFF0000AD);
			fillRect(new Rectangle(20, 12, 3, 1), 0xFF0000AD);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFFFD330F);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFFFD330F);
			
			// chest
			fillRect(new Rectangle(9, 7, 3, 1), 0x000000AD);
			setPixel32(12, 6, 0x000000AD);
			setPixel32(13, 5, 0x000000AD);
			fillRect(new Rectangle(14, 3, 1, 2), 0x000000AD);
			setPixel32(15, 5, 0x000000AD);
			setPixel32(16, 6, 0x000000AD);
			fillRect(new Rectangle(17, 7, 3, 1), 0x000000AD);
			
			fillRect(new Rectangle(9, 11, 3, 1), 0xFF0000AD);
			setPixel32(12, 10, 0xFF0000AD);
			setPixel32(13, 9, 0xFF0000AD);
			fillRect(new Rectangle(14, 7, 1, 2), 0xFF0000AD);
			setPixel32(15, 9, 0xFF0000AD);
			setPixel32(16, 10, 0xFF0000AD);
			fillRect(new Rectangle(17, 11, 2, 1), 0xFF0000AD);
		}
	}
}