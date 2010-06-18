package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Lobster head with antenae
	 * @author moly
	 */
	
	public class LobsterHead extends BitmapData{
		
		public function LobsterHead() {
			super(12, 14, true, 0x00000000);
			
			// draw head
			fillRect(new Rectangle(2, 6, 8, 7), 0xFFFD330F);
			fillRect(new Rectangle(1, 8, 10, 3), 0xFFFD330F);
			
			// draw eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0x000000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(6 + i, 10, 0x000000AD);
				setPixel32(9 + i, 10, 0x000000AD);
			}
			
			// neck
			fillRect(new Rectangle(3, 13, 6, 1), 0xFFFD330F);
			
			// antenna
			fillRect(new Rectangle(4, 1, 1, 2), 0xFFFD330F);
			fillRect(new Rectangle(3, 2, 1, 4), 0xFFFD330F);
			fillRect(new Rectangle(9, 1, 1, 2), 0xFFFD330F);
			fillRect(new Rectangle(8, 2, 1, 4), 0xFFFD330F);
		}
	}
}