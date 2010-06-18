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
		private static const pressToGoBack:CharChain = new CharChain("Press x to save and exit", 220, 320);
		
		// gorilla
		private static const gorillaTex:GorillaTex = new GorillaTex(GorillaTex.ARMS_DOWN);
		
		// scaling and positioning for the gorilla
		private static const gorillaMatrix:Matrix = new Matrix(4, 0, 0, 4, 400, 100); 
		
		// store our clothing
		private var clothes:ClothingDatabase;
		
		// player.io client reference
		private var client:Client;
		
		// kongregate api reference
		private var kongregate:*;
		
		public function GorillaEditor(client:Client, kongregate:*) {
			
			this.client = client;
			this.kongregate = kongregate;
			
			client.bigDB.loadMyPlayerObject(onReceivedData);
		}
		
		// successfully received data
		private function onReceivedData(object:DatabaseObject):void {
			
			clothes = new ClothingDatabase(object.level || 0, 400, 100, 4);
			clothes.setClothes(object.hatType || 0, object.shirtType || 0, object.trouserType || 0);
			
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
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27)
				gotoState(new Menu(client, kongregate));
				
			if(e.keyCode == Keyboard.LEFT){
				clothes.nextHat();
				hatType.text = "Hat: " + clothes.currentHatName;
			}
			
			if(e.keyCode == Keyboard.RIGHT){
				clothes.nextShirt();
				shirtType.text = "Shirt: " + clothes.currentShirtName;
			}
			
			if(e.keyCode == Keyboard.DOWN){
				clothes.nextTrousers();
				trouserType.text = "Trousers: " + clothes.currentTrousersName;
			}
		}
	}
}