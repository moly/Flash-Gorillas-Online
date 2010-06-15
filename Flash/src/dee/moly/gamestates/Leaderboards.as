package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import playerio.*;
	
	/**
	 * Displays current leaderboards
	 * @author moly
	 */
	
	public class Leaderboards extends GameState{
		
		// text
		private static const title1:CharChain = new CharChain("Highest Level", 50, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var table1:Array = new Array();
		private static const title2:CharChain = new CharChain("Most Games Won", 200, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var table2:Array = new Array();
		private static const title3:CharChain = new CharChain("Most Games Lost", 350, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var table3:Array = new Array();
		private static const title4:CharChain = new CharChain("Most Games Quit", 500, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var table4:Array = new Array();
		private static const pressToGoBack:CharChain = new CharChain("Press x to go back", 250, 320, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		public function Leaderboards(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			client.bigDB.loadRange("PlayerObjects", "levelsDescending", [], null, null, 10, onReceivedLevels, onReceivedError);
			client.bigDB.loadRange("PlayerObjects", "gamesWonDescending", [], null, null, 10, onReceivedWins, onReceivedError);
			client.bigDB.loadRange("PlayerObjects", "gamesLostDescending", [], null, null, 10, onReceivedLoses, onReceivedError);
			client.bigDB.loadRange("PlayerObjects", "gamesQuitDescending", [], null, null, 10, onReceivedQuits, onReceivedError);
		}
		
		// successfully received top levels
		private function onReceivedLevels(array:Array):void {
			
			for (var i:int = 0; i < array.length; ++i)
				table1.push(new CharChain((i+1) + ". " + array[i].name + " - " + array[i].level, 40, 66 + (i * 16), CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8));
		}
		
		// successfully received top wins
		private function onReceivedWins(array:Array):void {
			
			for (var i:int = 0; i < array.length; ++i)
				table2.push(new CharChain((i+1) + ". " + array[i].name + " - " + array[i].gamesWon, 190, 66 + (i * 16), CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8));
		}
		
		// successfully received top loses
		private function onReceivedLoses(array:Array):void {
			
			for (var i:int = 0; i < array.length; ++i)
				table3.push(new CharChain((i+1) + ". " + array[i].name + " - " + array[i].gamesLost, 340, 66 + (i * 16), CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8));
		}
		
		// successfully received top quits
		private function onReceivedQuits(array:Array):void {
			
			for (var i:int = 0; i < array.length; ++i)
				table4.push(new CharChain((i+1) + ". " + array[i].name + " - " + array[i].gamesQuit, 490, 66 + (i * 16), CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8));
		}
		
		// not successfully received data
		private function onReceivedError(error:PlayerIOError):void {
			trace(error);
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27)
				gotoState(new Menu(client, kongregate));
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			var entry:CharChain;
			
			title1.draw(canvas);
			for each(entry in table1)
				entry.draw(canvas);
			
			title2.draw(canvas);
			for each(entry in table2)
				entry.draw(canvas);
				
			title3.draw(canvas);
			for each(entry in table3)
				entry.draw(canvas);
				
			title4.draw(canvas);
			for each(entry in table4)
				entry.draw(canvas);
			
			pressToGoBack.draw(canvas);
		}
	}
}