package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import playerio.*;
	
	/**
	 * A menu to decide game options
	 * @author moly
	 */
	
	public class Menu extends GameState {
		
		//text
		private static const playerNameText:CharChain = new CharChain("Name of Player 1: ", 141, 80, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var playerNameInput:CharChain = new CharChain("", playerNameText.x + playerNameText.length * 8, 80, CharChain.BLINKING, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		// multiplayer client
		private var client:Client;
		
		// multiplayer connection
		private var connection:Connection;
		
		// player's name
		private var myName:String;
		
		// whether the player is player 1 or player 2
		private var playerNumber:int;
		
		public function Menu() {
		
			
		}
		
		// draw menu options
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			playerNameText.draw(canvas);
			playerNameInput.draw(canvas);
			
		}
		
		// decide valid input and such
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (myName != null) return;
			
			if (e.keyCode == 13 && playerNameInput.text != ""){
				myName = playerNameInput.text.substring(0, 10);
				playerNameInput.removeCursor();
				PlayerIO.connect(Main.stageRef, "flash-gorillas-online-1nrdveekuspcredhsoew", "public", myName + int(Math.random()*99999), "", onConnected, onConnectionError);
			}
			
			else if (e.keyCode == 8)
				playerNameInput.backspace();
			else 
				playerNameInput.addChar(e.charCode);
				
		}
		
		// successfully connected
		private function onConnected(client:Client):void {
			trace("connected");
			this.client = client;
			getRooms();
		}
		
		// not successfully connected
		private function onConnectionError(error:PlayerIOError):void {
			trace(error);
		}
		
		// retrieve a list of rooms
		private function getRooms():void {
			client.multiplayer.developmentServer = "localhost:8184";
			client.multiplayer.listRooms("gorillas", { }, 200, 0, onRetrievedRooms, onRetrieveRoomsError);  
		}
		
		// successfully retrieved rooms
		private function onRetrievedRooms(rooms:Array):void {
			
			for each(var room:RoomInfo in rooms) {
				if (room.onlineUsers == 1) {
					client.multiplayer.joinRoom(room.id, { name:myName }, onJoinedRoom);
					playerNumber = 2;
					return;
				}
			}
				
			client.multiplayer.createJoinRoom("", "gorillas", true, { }, {name:myName}, onJoinedRoom);
			playerNumber = 1;
		}
		
		// not successfully retrieved rooms
		private function onRetrieveRoomsError(error:PlayerIOError):void {
			trace(error);
			//getRooms();
		}
		
		// successfully joined a room
		private function onJoinedRoom(connection:Connection):void {
			this.connection = connection;
			connection.addMessageHandler("start", onGameStarted);
		}
		
		// start a new game
		private function onGameStarted(message:Message, opponentName:String):void {
			
			gotoState(new Level(connection, playerNumber, myName, opponentName));
		}
		
	}

}