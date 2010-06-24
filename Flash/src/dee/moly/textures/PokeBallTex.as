package dee.moly.textures {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Alternative banana texture
	 * @author moly
	 */
	
	public class PokeBallTex extends BitmapData{
		
		public function PokeBallTex(direction:int) {
			super(7, 7, true, 0x000000AD);
			
			switch(direction) {
				case BananaTex.LEFT:
					fillRect(new Rectangle(1, 2, 1, 3), 0xFFF40000);
					fillRect(new Rectangle(2, 1, 1, 5), 0xFFF40000);
					fillRect(new Rectangle(3, 1, 1, 5), 0xFF000000);
					fillRect(new Rectangle(4, 1, 1, 5), 0xFFFFFFFF);
					fillRect(new Rectangle(5, 2, 1, 3), 0xFFFFFFFF);
					setPixel32(3, 3, 0xFFFFFFFF);
					break;
					
				case BananaTex.RIGHT:
					fillRect(new Rectangle(1, 2, 1, 3), 0xFFFFFFFF);
					fillRect(new Rectangle(2, 1, 1, 5), 0xFFFFFFFF);
					fillRect(new Rectangle(3, 1, 1, 5), 0xFF000000);
					fillRect(new Rectangle(4, 1, 1, 5), 0xFFF40000);
					fillRect(new Rectangle(5, 2, 1, 3), 0xFFF40000);
					setPixel32(3, 3, 0xFFFFFFFF);
					break;
					
				case BananaTex.UP:
					fillRect(new Rectangle(2, 1, 3, 1), 0xFFF40000);
					fillRect(new Rectangle(1, 2, 5, 1), 0xFFF40000);
					fillRect(new Rectangle(1, 3, 5, 1), 0xFF000000);
					fillRect(new Rectangle(1, 4, 5, 1), 0xFFFFFFFF);
					fillRect(new Rectangle(2, 5, 3, 1), 0xFFFFFFFF);
					setPixel32(3, 3, 0xFFFFFFFF);
					break;
					
				case BananaTex.DOWN:
					fillRect(new Rectangle(2, 1, 3, 1), 0xFFFFFFFF);
					fillRect(new Rectangle(1, 2, 5, 1), 0xFFFFFFFF);
					fillRect(new Rectangle(1, 3, 5, 1), 0xFF000000);
					fillRect(new Rectangle(1, 4, 5, 1), 0xFFF40000);
					fillRect(new Rectangle(2, 5, 3, 1), 0xFFF40000);
					setPixel32(3, 3, 0xFFFFFFFF);
					break;
			}
		}
	}
}