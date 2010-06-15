package dee.moly.gamestates {
	
	import flash.display.BitmapData;
	import playerio.*;
	
	/**
	 * Displays the 
	 * @author moly
	 */
	
	public class MyStats extends GameState{
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		public function MyStats(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			client.bigDB.loadMyPlayerObject(onReceivedData);
		}
		
		// received player data
		private function onReceivedData(object:DatabaseObject):void {
			
			//bananas thrown
			//wins
			//loses
			//games
			//quits
			//time played
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000)
		}
	}
}