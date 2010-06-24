package dee.moly.textures {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Textures for the banana
	 * @author moly
	 */
	
	public class BananaTex extends BitmapData{
		
		public static const LEFT:int = 0;
		public static const RIGHT:int = 1;
		public static const UP:int = 2;
		public static const DOWN:int = 3;
		
		public function BananaTex(direction:int) {
			super(7, 7, true, 0x000000AD);
			
			switch(direction) {
				// (
				case LEFT:
					fillRect(new Rectangle(2, 2, 1, 3), 0xFFFFFE51);
					fillRect(new Rectangle(3, 1, 2, 5), 0xFFFFFE51);
					fillRect(new Rectangle(4, 0, 2, 2), 0xFFFFFE51);
					fillRect(new Rectangle(4, 5, 2, 2), 0xFFFFFE51);
					break;
				// )	
				case RIGHT:
					fillRect(new Rectangle(4, 2, 1, 3), 0xFFFFFE51);
					fillRect(new Rectangle(2, 1, 2, 5), 0xFFFFFE51);
					fillRect(new Rectangle(1, 0, 2, 2), 0xFFFFFE51);
					fillRect(new Rectangle(1, 5, 2, 2), 0xFFFFFE51);
					break;
				// /-\	
				case UP:
					fillRect(new Rectangle(2, 2, 3, 1), 0xFFFFFE51);
					fillRect(new Rectangle(1, 3, 5, 2), 0xFFFFFE51);
					fillRect(new Rectangle(0, 4, 2, 2), 0xFFFFFE51);
					fillRect(new Rectangle(5, 4, 2, 2), 0xFFFFFE51);
					break;
				// \_/
				case DOWN:
					fillRect(new Rectangle(0, 1, 2, 2), 0xFFFFFE51);
					fillRect(new Rectangle(5, 1, 2, 2), 0xFFFFFE51);
					fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFFE51);
					fillRect(new Rectangle(2, 4, 3, 1), 0xFFFFFE51);
					break;
					
			}
			
		}
		
	}

}