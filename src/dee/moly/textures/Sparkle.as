package dee.moly.textures {
	
	import flash.display.BitmapData;
	
	/**
	 * A red sparkle
	 * @author moly
	 */
	
	public class Sparkle extends BitmapData{
		
		public function Sparkle() {
			
			super(8, 5, false, 0xFF000000);
			
			var x:int, y:int = 0;
			
			for (; x < 8; x++)
				setPixel(x, 2, 0xA80000);
				
			for (x = 1 ; x < 7; x++){
				setPixel(x, y, 0xA80000);
				setPixel(x + 1, y, 0xA80000);
				setPixel(7 - x, y, 0xA80000);
				setPixel(6 - x, y++, 0xA80000);
			}
			
		}
	
	}

}