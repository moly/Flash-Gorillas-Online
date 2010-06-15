package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import playerio.*;
	
	/**
	 * Displays the 
	 * @author moly
	 */
	
	public class MyStats extends GameState{
		
		// text
		private var stat1:CharChain = new CharChain("Current level: ", 50, 50, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat2:CharChain = new CharChain("Current experience: ", stat1.x, stat1.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat3:CharChain = new CharChain("Experience to next level: ", stat2.x, stat2.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat4:CharChain = new CharChain("Games won: ", stat3.x, stat3.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat5:CharChain = new CharChain("Games lost: ", stat4.x, stat4.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat6:CharChain = new CharChain("Games played: ", stat5.x, stat5.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat7:CharChain = new CharChain("Games quit: ", stat6.x, stat6.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat8:CharChain = new CharChain("Bananas thrown: ", stat7.x, stat7.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var stat9:CharChain = new CharChain("Total time played: ", stat8.x, stat8.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
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
			
			var level:int = object.level || 0;
			var xp:int = object.xp || 0;
			stat1.text = stat1.text.concat(level);
			stat2.text = stat2.text.concat(xp);
			var xpToNext:int = (((level + 1) * 100) + 100) - xp;
			stat3.text = stat3.text.concat(xpToNext);
			stat4.text = stat4.text.concat(object.gamesWon || 0);
			stat5.text = stat5.text.concat(object.gamesLost || 0);
			stat6.text = stat6.text.concat(object.gamesPlayed || 0);
			stat7.text = stat7.text.concat(object.gamesQuit || 0);
			stat8.text = stat8.text.concat(object.bananasThrown || 0);
			var time:int = object.totalTime || 0;
			stat9.text = stat9.text.concat(int(time / 3600) + ":" + int((time % 3600) / 60) + ":" + (time % 60));
			// level
			// experience
			// experience to next level
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27)
				gotoState(new Menu(client, kongregate));
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			stat1.draw(canvas);
			stat2.draw(canvas);
			stat3.draw(canvas);
			stat4.draw(canvas);
			stat5.draw(canvas);
			stat6.draw(canvas);
		}
	}
}