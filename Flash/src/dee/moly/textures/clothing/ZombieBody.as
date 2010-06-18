package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Green zombie body
	 * @author moly
	 */
	
	public class ZombieBody extends BitmapData{
		
		public function ZombieBody() {
			super(28, 13, true, 0x00000000);
			
			// arms
			fillRect(new Rectangle(3, 2, 4, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFF9FD0A7);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFF9FD0A7);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFF9FD0A7);
			fillRect(new Rectangle(2, 11, 5, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(3, 12, 5, 1), 0xFF9FD0A7);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFF9FD0A7);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFF9FD0A7);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFF9FD0A7);
			fillRect(new Rectangle(21, 11, 5, 1), 0xFF9FD0A7);
			fillRect(new Rectangle(20, 12, 5, 1), 0xFF9FD0A7);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFF9FD0A7);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFF9FD0A7);
			
			// chest
			fillRect(new Rectangle(9, 7, 3, 1), 0x000000AD);
			setPixel32(12, 6, 0x000000AD);
			setPixel32(13, 5, 0x000000AD);
			fillRect(new Rectangle(14, 3, 1, 2), 0x000000AD);
			setPixel32(15, 5, 0x000000AD);
			setPixel32(16, 6, 0x000000AD);
			fillRect(new Rectangle(17, 7, 3, 1), 0x000000AD);
		}
	}
}