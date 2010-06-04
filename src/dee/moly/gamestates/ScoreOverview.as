package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	
	/**
	 * final screen showing the scores from the game
	 * @author moly
	 */
	
	public class ScoreOverview extends SparkleBorder{
		
		// text
		private var gameOver:CharChain = new CharChain("GAME OVER!", 265, 114, CharChain.NONE, 1, 0xA8A8A8);
		private var score:CharChain = new CharChain("Score:", 281, 146, CharChain.NONE, 1, 0xA8A8A8);
		private var player1Name:CharChain = new CharChain("", 232, 162, CharChain.NONE, 1, 0xA8A8A8);
		private var player2Name:CharChain = new CharChain("", 232, 178, CharChain.NONE, 1, 0xA8A8A8);
		private var player1Score:CharChain = new CharChain("", 400, 162, CharChain.NONE, 1, 0xA8A8A8);
		private var player2Score:CharChain = new CharChain("", 400, 178, CharChain.NONE, 1, 0xA8A8A8);
		private var pressToContinue:CharChain = new CharChain("Press any key to continue", 220, 300, CharChain.NONE, 1, 0xA8A8A8);
		
		public function ScoreOverview(player1Name:String, player2Name:String, player1Score:int, player2Score:int) {
			this.player1Name.text = player1Name;
			this.player2Name.text = player2Name;
			this.player1Score.text = String(player1Score);
			this.player2Score.text = String(player2Score);
		}
		
		override public function draw(canvas:BitmapData):void 
		{
			super.draw(canvas);
			
			gameOver.draw(canvas);
			score.draw(canvas);
			player1Name.draw(canvas);
			player2Name.draw(canvas);
			player1Score.draw(canvas);
			player2Score.draw(canvas);
			pressToContinue.draw(canvas);
		}
		
	}

}