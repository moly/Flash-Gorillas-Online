package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Plain blue hat
	 * @author moly
	 */
	
	public class BlueHat extends BitmapData{
		
		public function BlueHat() {
			super(12, 12, true, 0x00000000);
			
			fillRect(new Rectangle(4, 4, 6, 1), 0xFF0000F4);
			fillRect(new Rectangle(2, 5, 8, 2), 0xFF0000F4);
			setPixel32(10, 6, 0xFF0000F4);
		}
	}
}