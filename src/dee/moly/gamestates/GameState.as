package dee.moly.gamestates{
	
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	
	/**
	 * All game state classes should inherit from this
	 * @author moly
	 */
	public class GameState{
		
		private var _moveToNextState:Boolean;
		public function get moveToNextState():Boolean {
			return _moveToNextState;
		}
		
		private var _nextState:GameState;
		public function get nextState():GameState {
			return _nextState;
		}
		
		public function GameState() {
			
		}
		
		public function onKeyDown(e:KeyboardEvent):void {
			
		}
		
		public function update(elapsed:Number):void {
			
		}
		
		public function draw(canvas:BitmapData):void {
			
		}
		
		protected function gotoState(state:GameState):void {
			_moveToNextState = true;
			_nextState = state;
		}
		
	}

}