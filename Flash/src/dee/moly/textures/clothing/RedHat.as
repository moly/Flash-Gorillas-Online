package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Plain red hat
	 * @author moly
	 */
	
	public class RedHat extends BitmapData{
		
		public function RedHat() {
			super(12, 12, true, 0x00000000);
			
			fillRect(new Rectangle(4, 4, 6, 1), 0xFFF40000);
			fillRect(new Rectangle(2, 5, 8, 2), 0xFFF40000);
			setPixel32(10, 6, 0xFFF40000);
		}
	}
}