package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import playerio.*;
	
	/**
	 * Displays current leaderboards
	 * @author moly
	 */
	
	public class Leaderboards extends GameState{
		
		// text
		private static const title1:CharChain = new CharChain("Highest Level", 50, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var table1:Array = new Array();
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		public function Leaderboards(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			client.bigDB.loadRange("PlayerObjects", "levelsDescending", [], null, null, 10, onReceivedLevels, onReceivedError);
		}
		
		// successfully received top levels
		private function onReceivedLevels(array:Array):void {
			
			for (var i:int = 0; i < array.length; ++i)
				table1.push(new CharChain(i + ". " + array[i].name + " - " + array[i].level, 40, 66 + (i * 16), CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8));
		}
		
		// not successfully received data
		private function onReceivedError(error:PlayerIOError):void {
			trace(error);
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			title1.draw(canvas);
			for each(var entry:CharChain in table1)
				entry.draw(canvas);
			
			
		}
	}
}