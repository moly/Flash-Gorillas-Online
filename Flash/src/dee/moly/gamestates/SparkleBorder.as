package dee.moly.gamestates {
	
	import flash.display.BitmapData;
	import dee.moly.textures.SparkleTex;
	import flash.geom.Point;
	
	/**
	 * two different states have the same sparkley border,
	 * so make one class they can both inherit from
	 * @author moly
	 */
	
	public class SparkleBorder extends GameState {
		
		// sparkle texture
		private static const sparkle:BitmapData = new SparkleTex();
		
		// sparkle positions
		private static const SPARKLE_LEFT_X:int = 0;
		private static const SPARKLE_RIGHT_X:int = 632;
		private static const SPARKLE_TOP_Y:int = 2;
		private static const SPARKLE_BOTTOM_Y:int = 345;
		
		// counters for sparkle movement
		private var a:int;
		private var b:int;
		
		public function SparkleBorder() {
			
		}
		
		// move the sparkly border
		override public function update(elapsed:Number):void {
			
			a = a < 32 ? a + 8 : 0;
			b = b < 102 ? b + 25 : 2;
			
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
		
			drawVerticalSparkles(canvas);
			drawHorizontalSparkles(canvas);
			
		}
		
		// draw sparkles going up and down the sides of the screen
		private function drawVerticalSparkles(canvas:BitmapData):void {
			
			for (var i:int = 0; i < 18; i++){
				canvas.copyPixels(sparkle, sparkle.rect, new Point((i+1) * 40 - a, SPARKLE_TOP_Y));
				canvas.copyPixels(sparkle, sparkle.rect, new Point(i * 40 + a, SPARKLE_BOTTOM_Y));
			}
			
		}
		
		// draw sparkles going left and right across the top and bottom of the screen
		private function drawHorizontalSparkles(canvas:BitmapData):void {
			
			for (var i:int = 0; i < 3; i++) {
				canvas.copyPixels(sparkle, sparkle.rect, new Point(SPARKLE_LEFT_X, i * 105 + b));
				canvas.copyPixels(sparkle, sparkle.rect, new Point(SPARKLE_RIGHT_X, (i+1) * 105 - b));
			}
			
		}
		
	}

}