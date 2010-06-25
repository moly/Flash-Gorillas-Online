package dee.moly.textures {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Infected textures for the banana
	 * @author moly
	 */
	
	public class InfectedBananaTex extends BitmapData{
		
		public function InfectedBananaTex(direction:int) {
			super(7, 7, true, 0x000000AD);
			
			switch(direction) {
				// (
				case BananaTex.LEFT:
					fillRect(new Rectangle(2, 2, 1, 3), 0xFF9FD0A7);
					fillRect(new Rectangle(3, 1, 2, 5), 0xFF9FD0A7);
					fillRect(new Rectangle(4, 0, 2, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(4, 5, 2, 2), 0xFF9FD0A7);
					break;
				// )	
				case BananaTex.RIGHT:
					fillRect(new Rectangle(4, 2, 1, 3), 0xFF9FD0A7);
					fillRect(new Rectangle(2, 1, 2, 5), 0xFF9FD0A7);
					fillRect(new Rectangle(1, 0, 2, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(1, 5, 2, 2), 0xFF9FD0A7);
					break;
				// /-\	
				case BananaTex.UP:
					fillRect(new Rectangle(2, 2, 3, 1), 0xFF9FD0A7);
					fillRect(new Rectangle(1, 3, 5, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(0, 4, 2, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(5, 4, 2, 2), 0xFF9FD0A7);
					break;
				// \_/
				case BananaTex.DOWN:
					fillRect(new Rectangle(0, 1, 2, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(5, 1, 2, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(1, 2, 5, 2), 0xFF9FD0A7);
					fillRect(new Rectangle(2, 4, 3, 1), 0xFF9FD0A7);
					break;
					
			}
			
		}
		
	}

}