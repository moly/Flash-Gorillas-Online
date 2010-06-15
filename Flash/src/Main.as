package {
	
	import dee.moly.gamestates.TitleScreen;
	import dee.moly.gamestates.GameState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	/**
	 * Main class
	 * @author moly
	 */

	[SWF(width = "640", height = "350", frameRate = "30")]
	public class Main extends Sprite {
		
		// screen width/height
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT:int = 350;
		
		// the game state we are currently at
		private var currentState:GameState;
		
		// a canvas to draw to
		private var canvas:BitmapData;
		
		private var previousTime:Number;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// entry point
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			canvas = new BitmapData(640, 350, false, 0xFF000000);
			addChild(new Bitmap(canvas));
			
			currentState = new TitleScreen(stage);
			
			previousTime = getTimer();
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		// handle input
		private function onKeyDown(e:KeyboardEvent):void {
			currentState.onKeyDown(e);
		}
		
		// update game
		private function update(e:Event):void {
			
			var elapsed:Number = getTimer() - previousTime;
			
			currentState.update(elapsed);
			
			draw();
			
			if (currentState.moveToNextState == true)
				currentState = currentState.nextState;
				
			previousTime = getTimer();
			
		}
		
		// draw game
		private function draw():void {
			
			canvas.lock();
			currentState.draw(canvas);
			canvas.unlock();
			
		}
		
	}
	
}