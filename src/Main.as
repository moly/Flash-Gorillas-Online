package {
	
	import dee.moly.gamestates.GameStateIntro;
	import dee.moly.gamestates.GameState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Main class
	 * @author moly
	 */
	[SWF(width = "640", height = "350", frameRate = "50")]
	public class Main extends Sprite {
		
		// screen width/height
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT:int = 350;
		
		// the game state we are currently at
		private var currentState:GameState;
		
		// a canvas to draw to
		private var canvas:BitmapData;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// entry point
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			canvas = new BitmapData(640, 350, false, 0xFF000000);
			addChild(new Bitmap(canvas));
			
			currentState = new GameStateIntro();
			
			var gameTimer:Timer = new Timer(20);
			gameTimer.addEventListener(TimerEvent.TIMER, update);
			gameTimer.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		// handle input
		private function onKeyDown(e:KeyboardEvent):void {
			currentState.onKeyDown(e);
		}
		
		// update game
		private function update(e:TimerEvent):void {
			
			currentState.update();
			
			draw();
			
			if (currentState.moveToNextState == true)
				currentState = currentState.nextState;
						
			e.updateAfterEvent();
			
		}
		
		// draw game
		private function draw():void {
			
			canvas.lock();
			currentState.draw(canvas);
			canvas.unlock();
			
		}
		
	}
	
}