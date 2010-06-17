package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import playerio.*;
	
	/**
	 * Start a game with a specific user
	 * @author moly
	 */
	
	public class PrivateGame extends GameState{
		
		// text
		private static const createRoom:CharChain = new CharChain("1. Create room", 200, 96, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const joinRoom:CharChain = new CharChain("2. Join room", 200, 112, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const roomNamePrompt:CharChain = new CharChain("Enter name of the opponent to connect to: ", 70, 150, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var roomNameInput:CharChain = new CharChain("", roomNamePrompt.x + (roomNamePrompt.length * 8), roomNamePrompt.y, CharChain.BLINKING, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const pressToGoBack:CharChain = new CharChain("Press x to go back", 250, 320, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var informationText:CharChain = new CharChain("", 0, 150, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		// room connection
		private var connection:Connection;
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		// block the input if needed
		private var blockInput:Boolean;
		
		// show the input field
		private var showInput:Boolean;
		
		// player's name
		private var myName:String;
		
		// whether the player is player 1 or player 2
		private var playerNumber:int;
		
		public function PrivateGame(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			blockInput = false;
			showInput = false;
			myName = kongregate.services.getUsername();
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (showInput) {
				if (e.keyCode == 13 && roomNameInput.text != ""){
					client.multiplayer.joinRoom(roomNameInput.text, { name:myName }, onJoinedRoom, onJoinedError);
					roomNameInput.removeCursor();
					showInput = false;
					playerNumber = 2;
				}else{
					roomNameInput.addChar(e.charCode);
				}
				return;
			}
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27)
				gotoState(new Menu(client, kongregate));
				
			if (blockInput)
				return;
				
			// create room
			if (e.keyCode == 49){
				client.multiplayer.createJoinRoom(myName, "public", false, { privy:"yes" }, { name:myName }, onJoinedRoom, onJoinedError);
				informationText.text = "Waiting for opponent...";
				informationText.centre();
				blockInput = true;
				playerNumber = 1;
			}
			
			// join room
			if (e.keyCode == 50){
				showInput = true;
				blockInput = true;
			}
		}
		
		// successfully joined a room
		private function onJoinedRoom(connection:Connection):void {
			
			this.connection = connection;
			connection.addMessageHandler("start", onGameStarted);
		}
		
		// not successfully joined a room
		private function onJoinedError(error:PlayerIOError):void {
			
			informationText.text = "Opponent is not online."
			informationText.centre();
			trace(error);
		}
		
		// start a new game
		private function onGameStarted(message:Message, buildingCoordinates:ByteArray, player1Positions:ByteArray, player2Positions:ByteArray, windSpeeds:ByteArray, opponentName:String, player1Clothes:ByteArray, player2Clothes:ByteArray, player1Level:int, player2Level:int):void {
			
			gotoState(new Level(connection, client, kongregate, buildingCoordinates, player1Positions, player2Positions, windSpeeds, playerNumber, myName, opponentName, player1Clothes, player2Clothes, player1Level, player2Level, true));
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			createRoom.draw(canvas);
			joinRoom.draw(canvas);
			if(showInput){
				roomNamePrompt.draw(canvas);
				roomNameInput.draw(canvas);
			}
			pressToGoBack.draw(canvas);
			informationText.draw(canvas);
		}
	}
}