package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * A bowler hat and a bit of eyeliner
	 * @author moly
	 */
	
	public class ClockworkHat extends BitmapData{
		
		public function ClockworkHat() {
			super(12, 10, true, 0x00000000);
			
			fillRect(new Rectangle(3, 2, 6, 4), 0xFF000000);
			fillRect(new Rectangle(2, 3, 8, 3), 0xFF000000);
			fillRect(new Rectangle(0, 6, 12, 1), 0xFF000000);
			
			setPixel32(2, 8, 0xFF000000);
			setPixel32(2, 9, 0xFF000000);
			setPixel32(3, 9, 0xFF000000);
		}
	}
}