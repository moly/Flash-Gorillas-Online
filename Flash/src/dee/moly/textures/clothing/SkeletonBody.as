package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import dee.moly.textures.*;
	
	/**
	 * Ribs and a pelvis
	 * @author moly
	 */
	
	public class SkeletonBody extends BitmapData{
		
		public function SkeletonBody(arms:int) {
			super(28, 24, true, 0x00000000);
			
			// arms
			if(arms == GorillaTex.RIGHT_ARM){
				fillRect(new Rectangle(20, 0, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(21, 1, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFF0000AD);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(21, 9, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF0000AD);
			}	
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(2, 11, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(1, 12, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(0, 14, 5, 3), 0xFF0000AD);
				fillRect(new Rectangle(1, 17, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(2, 19, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(3, 20, 5, 1), 0xFF0000AD);
			}
			if (arms == GorillaTex.LEFT_ARM) {
				fillRect(new Rectangle(3, 0, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(2, 1, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFF0000AD);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(2, 9, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(3, 10, 5, 1), 0xFF0000AD);
			}
			if (arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN) {
				fillRect(new Rectangle(20, 10, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(21, 11, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(22, 12, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(23, 14, 5, 3), 0xFF0000AD);
				fillRect(new Rectangle(22, 17, 5, 2), 0xFF0000AD);
				fillRect(new Rectangle(21, 19, 5, 1), 0xFF0000AD);
				fillRect(new Rectangle(20, 20, 5, 1), 0xFF0000AD);
			}
			
			// body
			fillRect(new Rectangle(6, 9, 16, 7), 0xFF0000AD);
			fillRect(new Rectangle(8, 16, 12, 4), 0xFF0000AD);
			fillRect(new Rectangle(13, 9, 2, 10), 0xFFFFFFFF);
			fillRect(new Rectangle(9, 10, 10, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(9, 13, 10, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(10, 16, 8, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 18, 4, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(12, 19, 4, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(16, 18, 4, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(7, 11, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 12, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 13, 1, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(8, 14, 2, 1), 0xFFFFFFFF);
			setPixel32(8, 15, 0xFFFFFFFF);
			setPixel32(10, 19, 0xFF0000AD);
			fillRect(new Rectangle(19, 11, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(20, 12, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(21, 13, 1, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(18, 14, 2, 1), 0xFFFFFFFF);
			setPixel32(19, 15, 0xFFFFFFFF);
			setPixel32(17, 19, 0xFF0000AD);
			
			// arms
			if (arms == GorillaTex.RIGHT_ARM) {
				setPixel32(24, 0, 0xFFFFFFFF);
				setPixel32(22, 0, 0xFFFFFFFF);
				setPixel32(20, 0, 0xFFFFFFFF);
				fillRect(new Rectangle(21, 1, 3, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 2, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(24, 3, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(25, 4, 2, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(24, 6, 2, 1), 0xFFFFFFFF);
				setPixel32(24, 7, 0xFFFFFFFF);
				setPixel32(23, 8, 0xFFFFFFFF);
				setPixel32(22, 9, 0xFFFFFFFF);
				setPixel32(21, 10, 0xFFFFFFFF);
				fillRect(new Rectangle(19, 11, 2, 1), 0xFFFFFFFF);
			}
			
			if(arms == GorillaTex.RIGHT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(7, 9, 2, 1), 0xFFFFFFFF);
				setPixel32(6, 10, 0xFFFFFFFF);
				setPixel32(5, 11, 0xFFFFFFFF);
				setPixel32(4, 12, 0xFFFFFFFF);
				setPixel32(3, 13, 0xFFFFFFFF);
				fillRect(new Rectangle(2, 14, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 15, 2, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 17, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(3, 18, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(4, 19, 3, 1), 0xFFFFFFFF);
				setPixel32(3, 20, 0xFFFFFFFF);
				setPixel32(5, 20, 0xFFFFFFFF);
				setPixel32(7, 20, 0xFFFFFFFF);
			}
			
			if (arms == GorillaTex.LEFT_ARM) {
				setPixel32(7, 0, 0xFFFFFFFF);
				setPixel32(5, 0, 0xFFFFFFFF);
				setPixel32(3, 0, 0xFFFFFFFF);
				fillRect(new Rectangle(4, 1, 3, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(3, 2, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 3, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(1, 4, 2, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(2, 6, 2, 1), 0xFFFFFFFF);
				setPixel32(3, 7, 0xFFFFFFFF);
				setPixel32(4, 8, 0xFFFFFFFF);
				setPixel32(5, 9, 0xFFFFFFFF);
				setPixel32(6, 10, 0xFFFFFFFF);
				fillRect(new Rectangle(7, 11, 2, 1), 0xFFFFFFFF);
			}
			
			if(arms == GorillaTex.LEFT_ARM || arms == GorillaTex.ARMS_DOWN){
				fillRect(new Rectangle(19, 9, 2, 1), 0xFFFFFFFF);
				setPixel32(21, 10, 0xFFFFFFFF);
				setPixel32(22, 11, 0xFFFFFFFF);
				setPixel32(23, 12, 0xFFFFFFFF);
				setPixel32(24, 13, 0xFFFFFFFF);
				fillRect(new Rectangle(24, 14, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(25, 15, 2, 2), 0xFFFFFFFF);
				fillRect(new Rectangle(24, 17, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(23, 18, 2, 1), 0xFFFFFFFF);
				fillRect(new Rectangle(21, 19, 3, 1), 0xFFFFFFFF);
				setPixel32(20, 20, 0xFFFFFFFF);
				setPixel32(22, 20, 0xFFFFFFFF);
				setPixel32(24, 20, 0xFFFFFFFF);
			}
		}
	}
}