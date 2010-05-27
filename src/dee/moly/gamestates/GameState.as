package dee.moly.gamestates{
	
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	
	/**
	 * All game state classes should inherit from this
	 * @author moly
	 */
	public class GameState{
		
		public var moveToNextState:Boolean;
		public var nextState:GameState;
		
		public function GameState() {
			
		}
		
		public function onKeyDown(e:KeyboardEvent):void {
			
		}
		
		public function update(elapsed:Number):void {
			
		}
		
		public function draw(canvas:BitmapData):void {
			
		}
		
	}

}