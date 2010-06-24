package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import dee.moly.textures.clothing.ClothingDatabase;
	import dee.moly.textures.GorillaTex;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import playerio.*;
	
	/**
	 * Customise your gorilla
	 * @author moly
	 */
	
	public class GorillaEditor extends GameState{
		
		// text
		private var hatType:CharChain = new CharChain("Hat:", 120, 105);
		private var shirtType:CharChain = new CharChain("Shirt:", hatType.x, hatType.y + 48);
		private var trouserType:CharChain = new CharChain("Trousers:", shirtType.x, shirtType.y + 48);
		private var pressToGoBack:CharChain = new CharChain("Press x to save and exit", 220, 320);
		
		// gorilla
		private static const gorillaTex:GorillaTex = new GorillaTex(GorillaTex.ARMS_DOWN);
		
		// scaling and positioning for the gorilla
		private static const gorillaMatrix:Matrix = new Matrix(4, 0, 0, 4, 400, 100); 
		
		// store our clothing
		private var clothes:ClothingDatabase;
		
		// which piece of clothing we are chosing
		private var menuItem:int;
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		// stop input if needed
		private var blockInput:Boolean;
		
		public function GorillaEditor(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			menuItem = 3;
			client.bigDB.loadMyPlayerObject(onReceivedData);
		}
		
		// successfully received data
		private function onReceivedData(object:DatabaseObject):void {
			
			clothes = new ClothingDatabase(object.level || 999, 400, 100, 4);
			clothes.setClothes(object.hat || 0, object.shirt || 0, object.trousers || 0);
			
			hatType.text = "Hat: " + clothes.currentHatName;
			shirtType.text = "Shirt: " + clothes.currentShirtName;
			trouserType.text = "Trousers: " + clothes.currentTrousersName;
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF0000AB);
			
			canvas.draw(gorillaTex, gorillaMatrix);
			
			hatType.draw(canvas);
			shirtType.draw(canvas);
			trouserType.draw(canvas);
			
			if(clothes != null)
				clothes.draw(canvas);
			
			pressToGoBack.draw(canvas);
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if (blockInput)
				return;
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27) {
				client.multiplayer.createJoinRoom("", "CostumeServer", true, { }, { hat:clothes.currentHatNumber, shirt:clothes.currentShirtNumber, trousers:clothes.currentTrousersNumber }, onJoinedRoom);
				pressToGoBack.text = "Saving...";
				pressToGoBack.centre();
				blockInput = true;
			}
				
			if (clothes == null)
				return;
			
			if (e.keyCode == Keyboard.LEFT) {
				switch(menuItem) {
					case 0:
						clothes.previousHat();
						break;
					case 1:
						clothes.previousShirt();
						break;
					case 2:
						clothes.previousTrousers();
						break;
					case 3:
						clothes.previousClothesSet();
				}
			}
				
			if (e.keyCode == Keyboard.RIGHT) {
				switch(menuItem) {
					case 0:
						clothes.nextHat();
						break;
					case 1:
						clothes.nextShirt();
						break;
					case 2:
						clothes.nextTrousers();
						break;
					case 3:
						clothes.nextClothesSet();
				}
			}
			
			if (e.keyCode == Keyboard.DOWN) {
				menuItem++;
				if (menuItem > 3)
					menuItem = 0;
			}
				
			if (e.keyCode == Keyboard.UP) {
				menuItem--;
				if (menuItem < 0)
					menuItem = 3;
			}
			
			hatType.text = "Hat: " + clothes.currentHatName;
			shirtType.text = "Shirt: " + clothes.currentShirtName;
			trouserType.text = "Trousers: " + clothes.currentTrousersName;
		}
		
		// successfully joined a room
		private function onJoinedRoom(connection:Connection):void {
			connection.addMessageHandler("saved", function(message:Message):void{ gotoState(new Menu(client, kongregate)); });
		}
	}
}