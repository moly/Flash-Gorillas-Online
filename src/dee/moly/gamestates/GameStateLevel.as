﻿package dee.moly.gamestates {
	
	import dee.moly.gameobjects.Banana;
	import dee.moly.gameobjects.CharChain;
	import dee.moly.gameobjects.CityScape;
	import dee.moly.gameobjects.Gorilla;
	import flash.display.BitmapData;
	import dee.moly.textures.ContentManager;
	import flash.events.KeyboardEvent;
	import dee.moly.gameobjects.Sun;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	/**
	 * the main level with the gorillas and the buildings and such
	 * @author moly
	 */
	
	public class GameStateLevel extends GameState{
		
		// the game setings for this round
		private var gameSettings:GameSettings;
		
		// the cityscape in the background
		private var cityScape:CityScape;
		
		// two gorillas
		private var gorilla1:Gorilla;
		private var gorilla2:Gorilla;
		
		// names
		private var player1NameText:CharChain;
		private var player2NameText:CharChain;
		
		// score
		private var scoreText:CharChain;
		
		// angle/velocity prompts
		private var angleText:CharChain;
		private var angleInput:CharChain;
		private var velocityText:CharChain;
		private var velocityInput:CharChain;
		
		private var currentInput:CharChain;
		
		private var playerTurn:int;
		
		private var banana:Banana;
		
		// a smiley sun
		private var sun:Sun;
		
		public function GameStateLevel(gameSettings:GameSettings) {
			
			this.gameSettings = gameSettings;
			
			gorilla1 = new Gorilla();
			gorilla2 = new Gorilla();
			
			player1NameText = new CharChain(gameSettings.player1Name, 0, 3);
			player2NameText = new CharChain(gameSettings.player2Name, Main.SCREEN_WIDTH - (gameSettings.player2Name.length * 8) - 8, 3);
			
			scoreText = new CharChain("0>Score<0", 0, Main.SCREEN_HEIGHT - 38);
			scoreText.centre();
			
			angleText = new CharChain("Angle:", 0, 18);
			angleInput = new CharChain("", 0, 18, CharChain.SOLID, CharChain.NUMERIC);
			
			velocityText = new CharChain("Velocity:", 0, 33);
			velocityInput = new CharChain("", 0, 33, CharChain.SOLID, CharChain.NUMERIC);
			
			sun = new Sun();
			
			banana = new Banana();
			banana.x = 300;
			banana.y = 150;
			
			cityScape = new CityScape();
			
			playerTurn = 0;
			
			newGame();
			
		}
		
		// reset everything, build a new skyline etc
		private function newGame():void {
			
			sun.reset();
			placeGorillas(cityScape.buildSkyline());
			angleText.x = playerTurn * 520;
			currentInput = angleInput;
			currentInput.x = (playerTurn * 520) + 50; 
			
		}
		
		// put the gorillas on either the second or third building from either end
		private function placeGorillas(buildingCoords:Array):void {

			const xAdj:int = 15;
			const yAdj:int = 29;

			for (var i:int = 1; i <= 2; i++){

				if (i == 1)
					var bNum:int = int(Math.random() * 2) + 1;
				else
					bNum = buildingCoords.length - 1 - (int(Math.random() * 2) + 1);
					
				var bWidth:int = buildingCoords[bNum + 1][0] - buildingCoords[bNum][0];
				
				if (i == 1){
					gorilla1.x = buildingCoords[bNum][0] + bWidth / 2 - xAdj;
					gorilla1.y = buildingCoords[bNum][1] - yAdj;
				}else{
					gorilla2.x = buildingCoords[bNum][0] + bWidth / 2 - xAdj;
					gorilla2.y = buildingCoords[bNum][1] - yAdj;
				}

			}
			
		}
		
		// plot the banana's path
		
		// draw everything to the screen
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF0000AD);
			cityScape.draw(canvas);
			player1NameText.draw(canvas);
			player2NameText.draw(canvas);
			canvas.fillRect(new Rectangle(scoreText.x - 3, scoreText.y - 2, (scoreText.length * 8) + 5, 14), 0xFF0000AD);
			scoreText.draw(canvas);
			gorilla1.draw(canvas);
			gorilla2.draw(canvas);
			angleText.draw(canvas);
			angleInput.draw(canvas);
			if(currentInput == velocityInput){
				velocityText.draw(canvas);
				velocityInput.draw(canvas);
			}
			sun.draw(canvas);
			
		}
		
		// put the input into the right places
		override public function onKeyDown(e:KeyboardEvent):void {
			
			currentInput.addChar(e.charCode);
			
			if (e.keyCode == Keyboard.ENTER)
				nextStep();
				
			if (e.keyCode == Keyboard.BACKSPACE)
				currentInput.backspace();
			
		}
		
		// move on to the next step in the level
		private function nextStep():void {
			
			if (currentInput == angleInput) {
				angleInput.removeCursor();
				currentInput = velocityInput;
				var disp:int = 74;
			}
			
			else if (currentInput == velocityInput) {
				//plo
				currentInput = angleInput;
				disp = 50;
				playerTurn = 1 - playerTurn;
				angleInput.text = "";
				velocityInput.text = "";
			}
			
			angleText.x = 520 * playerTurn;
			velocityText.x = 520 * playerTurn;
			currentInput.x = (520 * playerTurn) + disp;
						
		}
		
	}

}