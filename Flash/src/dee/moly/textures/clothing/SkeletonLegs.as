package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Boney legs
	 * @author moly
	 */
	
	public class SkeletonLegs extends BitmapData{
		
		public function SkeletonLegs() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(7, 1, 13, 1), 0xFF0000AD);
			fillRect(new Rectangle(5, 2, 6, 1), 0xFF0000AD);
			fillRect(new Rectangle(5, 3, 5, 1), 0xFF0000AD);
			fillRect(new Rectangle(4, 4, 5, 5), 0xFF0000AD);
			fillRect(new Rectangle(5, 9, 5, 1), 0xFF0000AD); 
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF0000AD);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF0000AD);
			fillRect(new Rectangle(18, 4, 5, 5), 0xFF0000AD);
			fillRect(new Rectangle(17, 9, 5, 1), 0xFF0000AD);
			
			fillRect(new Rectangle(8, 1, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(7, 2, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 3, 2, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(5, 5, 2, 2), 0xFFFFFFFF);
			setPixel32(6, 7, 0xFFFFFFFF);
			fillRect(new Rectangle(6, 8, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(6, 9, 3, 1), 0xFFFFFFFF);
			
			fillRect(new Rectangle(17, 1, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(18, 2, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(19, 3, 2, 2), 0xFFFFFFFF);
			fillRect(new Rectangle(20, 5, 2, 2), 0xFFFFFFFF);
			setPixel32(20, 7, 0xFFFFFFFF);
			fillRect(new Rectangle(19, 8, 2, 1), 0xFFFFFFFF);
			fillRect(new Rectangle(18, 9, 3, 1), 0xFFFFFFFF);
		}
	}
}