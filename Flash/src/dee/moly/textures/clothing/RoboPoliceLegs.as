package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Robotic legs
	 * @author moly
	 */
	
	public class RoboPoliceLegs extends BitmapData{
		
		public function RoboPoliceLegs() {
			super(28, 10, true, 0x00000000);
			
			fillRect(new Rectangle(8, 0, 12, 1), 0xFF000000);
			fillRect(new Rectangle(7, 1, 3, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(10, 1, 7, 1), 0xFF000000);
			fillRect(new Rectangle(17, 1, 3, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(5, 2, 6, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(5, 3, 5, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(4, 4, 5, 5), 0xFF7F7F7F);
			fillRect(new Rectangle(4, 8, 5, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(5, 9, 5, 1), 0xFF7F7F7F);
			
			fillRect(new Rectangle(16, 2, 6, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(17, 3, 5, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(18, 4, 5, 5), 0xFF7F7F7F);
			fillRect(new Rectangle(18, 8, 5, 1), 0xFF7F7F7F);
			fillRect(new Rectangle(17, 9, 5, 1), 0xFF7F7F7F);
		}
	}
}