package dee.moly.textures {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * sun texture
	 * @author moly
	 */
	
	public class SunTex extends DrawingBitmap{
		
		public static const HAPPY:int = 0;
		public static const SHOCKED:int = 1;
		
		public function SunTex(mouth:int) {
			
			super(41, 31, true, 0x000000AD);
			
			// body
			circle(20, 15, 12, 0xFFFFFF00);
			floodFill(20, 15, 0xFFFFFF00);
			
			// rays
			line(0, 15, 40, 15, 0xFFFFFF00);
			line(20, 0, 20, 30, 0xFFFFFF00);
			
			line(5, 5, 35, 25, 0xFFFFFF00);
			line(5, 25, 35, 5, 0xFFFFFF00);
			
			line(12, 2, 28, 28, 0xFFFFFF00);
			line(12, 28, 28, 2, 0xFFFFFF00);
			
			line(2, 10, 38, 20, 0xFFFFFF00);
			line(2, 20, 38, 10, 0xFFFFFF00);
			
			// mouth
			if (mouth == HAPPY) {
				circle(20, 15, 8, 0xFF0000AD);
				fillRect(new Rectangle(12, 9, 17, 9), 0xFFFFFF00);
			}else {
				circle(20, 20, 3, 0xFF0000AD);
				setPixel(20, 20, 0xFF0000AD);
			}
			
			// eyes
			line(16, 13, 18, 13, 0xFF0000AD);
			line(22, 13, 24, 13, 0xFF0000AD);
			
			line(17, 12, 17, 14, 0xFF0000AD);
			line(23, 12, 23, 14, 0xFF0000AD);
			
		}
		
	}

}