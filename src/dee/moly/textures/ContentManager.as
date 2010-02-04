package dee.moly.textures {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.Font;
	
	/**
	 * stores music and images
	 * @author moly
	 */
	
	public class ContentManager{
		
		[Embed(source="/dee/moly/textures/font.png")]
		private static const font:Class;
		public static const fontTex:BitmapData = new font().bitmapData;
		
		public static const sparkleTex:BitmapData = new Sparkle();
		
		public static const gorillaL:BitmapData = new Gorilla(Gorilla.LEFT_ARM);
		public static const gorillaR:BitmapData = new Gorilla(Gorilla.RIGHT_ARM);
		public static const gorillaD:BitmapData = new Gorilla(Gorilla.ARMS_DOWN);
		
		public function ContentManager() {
			throw new Error("Static class, do not instantiate");
		}
		
	}

}