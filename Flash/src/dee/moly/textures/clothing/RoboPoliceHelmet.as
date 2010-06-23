package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * Helmet for a gorilla-robot police officer
	 * @author moly
	 */
	
	public class RoboPoliceHelmet extends BitmapData{
		
		public function RoboPoliceHelmet() {
			super(12, 14, true, 0x00000000);
			
			// draw head
			fillRect(new Rectangle(2, 6, 8, 2), 0xFF7F7F7F);
			fillRect(new Rectangle(1, 8, 10, 2), 0xFF7F7F7F);
			
			// draw eyes/brow
			fillRect(new Rectangle(3, 8, 6, 1), 0xFF000000);
			
			fillRect(new Rectangle(1, 10, 2, 1), 0xFF000000);
			setPixel32(10, 10, 0xFF000000);
			setPixel32(2, 11, 0xFF000000);
			setPixel32(9, 11, 0xFF000000);
			fillRect(new Rectangle(2, 12, 8, 1), 0xFF000000);
			
			// neck
			fillRect(new Rectangle(3, 13, 6, 1), 0xFF000000);
		}
	}
}