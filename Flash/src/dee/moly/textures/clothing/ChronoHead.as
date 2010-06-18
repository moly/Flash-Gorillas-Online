package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * White head with red ears
	 * @author moly
	 */
	
	public class ChronoHead extends BitmapData{
		
		public function ChronoHead() {
			super(12, 14, true, 0x00000000);
			
			// draw head
			fillRect(new Rectangle(2, 6, 8, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 8, 10, 6), 0xFFFFFFFF);
			
			// draw eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0x000000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(6 + i, 10, 0x000000AD);
				setPixel32(9 + i, 10, 0x000000AD);
			}
			
			// ears
			fillRect(new Rectangle(2, 6, 2, 1), 0xFFC60000);
			fillRect(new Rectangle(8, 6, 2, 1), 0xFFC60000);
			setPixel32(2, 7, 0xFFC60000);
			setPixel32(9, 7, 0xFFC60000);
		}
	}
}