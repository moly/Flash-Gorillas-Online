package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A gentleman's top hat
	 * @author moly
	 */
	
	public class TopHat extends BitmapData{
		
		public function TopHat() {
			super(12, 7, true, 0x00000000);
			
			fillRect(new Rectangle(2, 0, 8, 6), 0xFF000000);
			fillRect(new Rectangle(0, 6, 12, 1), 0xFF000000);
		}
	}
}