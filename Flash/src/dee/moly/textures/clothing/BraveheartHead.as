package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * William Wallace
	 * @author moly
	 */
	
	public class BraveheartHead extends BitmapData{
		
		public function BraveheartHead() {
			super(12, 14, true, 0x00000000);
			
			// head
			fillRect(new Rectangle(2, 4, 8, 2), 0xFF462C1E);
			fillRect(new Rectangle(10, 5, 1, 3), 0xFF462C1E);
			fillRect(new Rectangle(1, 5, 1, 3), 0xFF462C1E);
			fillRect(new Rectangle(0, 7, 1, 7), 0xFF462C1E);
			fillRect(new Rectangle(1, 11, 1, 3), 0xFF462C1E);
			setPixel32(2, 13, 0xFF462C1E);
			
			fillRect(new Rectangle(2, 6, 8, 7), 0xFF3F48CC);
			fillRect(new Rectangle(1, 8, 10, 3), 0xFF3F48CC);
			fillRect(new Rectangle(7, 6, 3, 6), 0xFFFFFFFF);
			
			// eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0x000000AD);
			
			// nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(6 + i, 10, 0x000000AD);
				setPixel32(9 + i, 10, 0x000000AD);
			}
			
			// neck
			fillRect(new Rectangle(3, 13, 6, 1), 0xFF3F48CC);
		}
	}
}