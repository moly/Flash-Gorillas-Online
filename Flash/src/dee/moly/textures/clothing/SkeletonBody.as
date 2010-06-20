package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Ribs and a pelvis
	 * @author moly
	 */
	
	public class SkeletonBody extends BitmapData{
		
		public function SkeletonBody() {
			super(28, 13, true, 0x00000000);
			
			// arms
			fillRect(new Rectangle(3, 2, 4, 1), 0xFF0000AD);
			fillRect(new Rectangle(2, 3, 4, 1), 0xFF0000AD);
			fillRect(new Rectangle(1, 4, 5, 2), 0xFF0000AD);
			fillRect(new Rectangle(0, 6, 5, 3), 0xFF0000AD);
			fillRect(new Rectangle(1, 9, 5, 2), 0xFF0000AD);
			fillRect(new Rectangle(2, 11, 5, 1), 0xFF0000AD);
			fillRect(new Rectangle(3, 12, 5, 1), 0xFF0000AD);
			
			fillRect(new Rectangle(21, 2, 4, 1), 0xFF0000AD);
			fillRect(new Rectangle(22, 3, 4, 1), 0xFF0000AD);
			fillRect(new Rectangle(22, 4, 5, 2), 0xFF0000AD);
			fillRect(new Rectangle(23, 6, 5, 3), 0xFF0000AD);
			fillRect(new Rectangle(22, 9, 5, 2), 0xFF0000AD);
			fillRect(new Rectangle(21, 11, 5, 1), 0xFF0000AD);
			fillRect(new Rectangle(20, 12, 5, 1), 0xFF0000AD);
			
			// body
			fillRect(new Rectangle(6, 1, 16, 7), 0xFF0000AD);
			fillRect(new Rectangle(8, 8, 12, 4), 0xFF0000AD);
			fillRect(new Rectangle(13, 1, 2, 10), 0xFFFFFFFF);
			fillRect(new Rectangle(9, 2, 10, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(9, 5, 10, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(10, 8, 8, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 10, 4, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 11, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(16, 10, 4, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(7, 3, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 4, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 5, 1, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 6, 2, 1), 0xFFFFFFFF);
			setPixel32(8, 7, 0xFFFFFFFF);
			setPixel32(10, 11, 0xFF0000AD);
			fillRect(new Rectangle(19, 3, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(20, 4, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(21, 5, 1, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(18, 6, 2, 1), 0xFFFFFFFF);
			setPixel32(19, 7, 0xFFFFFFFF);
			setPixel32(17, 11, 0xFF0000AD);
			
			// arms
			fillRect(new Rectangle(7, 1, 2, 1), 0xFFFFFFFF);
			setPixel32(6, 2, 0xFFFFFFFF);
			setPixel32(5, 3, 0xFFFFFFFF);
			setPixel32(4, 4, 0xFFFFFFFF);
			setPixel32(3, 5, 0xFFFFFFFF);
			fillRect(new Rectangle(2, 6, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(1, 7, 2, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(2, 9, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(3, 10, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(4, 11, 3, 1), 0xFFFFFFFF);
			setPixel32(3, 12, 0xFFFFFFFF);
			setPixel32(5, 12, 0xFFFFFFFF);
			setPixel32(7, 12, 0xFFFFFFFF);
			
			fillRect(new Rectangle(19, 1, 2, 1), 0xFFFFFFFF);
			setPixel32(21, 2, 0xFFFFFFFF);
			setPixel32(22, 3, 0xFFFFFFFF);
			setPixel32(23, 4, 0xFFFFFFFF);
			setPixel32(24, 5, 0xFFFFFFFF);
			fillRect(new Rectangle(24, 6, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(25, 7, 2, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(24, 9, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(23, 10, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(21, 11, 3, 1), 0xFFFFFFFF);
			setPixel32(20, 12, 0xFFFFFFFF);
			setPixel32(22, 12, 0xFFFFFFFF);
			setPixel32(24, 12, 0xFFFFFFFF);
		}
	}
}