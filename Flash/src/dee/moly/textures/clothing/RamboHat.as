package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Red head band
	 * @author moly
	 */
	
	public class RamboHat extends BitmapData{
		
		public function RamboHat(){
			super(12, 9, true, 0x00000000);
			
			fillRect(new Rectangle(1, 7, 9, 1), 0xFFF40000);
			setPixel32(0, 6, 0xFFF40000);
			setPixel32(0, 8, 0xFFF40000);
		}
	}
}