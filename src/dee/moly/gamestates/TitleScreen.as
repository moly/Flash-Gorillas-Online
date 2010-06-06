package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	
	/**
	 * The title screen. Has the game name, a quick paragraph about the
	 * game and a sparkle border.
	 * @author moly
	 */
	
	public class TitleScreen extends SparkleBorder {
		
		[Embed(source="/dee/moly/sounds/intro.mp3")] private static const IntroMusic:Class;
		private static const introMusic:Sound = new IntroMusic();
		
		// text
		private var title:CharChain = new CharChain("F l a s h    G O R I L L A S", 218, 62);
		private var line1:CharChain = new CharChain("Your mission is to hit your opponent with the exploding", 100, 107, CharChain.NONE, 1, 0xA8A8A8);
		private var line2:CharChain = new CharChain("banana by varying the angle and power of your throw, taking", 80, 123, CharChain.NONE, 1, 0xA8A8A8);
		private var line3:CharChain = new CharChain("into account wind speed, gravity, and the city skyline.", 100, 139, CharChain.NONE, 1, 0xA8A8A8);
		private var line4:CharChain = new CharChain("The wind speed is shown by a directional arrow at the bottom", 80, 155, CharChain.NONE, 1, 0xA8A8A8);
		private var line5:CharChain = new CharChain("of the playing field, its length relative to its strength.", 80, 171, CharChain.NONE, 1, 0xA8A8A8);
		private var pressToContinue:CharChain = new CharChain("Press any key to continue", 220, 300, CharChain.NONE, 1, 0xA8A8A8);
		
		public function TitleScreen() {
			introMusic.play();
		}
		
		// draw the intro screen
		override public function draw(canvas:BitmapData):void {
			
			super.draw(canvas);
			
			title.draw(canvas);
			line1.draw(canvas);
			line2.draw(canvas);
			line3.draw(canvas);
			line4.draw(canvas);
			line5.draw(canvas);
			pressToContinue.draw(canvas);
			
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			gotoState(new Menu());
			
		}
		
	}

}