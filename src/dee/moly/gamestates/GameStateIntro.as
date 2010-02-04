package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import dee.moly.textures.ContentManager;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	/**
	 * The title screen. Has the game name, a quick paragraph about the game and a sparkle border.
	 * @author moly
	 */
	public class GameStateIntro extends GameState{
		
		// the texture
		private var sparkle:BitmapData;
		
		// sparkle positions
		private static const SPARKLE_LEFT_X:int = 0;
		private static const SPARKLE_RIGHT_X:int = 632;
		private static const SPARKLE_TOP_Y:int = 2;
		private static const SPARKLE_BOTTOM_Y:int = 345;
		
		// counters for sparkle movement
		private var a:int;
		private var b:int;
		
		// text
		private var title:CharChain = new CharChain("F l a s h    G O R I L L A S", 218, 62);
		private var line1:CharChain = new CharChain("Your mission is to hit your opponent with the exploding", 100, 107, false, 1, 0xA8A8A8);
		private var line2:CharChain = new CharChain("banana by varying the angle and power of your throw, taking", 80, 123, false, 1, 0xA8A8A8);
		private var line3:CharChain = new CharChain("into account wind speed, gravity, and the city skyline.", 100, 139, false, 1, 0xA8A8A8);
		private var line4:CharChain = new CharChain("The wind speed is shown by a directional arrow at the bottom", 80, 155, false, 1, 0xA8A8A8);
		private var line5:CharChain = new CharChain("of the playing field, its length relative to its strength.", 80, 171, false, 1, 0xA8A8A8);
		private var pressToContinue:CharChain = new CharChain("Press any key to continue", 220, 300, false, 1, 0xA8A8A8);
		
		public function GameStateIntro() {
			
			sparkle = ContentManager.sparkleTex;
			
		}
		
		// move the sparkly border
		override public function update():void {
			
			a = a < 32 ? a + 8 : 0;
			b = b < 102 ? b + 25 : 2;
			
		}
		
		// draw the intro screen
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			title.draw(canvas);
			line1.draw(canvas);
			line2.draw(canvas);
			line3.draw(canvas);
			line4.draw(canvas);
			line5.draw(canvas);
			pressToContinue.draw(canvas);
		
			drawVerticalSparkles(canvas);
			drawHorizontalSparkles(canvas);
			
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			nextState = new GameStateMenu();
			moveToNextState = true;
			
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