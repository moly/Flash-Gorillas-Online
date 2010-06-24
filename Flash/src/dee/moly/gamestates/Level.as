package dee.moly.gamestates {
	
	import dee.moly.gameobjects.Banana;
	import dee.moly.gameobjects.CharChain;
	import dee.moly.gameobjects.ChatBubble;
	import dee.moly.gameobjects.Cityscape;
	import dee.moly.gameobjects.Gorilla;
	import dee.moly.AI.ProjectileEstimator;
	import dee.moly.textures.DrawingBitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import dee.moly.gameobjects.Sun;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
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
		private var cityscape:Cityscape;
		
		// two gorillas
		private var gorilla1:Gorilla;
		private var gorilla2:Gorilla;
		
		// names
		private var player1Name:String;
		private var player2Name:String;
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
		
		// chatbox
		private var chatText:CharChain;
		private var chatInput:CharChain;
		
		// is chatbox open
		private var chatOpen:Boolean;
		
		// chat bubbles
		private var player1ChatBubble:ChatBubble;
		private var player2ChatBubble:ChatBubble;
		
		// which players turn it is
		private var playerTurn:int;
		
		// the projectile
		private var banana:Banana;
		
		// a smiley sun
		private var sun:Sun;

		// current state
		private var state:int;
		
		// state constants
		private static const ANGLE_INPUT:int = 0;
		private static const VELOCITY_INPUT:int = 1;
		private static const BANANA_THROWN:int = 2;
		private static const GORILLA1_HIT:int = 3;
		private static const GORILLA2_HIT:int = 4;
		private static const BUILDING_HIT:int = 5;
		private static const DISCONNECTED:int = 6;
		
		// block input if needed
		private var blockInput:Boolean;
		
		// time limit to take a turn
		private static const TURN_TIME_LIMIT:int = 15000;
		private var currentTime:Number;
		
		// other constants
		private static const GRAVITY:Number = 9.8;
		private static const PLAY_TO_POINTS:int = 3; 
		
		// which gorilla are we
		private var playerNumber:int;
		
		// player.io connection
		private var connection:Connection;
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		// error message display
		private var errorMessage:CharChain;
		
		// is the game private
		private var isPrivate:Boolean;
		
		public function Level(connection:Connection, client:Client, kongregate:*, buildingCoordinates:ByteArray, player1Positions:ByteArray, player2Positions:ByteArray, windSpeeds:ByteArray, playerNumber:int, myName:String, opponentName:String, player1Clothes:ByteArray, player2Clothes:ByteArray, player1Level:int, player2Level:int, isPrivate:Boolean) {
			
			this.connection = connection;
			this.client = client;
			this.kongregate = kongregate;
			this.playerNumber = playerNumber;
			this.isPrivate = isPrivate;
			
			// add server message handlers
			connection.addMessageHandler("throw", onReceivedThrow);
			connection.addMessageHandler("timeOut", onTimeOut);
			connection.addMessageHandler("userLeft", onUserLeft);
			connection.addMessageHandler("chat", onReceivedChat);
			connection.addDisconnectHandler(onDisconnected);
			
			gorilla1 = new Gorilla();
			gorilla1.setClothes(player1Clothes.readInt(), player1Clothes.readInt(), player1Clothes.readInt());
			gorilla2 = new Gorilla();
			gorilla2.setClothes(player2Clothes.readInt(), player2Clothes.readInt(), player2Clothes.readInt());
			
			player1Name = playerNumber == 1 ? myName : opponentName;
			player2Name = playerNumber == 2 ? myName : opponentName;
			player1NameText = new CharChain(player1Name + " - Lvl " + player1Level, 0, 3);
			player2NameText = new CharChain("Lvl " + player2Level + " - " + player2Name, Main.SCREEN_WIDTH - ((playerNumber == 2 ? myName : opponentName).length * 8) - (64 + player2Level.toString().length), 3);
			
			player1Score = 0;
			player2Score = 0;
			
			scoreText = new CharChain("0>Score<0", 0, Main.SCREEN_HEIGHT - 38);
			scoreText.centre();
			
			angleText = new CharChain("Angle:", 0, 18);
			angleInput = new CharChain("", 0, 18, CharChain.SOLID, CharChain.NUMERIC);
			
			velocityText = new CharChain("Velocity:", 0, 33);
			velocityInput = new CharChain("", 0, 33, CharChain.SOLID, CharChain.NUMERIC);
			
			chatText = new CharChain("Chat:", 0, Main.SCREEN_HEIGHT - 12);
			chatInput = new CharChain("", chatText.x + (chatText.length * 8) + 8, chatText.y, CharChain.SOLID, CharChain.ALPHANUMERIC, 0xFFFFFF, 28);
			
			player1ChatBubble = new ChatBubble();
			player2ChatBubble = new ChatBubble();
			
			sun = new Sun();
			
			banana = new Banana();
			
			cityscape = new Cityscape(buildingCoordinates, player1Positions, player2Positions, windSpeeds);
			
			playerTurn = 1;
			
			newGame();
			
		}
		
		// reset everything, build a new skyline
		private function newGame():void {
			
			cityscape.nextCityscape();
			
			gorilla1.x = cityscape.player1Position.x;
			gorilla1.y = cityscape.player1Position.y;
			
			gorilla2.x = cityscape.player2Position.x;
			gorilla2.y = cityscape.player2Position.y;
			
			if (playerTurn != playerNumber) {
				angleText.text = "Opponent turn";
				angleInput.removeCursor();
			}else {
				angleText.text = "Angle:";
				angleInput.showCursor();
			}
			
			angleInput.text = "";
			velocityInput.text = "";
			if(!chatOpen)
				currentInput = angleInput;
			angleInput.x = (520 * (playerTurn - 1)) + 58;
			angleText.x = 520 * (playerTurn - 1);
			velocityText.x = 520 * (playerTurn - 1);
			blockInput = false;
			
			scoreText.text = player1Score + ">Score<" + player2Score;
			
			sun.reset();
			
			currentTime = TURN_TIME_LIMIT;
			
			state = ANGLE_INPUT;
			
		}
		
		// update the game
		override public function update(elapsed:Number):void {
			
			if(state != BANANA_THROWN){
				currentTime -= elapsed;
				if (currentTime <= 0) {
					currentTime = TURN_TIME_LIMIT;
				}
			}
			
			switch(state) {
								
				case BANANA_THROWN:
				
					banana.update(elapsed);
			
					if (banana.hasCollidedWith(sun))
						sun.shock();
				
					if (banana.hasCollidedWith(cityscape)) {
						cityscape.createSmallExplosion(banana.x, banana.y);
						state = BUILDING_HIT;
					}
				
					if (banana.hasCollidedWith(gorilla1)) {
						cityscape.createBigExplosion(gorilla1.x, gorilla1.y);
						player2Score++;
						state = GORILLA1_HIT;
					}
				
					if (banana.hasCollidedWith(gorilla2)) {
						cityscape.createBigExplosion(gorilla2.x, gorilla2.y);
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
				
					cityscape.update(elapsed);
					
					if (cityscape.explosionFinished)
						nextStep();
						
					break;
					
				case GORILLA1_HIT:
					
					if (cityscape.explosionFinished){
						gorilla2.danceAnimation();
						if (gorilla2.finishedDancing)
							nextStep();
					}
						
					break;
					
				case GORILLA2_HIT:
				
					if (cityscape.explosionFinished){
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
			//canvas.colorTransform(canvas.rect, new ColorTransform(0.999, 0.999, 0.999));
			player1NameText.draw(canvas);
			player2NameText.draw(canvas);
			
			gorilla1.draw(canvas);
			gorilla2.draw(canvas);
			
			cityscape.draw(canvas);
			
			canvas.fillRect(new Rectangle(scoreText.x - 3, scoreText.y - 2, (scoreText.length * 8) + 5, 14), 0xFF0000AD);
			scoreText.draw(canvas);
			
			//new CharChain(currentTime.toString(), 100, 100).draw(canvas);
			
			// only draw the angle and velocity prompts during the input stages
			if (state == ANGLE_INPUT || state == VELOCITY_INPUT) {
				
				angleText.draw(canvas);
				angleInput.draw(canvas);
				
				if (state == VELOCITY_INPUT) {
					velocityText.draw(canvas);
					velocityInput.draw(canvas);
				}
				
			} 
			
			// only draw the banana when it's moving
			if (state == BANANA_THROWN)
				banana.draw(canvas);
			
			sun.draw(canvas);
			
			player1ChatBubble.draw(canvas);
			player2ChatBubble.draw(canvas);
			
			// if we've been disconnected, draw an error message
			if(state == DISCONNECTED)
				errorMessage.draw(canvas);
			
			if(chatOpen){
				chatText.draw(canvas);
				chatInput.draw(canvas);
			}
		}
		
		// put the input into the right places
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (state == DISCONNECTED) {
				if (connection.connected)
					connection.disconnect();
				gotoState(new Menu(client, kongregate));
			}
			
			// t
			if (e.keyCode == 84 && !chatOpen){
				chatOpen = true;
				currentInput = chatInput;
				return;
			}
			
			if ((state == BANANA_THROWN || playerTurn != playerNumber) && !chatOpen)
				return;
			
			if(currentInput == chatInput || !blockInput)
				currentInput.addChar(e.charCode);
			
			if (e.keyCode == Keyboard.ENTER && currentInput.text != "") {
				if (currentInput == chatInput){
					connection.send(currentInput.text);
					if (playerNumber == 1)
						player1ChatBubble.create(currentInput.text, gorilla1.x, gorilla1.y);
					else
						player2ChatBubble.create(currentInput.text, gorilla2.x, gorilla2.y);
					chatOpen = false;
					currentInput.text = "";
					currentInput = (state == ANGLE_INPUT ? angleInput : velocityInput);
				}else {
					nextStep();
				}
			}
				
			if (e.keyCode == Keyboard.BACKSPACE)
				currentInput.backspace();
				
			if (e.keyCode == Keyboard.ESCAPE || (e.keyCode == Keyboard.ENTER && currentInput.text != "" && currentInput == chatInput)){
				chatOpen = false;
				currentInput = (state == ANGLE_INPUT ? angleInput : velocityInput);
			}
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
			
				// if a velocity has just been entered, send the details to the server
				case VELOCITY_INPUT:
				
					var angle:int = int(angleInput.text);
					var velocity:int = int(velocityInput.text);
				
					if (playerTurn == 2)
						angle = 180 - angle;
					
					blockInput = true;
						
					connection.send("throw", angle, velocity);
					
					break;
			
				case GORILLA1_HIT:					
				case GORILLA2_HIT:
					playerTurn = 3 - playerTurn;
					if (player1Score + player2Score >= PLAY_TO_POINTS) {
						connection.disconnect();
						gotoState(new ScoreOverview(client, kongregate, isPrivate, playerNumber, player1Name, player2Name, player1Score, player2Score));
					}else{
						newGame();
					}
					break;
					
				case BUILDING_HIT:
				
					playerTurn = 3 - playerTurn;
					
					if (playerTurn != playerNumber) {
						angleText.text = "Opponent turn";
						angleInput.removeCursor();
					}else {
						angleText.text = "Angle:";
						angleInput.showCursor();
					}
					
					angleInput.text = "";
					velocityInput.text = "";
					if(!chatOpen)
						currentInput = angleInput;
					angleInput.x = (520 * (playerTurn - 1)) + 58;
					angleText.x = 520 * (playerTurn - 1);
					velocityText.x = 520 * (playerTurn - 1);
					sun.reset();
					blockInput = false;
					state = ANGLE_INPUT;
					break;		
			}	
		}
		
		// throw a banana
		private function throwBanana(angle:int, velocity:int):void {
			
			if (playerTurn == 1){
				var startPoint:Point = new Point(gorilla1.x, gorilla1.y - 7);
				gorilla1.throwAnimation();
				var alt:Boolean = gorilla1.isAsh;
			}
				
			if (playerTurn == 2){
				startPoint = new Point(gorilla2.x + 25, gorilla2.y - 7);
				gorilla2.throwAnimation();
				alt = gorilla2.isAsh;
			}
			
			banana.launch(angle, velocity, GRAVITY, cityscape.windSpeed, startPoint, alt);
			currentTime = TURN_TIME_LIMIT;
			state = BANANA_THROWN;
		}
		
		// received a shot from the server
		private function onReceivedThrow(message:Message, angle:int, velocity:int):void {
					
			throwBanana(angle, velocity);
		}
		
		// someone took too long to take their turn
		private function onTimeOut(message:Message):void {
			
			if (playerTurn == playerNumber) {
				
			}
			state = BUILDING_HIT;
			nextStep();
		}
		
		// the other player has left the game
		private function onUserLeft(message:Message):void {
		
			errorMessage = new CharChain("Your opponent has left the game. Press any key to return to the menu.", 0, 70);
			errorMessage.centre();
			
			connection.removeMessageHandler("throw", onReceivedThrow);
			connection.removeMessageHandler("timeOut", onTimeOut);
			connection.removeMessageHandler("userLeft", onUserLeft);
			
			state = DISCONNECTED;
		}
		
		// we have been disconnected by the server
		private function onDisconnected():void {
			
			errorMessage = new CharChain("You have been disconnected from the server. Press any key to return to the menu.", 0, 70);
			errorMessage.centre();
			state = DISCONNECTED;
		}
		
		// received a chat message
		private function onReceivedChat(message:Message, text:String):void {
			
			if (playerNumber == 1)
				player2ChatBubble.create(text, gorilla2.x, gorilla2.y);
			else
				player1ChatBubble.create(text, gorilla1.x, gorilla1.y);
		}
	}
}