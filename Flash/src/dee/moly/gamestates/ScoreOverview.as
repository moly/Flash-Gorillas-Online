package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import playerio.Client;
	import playerio.DatabaseObject;
	
	/**
	 * Final screen showing the scores from the game
	 * @author moly
	 */
	
	public class ScoreOverview extends SparkleBorder{
		
		// text
		private var gameOver:CharChain = new CharChain("GAME OVER!", 265, 114, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var score:CharChain = new CharChain("Score:", 281, 146, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var player1Name:CharChain = new CharChain("", 232, 162, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var player2Name:CharChain = new CharChain("", 232, 178, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var player1Score:CharChain = new CharChain("", 400, 162, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var player2Score:CharChain = new CharChain("", 400, 178, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var experienceGained:CharChain = new CharChain("", 300, 210, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var pressToContinue:CharChain = new CharChain("Press any key to continue", 220, 300, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api refernce
		private var kongregate:*;
		
		// experience gained
		private var experienceGain:int;
		
		// is the game private
		private var isPrivate:Boolean;
		
		public function ScoreOverview(client:Client, kongregate:*, isPrivate:Boolean, playerNumber:int, player1Name:String, player2Name:String, player1Score:int, player2Score:int) {
			
			this.client = client;
			this.kongregate = kongregate;
			this.player1Name.text = player1Name;
			this.player2Name.text = player2Name;
			this.player1Score.text = String(player1Score);
			this.player2Score.text = String(player2Score);
			this.isPrivate = isPrivate;
			
			// calculate experience gained
			experienceGain = 0;
			if (playerNumber == 1){
				if (player1Score > player2Score)
					experienceGain += 100;
				experienceGain += (player1Score * 15);
			}else {
				if (player2Score > player1Score)
					experienceGain += 100;
				experienceGain += (player2Score * 15);
			}
			
			client.bigDB.loadMyPlayerObject(onReceivedData);
		}
		
		override public function draw(canvas:BitmapData):void {
			
			super.draw(canvas);
			
			gameOver.draw(canvas);
			score.draw(canvas);
			player1Name.draw(canvas);
			player2Name.draw(canvas);
			player1Score.draw(canvas);
			player2Score.draw(canvas);
			
			if(!isPrivate)
				experienceGained.draw(canvas);
				
			pressToContinue.draw(canvas);
		}
	
		override public function onKeyDown(e:KeyboardEvent):void {
			
			gotoState(new Menu(client, kongregate));
		}
		
		// calculate how much experience was gained
		private function onReceivedData(object:DatabaseObject):void {
			
			var level:int = object.level || 0;
			var xp:int = object.xp || 0;
			while (true) {
				if (experienceGain + xp >= 100 + (level * 100))
                        level++;
                    else
                break;
			}
			experienceGained.text = "Experience gained: " + experienceGain + "   Current Level: " + level + (level > (object.level || 0) ? "^" : "");
			experienceGained.centre();
		}
	}

}