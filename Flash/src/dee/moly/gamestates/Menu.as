package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import playerio.*;
	
	/**
	 * A menu to decide game options
	 * @author moly
	 */
	
	public class Menu extends GameState {
		
		//text
		private static const menuItem1:CharChain = new CharChain("1. Quick Game", 200, 80, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const menuItem2:CharChain = new CharChain("2. Private Game", menuItem1.x, menuItem1.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const menuItem3:CharChain = new CharChain("3. Single Player Game", menuItem2.x, menuItem2.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const menuItem4:CharChain = new CharChain("4. View Stats", menuItem3.x, menuItem3.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const menuItem5:CharChain = new CharChain("5. Edit Gorilla", menuItem4.x, menuItem4.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private static const menuItem6:CharChain = new CharChain("6. View Leaderboards", menuItem5.x, menuItem5.y + 16, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		private var informationText:CharChain = new CharChain("", 0, 225, CharChain.NONE, CharChain.ALPHANUMERIC, 0xA8A8A8);
		
		// player.io client reference
		private var client:Client;
		
		// room connection
		private var connection:Connection;
		
		// kongregate API reference 
		private var kongregate:*;
		
		// player's name
		private var myName:String;
		
		// whether the player is player 1 or player 2
		private var playerNumber:int;
		
		// block the input if needed
		private var blockInput:Boolean;
		
		public function Menu(client:Client, kongregate:*) {
		
			this.kongregate = kongregate;
			this.client = client;
			
			myName = kongregate.services.getUsername();
			blockInput = false;
		}
		
		// draw menu options
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF000000);
			
			menuItem1.draw(canvas);
			menuItem2.draw(canvas);
			menuItem3.draw(canvas);
			menuItem4.draw(canvas);
			menuItem5.draw(canvas);
			menuItem6.draw(canvas);
			
			informationText.draw(canvas);
		}
		
		// decide valid input and such
		override public function onKeyDown(e:KeyboardEvent):void {
			
			// x or escape
			if (e.keyCode == 88 || e.keyCode == 27) {
				if (connection.connected) {
					blockInput = false;
					informationText.text = "";
					connection.disconnect();
					connection.removeMessageHandler("start", onGameStarted);
				}
			}
			
			if (blockInput)
				return;
			
			switch(e.keyCode) {
				
				// quick game
				case 49:
					findRoom();
					break;
					
				// private game
				case 50:
					gotoState(new PrivateGame(client, kongregate));
					break;
				
				// single player game
				case 51:
					client.bigDB.loadMyPlayerObject(onPlayerObjectLoaded);
					break;
					
				// view stats
				case 52:
					gotoState(new MyStats(client, kongregate));
					break;
				
				// edit gorilla
				case 53:
					gotoState(new GorillaEditor(client, kongregate));
					break;
					
				// view leaderboards
				case 54:
					gotoState(new Leaderboards(client, kongregate));
					break;
			}
		}
		
		// retrieve a list of rooms
		private function findRoom():void {
			
			blockInput = true;
			informationText.text = "Finding an opponent...";
			informationText.centre();
			
			client.multiplayer.listRooms("BattleServer", { }, 200, 0, onRetrievedRooms, onRetrieveRoomsError);
		}
		
		// successfully retrieved rooms
		private function onRetrievedRooms(rooms:Array):void {
			
			// try to join an open room
			for each(var room:RoomInfo in rooms) {
				if (room.onlineUsers == 1) {
					client.multiplayer.joinRoom(room.id, { name:myName }, onJoinedRoom, onJoinError);
					playerNumber = 2;
					return;
				}
			}
		
			// if there are no open rooms, create a new one
			client.multiplayer.createJoinRoom("", "BattleServer", true, {privy:"no"}, {name:myName}, onJoinedRoom, onJoinError);
			playerNumber = 1;
		}
		
		// not successfully retrieved rooms
		private function onRetrieveRoomsError(error:PlayerIOError):void {
			
			trace(error);
			findRoom();
		}
		
		// successfully loaded playeronject
		private function onPlayerObjectLoaded(object:DatabaseObject):void {
			
			gotoState(new BotLevel(client, kongregate, myName, (object.hat || 0), (object.shirt || 0), (object.trousers || 0)));
		}
		
		// successfully joined a room
		private function onJoinedRoom(connection:Connection):void {
			
			this.connection = connection;
			connection.addMessageHandler("start", onGameStarted);
		}
		
		// not successfully joined a room
		private function onJoinError(error:PlayerIOError):void {
			
			trace(error);
			findRoom();
		}
		
		// start a new game
		private function onGameStarted(message:Message, buildingCoordinates:ByteArray, player1Positions:ByteArray, player2Positions:ByteArray, windSpeeds:ByteArray, opponentName:String, player1Clothes:ByteArray, player2Clothes:ByteArray, player1Level:int, player2Level:int):void {
			
			gotoState(new Level(connection, client, kongregate, buildingCoordinates, player1Positions, player2Positions, windSpeeds, playerNumber, myName, opponentName, player1Clothes, player2Clothes, player1Level, player2Level, false));
		}
		
	}

}