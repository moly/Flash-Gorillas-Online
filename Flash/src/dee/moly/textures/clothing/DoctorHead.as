package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * That shiney thing doctors have on their head
	 * @author moly
	 */
	public class DoctorHead extends BitmapData{
		
		public function DoctorHead() {
			super(12, 10, true, 0x00000000);
			
			fillRect(new Rectangle(2, 6, 8, 1), 0xFF000000);
			fillRect(new Rectangle(6, 4, 2, 1), 0xFFC3C3C3);
			fillRect(new Rectangle(5, 5, 4, 1), 0xFFC3C3C3);
			fillRect(new Rectangle(6, 6, 2, 1), 0xFFC3C3C3);
		}
	}
}