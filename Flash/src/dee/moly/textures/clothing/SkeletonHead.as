package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A gorilla skull
	 * @author moly
	 */
	
	public class SkeletonHead extends BitmapData{
		
		public function SkeletonHead() {
			super(12, 14, true, 0x00000000);
			
			// draw head
			fillRect(new Rectangle(2, 6, 8, 7), 0xFF0000AD);
			fillRect(new Rectangle(1, 8, 10, 3), 0xFF0000AD);
			fillRect(new Rectangle(3, 6, 6, 7), 0xFFFFFFFF);
			fillRect(new Rectangle(2, 7, 8, 5), 0xFFFFFFFF);
			
			// draw eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0x000000AD);
			
			// draw nose
			for (var i:int = -2; i <= -1; i++){
				setPixel32(6 + i, 10, 0x000000AD);
				setPixel32(9 + i, 10, 0x000000AD);
			}
			
			// neck
			fillRect(new Rectangle(3, 13, 6, 1), 0xFF0000AD);
			fillRect(new Rectangle(5, 13, 2, 1), 0xFFFFFFFF);
		}
	}
}