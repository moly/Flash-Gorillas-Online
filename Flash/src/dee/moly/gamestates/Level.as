package dee.moly.gamestates {
	
	import dee.moly.gameobjects.Banana;
	import dee.moly.gameobjects.CharChain;
	import dee.moly.gameobjects.CityScape;
	import dee.moly.gameobjects.Gorilla;
	import dee.moly.AI.ProjectileEstimator;
	import dee.moly.textures.DrawingBitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import dee.moly.gameobjects.Sun;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import playerio.*;
	
	/**
	 * the main level with the gorillas and the buildings and such
	 * @author moly
	 */
	
	public class Level extends GameState{
		
		// the cityscape in the background
		private var cityScape:CityScape;
		
		// two gorillas
		private var gorilla1:Gorilla;
		private var gorilla2:Gorilla;
		
		// names
		private var player1NameText:CharChain;
		private var player2NameText:CharChain;
		
		// score
		private var player1Score:int;
		private var player2Score:int;
		private var scoreText:CharChain;
		
		// angle/velocity prompts
		private var angleText:CharChain;
		private var angleInput:CharChain;
		private var velocityText:CharChain;
		private var velocityInput:CharChain;
		private var angle:Number;
		private var velocity:Point;
		
		// the input to add to
		private var currentInput:CharChain;
		
		// which players turn it is
		private var playerTurn:int;
		
		// the projectile
		private var banana:Banana;
		
		// a smiley sun
		private var sun:Sun;

		// current state
		private var state:int;
		
		// state constants
		private static const ANGLE_INPUT:int = 5;
		private static const VELOCITY_INPUT:int = 6;
		private static const BANANA_THROWN:int = 0;
		private static const GORILLA1_HIT:int = 1;
		private static const GORILLA2_HIT:int = 2;
		private static const BUILDING_HIT:int = 3;
		
		// other constants
		private static const GRAVITY:Number = 9.8;
		private static const PLAY_TO_POINTS:int = 3;
		
		// which gorilla are we
		private var playerNumber:int;
		
		// multiplayer connection
		private var connection:Connection;
		
		public function Level(connection:Connection, buildingCoordinates:ByteArray, windSpeed:int, player1X:int, player1Y:int, player2X:int, player2Y:int, playerNumber:int, myName:String, opponentName:String) {
			
			this.connection = connection;
			this.playerNumber = playerNumber;
			
			connection.addMessageHandler("throw", onReceivedThrow);
			
			gorilla1 = new Gorilla();
			gorilla2 = new Gorilla();
			
			player1NameText = new CharChain(playerNumber == 1 ? myName : opponentName, 0, 3);
			player2NameText = new CharChain(playerNumber == 2 ? myName : opponentName, Main.SCREEN_WIDTH - ((playerNumber == 2 ? myName : opponentName).length * 8) - 8, 3);
			
			player1Score = 0;
			player2Score = 0;
			
			scoreText = new CharChain("0>Score<0", 0, Main.SCREEN_HEIGHT - 38);
			scoreText.centre();
			
			angleText = new CharChain("Angle:", 0, 18);
			angleInput = new CharChain("", 0, 18, CharChain.SOLID, CharChain.NUMERIC);
			
			velocityText = new CharChain("Velocity:", 0, 33);
			velocityInput = new CharChain("", 0, 33, CharChain.SOLID, CharChain.NUMERIC);
			
			sun = new Sun();
			
			banana = new Banana();
			
			cityScape = new CityScape();
			
			playerTurn = 1;
			
			newGame(buildingCoordinates, windSpeed, player1X, player1Y, player2X, player2Y);
			
		}
		
		// reset everything, build a new skyline etc
		private function newGame(buildingCoordinates:ByteArray, windSpeed:int, player1X:int, player1Y:int, player2X:int, player2Y:int):void {
			
			cityScape.buildSkyline(buildingCoordinates, windSpeed);
			
			gorilla1.x = player1X;
			gorilla1.y = player1Y;
			
			gorilla2.x = player2X;
			gorilla2.y = player2Y;
			
			angleInput.text = "";
			angleInput.showCursor();
			velocityInput.text = "";
			currentInput = angleInput;
			currentInput.x = (520 * (playerTurn - 1)) + 58;
			angleText.x = 520 * (playerTurn - 1);
			velocityText.x = 520 * (playerTurn - 1);
			
			scoreText.text = player1Score + ">Score<" + player2Score;
			
			sun.reset();
			
			state = ANGLE_INPUT;
			
		}
		
		// move the banana around
		override public function update(elapsed:Number):void {
			
			switch(state) {
				
				// if the banana is in the air
				case BANANA_THROWN:
				
					banana.update(elapsed);
			
					if (banana.hasCollidedWith(sun))
						sun.shock();
				
					if (banana.hasCollidedWith(cityScape)) {
						cityScape.createSmallExplosion(banana.x, banana.y);
						state = BUILDING_HIT;
					}
				
					if (banana.hasCollidedWith(gorilla1)) {
						cityScape.createBigExplosion(gorilla1.x, gorilla1.y);
						player2Score++;
						state = GORILLA1_HIT;
					}
				
					if (banana.hasCollidedWith(gorilla2)) {
						cityScape.createBigExplosion(gorilla2.x, gorilla2.y);
						player1Score++;
						state = GORILLA2_HIT;
					}
					
					// check if banana has left the screen
					if (banana.x > Main.SCREEN_WIDTH || banana.x < 0 || banana.y > Main.SCREEN_HEIGHT){
						state = BUILDING_HIT;
						nextStep();
					}
					
					break;
					
				case BUILDING_HIT:
				
					cityScape.update(elapsed);
					
					if (cityScape.explosionFinished)
						nextStep();
						
					break;
					
				case GORILLA1_HIT:
					
					if (cityScape.explosionFinished){
						gorilla2.danceAnimation();
						if (gorilla2.finishedDancing)
							nextStep();
					}
						
					break;
					
				case GORILLA2_HIT:
				
					if (cityScape.explosionFinished){
						gorilla1.danceAnimation();
						if (gorilla1.finishedDancing)
							nextStep();
					}
					
					break;
					
			}
					
		}
		
		// draw everything to the screen
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF0000AD);
			
			player1NameText.draw(canvas);
			player2NameText.draw(canvas);
			
			gorilla1.draw(canvas);
			gorilla2.draw(canvas);
			
			cityScape.draw(canvas);
			
			canvas.fillRect(new Rectangle(scoreText.x - 3, scoreText.y - 2, (scoreText.length * 8) + 5, 14), 0xFF0000AD);
			scoreText.draw(canvas);
			
			if (state == ANGLE_INPUT || state == VELOCITY_INPUT) {
				
				angleText.draw(canvas);
				angleInput.draw(canvas);
				
				if (state == VELOCITY_INPUT) {
					velocityText.draw(canvas);
					velocityInput.draw(canvas);
				}
				
			} 
			
			if (state == BANANA_THROWN){
				banana.draw(canvas);
			}
			
			sun.draw(canvas);
			
		}
		
		// put the input into the right places
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (state == BANANA_THROWN || playerTurn != playerNumber)
				return;
			
			currentInput.addChar(e.charCode);
			
			if (e.keyCode == Keyboard.ENTER && currentInput.text != "")
				nextStep();
				
			if (e.keyCode == Keyboard.BACKSPACE)
				currentInput.backspace();
			
		}
		
		// move on to the next step of the level
		private function nextStep():void {
			
			switch (state) {
				
				// if an angle has just been entered, change the active input to velocity
				case ANGLE_INPUT:
					angleInput.removeCursor();
					currentInput = velocityInput;
					currentInput.x = (520 * (playerTurn - 1)) + 82;
					state = VELOCITY_INPUT;
					break;
			
				// if a velocity has just been entered, throw the banana
				case VELOCITY_INPUT:
				
					var angle:int = int(angleInput.text);
					var velocity:int = int(velocityInput.text);
				
					if (playerTurn == 2)
						angle = 180 - angle;
				
					connection.send("throw", angle, velocity);
					throwBanana(angle, velocity);
					
					break;
			
				case GORILLA1_HIT:					
				case GORILLA2_HIT:
					playerTurn = 3 - playerTurn;
					if (player1Score + player2Score >= PLAY_TO_POINTS)
						gotoState(new ScoreOverview(player1NameText.text, player2NameText.text, player1Score, player2Score));
					else{}
						//newGame();
					break;
					
				case BUILDING_HIT:
				
					playerTurn = 3 - playerTurn;
					angleInput.text = "";
					angleInput.showCursor();
					velocityInput.text = "";
					currentInput = angleInput;
					currentInput.x = (520 * (playerTurn - 1)) + 58;
					angleText.x = 520 * (playerTurn - 1);
					velocityText.x = 520 * (playerTurn - 1);
					sun.reset();
					state = ANGLE_INPUT;
					break;
					
			}
						
		}
		
		// throw a banana
		private function throwBanana(angle:int, velocity:int):void {
			
			if (playerTurn == 1){
				var startPoint:Point = new Point(gorilla1.x, gorilla1.y - 7);
				gorilla1.throwAnimation();
			}
				
			if (playerTurn == 2){
				startPoint = new Point(gorilla2.x + 25, gorilla2.y - 7);
				gorilla2.throwAnimation();
			}
			
			banana.launch(angle, velocity, GRAVITY, cityScape.windSpeed, startPoint, 1);
			state = BANANA_THROWN;
		}
		
		// received a shot from the server
		private function onReceivedThrow(message:Message, angle:int, velocity:int):void {
					
			//angleInput.text = String(angle);
			//velocityInput.text = String(velocity);
			//state = VELOCITY_INPUT;
			//nextStep();
			throwBanana(angle, velocity);
			
		}
		
	}

}