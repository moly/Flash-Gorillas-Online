package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	
	/**
	 * A menu to decide game options
	 * @author moly
	 */
	
	public class GameStateMenu extends GameState{
		
		// default game settings
		private static const DEFAULT_NUM_PLAYERS:int = 1;
		private static const DEFAULT_PLAYER_1_NAME:String = "Player 1";
		private static const DEFAULT_PLAYER_2_NAME:String = "Player 2";
		private static const DEFAULT_PLAY_TO_POINTS:int = 3;
		private static const DEFAULT_GRAVITY:Number = 9.8;
		
		// the steps through the menu
		private static const STEP_NUMPLAYERS:int = 0;
		private static const STEP_PLAYER1NAME:int = 1;
		private static const STEP_PLAYER2NAME:int = 2;
		private static const STEP_POINTS:int = 3;
		private static const STEP_GRAVITY:int = 4;
		private static const STEP_DONE:int = 5;
		
		//text
		private static const numPlayersText:CharChain = new CharChain("1 or 2 players (Default = 1): ", 170, 51, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const numPlayersInput:CharChain = new CharChain("", 170 + numPlayersText.length * 8, 51, true, CharChain.NUMERIC, 0xA8A8A8);
		private static const player1NameText:CharChain = new CharChain("Name of Player 1 (Default = 'Player 1'): ", 121, 80, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const player1NameInput:CharChain = new CharChain("", 121 + player1NameText.length * 8, 80, true, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const player2NameText:CharChain = new CharChain("Name of Player 2 (Default = 'Player 2'): ", 121, 109, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const player2NameInput:CharChain = new CharChain("", 121 + player2NameText.length * 8, 109, true, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const totalPointsText:CharChain = new CharChain("Play to how many total points (Default = 3)? ", 110, 135, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const totalPointsInput:CharChain = new CharChain("", 110 + totalPointsText.length * 8, 135, true, CharChain.NUMERIC, 0xA8A8A8);
		private static const gravityText:CharChain = new CharChain("Gravity in Meters/Sec (Earth = 9.8)? ", 126, 164, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const gravityInput:CharChain = new CharChain("", 126 + gravityText.length * 8, 164, true, CharChain.NUMERIC, 0xA8A8A8);
		private static const lineDash:CharChain = new CharChain("--------------", 265, 210, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const viewIntroText:CharChain = new CharChain("V = View Intro", 265, 246, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const playGameText:CharChain = new CharChain("P = Play Game", 265, 262, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const yourChoiceText:CharChain = new CharChain("Your Choice?", 273, 294, false, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		private var gameSettings:GameSettings;
		private var menuStep:int;
		private var currentInput:CharChain;
		
		public function GameStateMenu() {
			
			gameSettings = new GameSettings();
			menuStep = STEP_NUMPLAYERS;
			currentInput = numPlayersInput;
			
		}
		
		// draw menu options, let it fall through cases to draw all options needed
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			switch(menuStep){
			
				case STEP_DONE:
					lineDash.draw(canvas);
					viewIntroText.draw(canvas);
					playGameText.draw(canvas);
					yourChoiceText.draw(canvas);
				
				case STEP_GRAVITY:
					gravityText.draw(canvas);
					gravityInput.draw(canvas);
				
				case STEP_POINTS:
					totalPointsText.draw(canvas);
					totalPointsInput.draw(canvas);
				
				case STEP_PLAYER2NAME:
					player2NameText.draw(canvas);
					player2NameInput.draw(canvas);
				
				case STEP_PLAYER1NAME:
					player1NameText.draw(canvas);
					player1NameInput.draw(canvas);
				
				case STEP_NUMPLAYERS:
					numPlayersText.draw(canvas);
					numPlayersInput.draw(canvas);
					break;
					
			}
			
		}
		
		// decide valid input and such
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (menuStep == STEP_DONE) {
				if (e.keyCode == 80){
					nextState = new GameStateLevel(gameSettings);
					moveToNextState = true;
				}
				if (e.keyCode == 86) {
					nextState = new GameStateDance(gameSettings);
					moveToNextState = true;
				}
			}
			else if (e.keyCode == 13)
			
				switch(menuStep) {
				
					case STEP_NUMPLAYERS:
					
						if (numPlayersInput.text == "" || int(numPlayersInput.text) == 1 || int(numPlayersInput.text) == 2) {
							gameSettings.numberOfPlayers = numPlayersInput.text == "" ? DEFAULT_NUM_PLAYERS : int(numPlayersInput.text);
							numPlayersInput.removeCursor();
							currentInput = player1NameInput;
							menuStep = STEP_PLAYER1NAME;
						}else {
							numPlayersInput.text = "";
						}
				
						break;
					
					case STEP_PLAYER1NAME:
						
						gameSettings.player1Name = player1NameInput.text == "" ? DEFAULT_PLAYER_1_NAME : player1NameInput.text.substring(0, 10);
						player1NameInput.removeCursor();
						currentInput = player2NameInput;
						menuStep = STEP_PLAYER2NAME;
						break;
						
					case STEP_PLAYER2NAME:
						
						gameSettings.player2Name = player2NameInput.text == "" ? DEFAULT_PLAYER_2_NAME : player2NameInput.text.substring(0, 10);
						player2NameInput.removeCursor();
						currentInput = totalPointsInput;
						menuStep = STEP_POINTS;
						break;
					
					case STEP_POINTS:
					
						if (totalPointsInput.text.length < 3) {
							gameSettings.playToPoints = totalPointsInput.text == "" || int(totalPointsInput.text) == 0 ? DEFAULT_PLAY_TO_POINTS : int(totalPointsInput.text);
							totalPointsInput.removeCursor();
							currentInput = gravityInput;
							menuStep = STEP_GRAVITY;
						}else {
							totalPointsInput.text = "";
						}
						
						break;
						
					case STEP_GRAVITY:
					
						gameSettings.gravity = gravityInput.text == "" || int(gravityInput.text) == 0 ? DEFAULT_GRAVITY : Number(gravityInput.text);
						gravityInput.removeCursor();
						menuStep = STEP_DONE;
						break;
				}
			
			else if (e.keyCode == 8)
				currentInput.backspace();
			else 
				currentInput.addChar(e.charCode);
				
		}
		
	}

}