package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * a zombie's head
	 * @author moly
	 */
	
	public class ZombieHead extends BitmapData{
		
		public function ZombieHead() {
			super(12, 14, true, 0x00000000);
			
			// draw head
			fillRect(new Rectangle(2, 6, 8, 7), 0xFF9FD0A7);
			fillRect(new Rectangle(1, 8, 10, 3), 0xFF9FD0A7);
			
			// draw eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0x000000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(6 + i, 10, 0x000000AD);
				setPixel32(9 + i, 10, 0x000000AD);
			}
			
			// neck
			fillRect(new Rectangle(3, 13, 6, 1), 0xFF9FD0A7);
			
			// head wound
			setPixel32(1, 8, 0xFF0000AD);
			fillRect(new Rectangle(2, 6, 2, 1), 0xFF0000AD);
			fillRect(new Rectangle(1, 9, 3, 1), 0xFFED1C24);
			setPixel32(3, 8, 0xFFED1C24);
			fillRect(new Rectangle(4, 6, 1, 3), 0xFFED1C24);
			setPixel32(2, 8, 0xFFFFC6D9);
			setPixel32(2, 7, 0xFFFFC6D9);
			setPixel32(3, 7, 0xFFFFC6D9);
		}
	}
}