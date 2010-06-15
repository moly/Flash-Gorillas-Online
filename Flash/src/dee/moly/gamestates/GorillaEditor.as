package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import dee.moly.textures.GorillaTex;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import playerio.*;
	
	/**
	 * Customise your gorilla
	 * @author moly
	 */
	
	public class GorillaEditor extends GameState{
		
		// text
		private var hatType:CharChain = new CharChain("", 120, 105);
		private var shirtType:CharChain = new CharChain("", hatType.x, hatType.y + 48);
		private var trouserType:CharChain = new CharChain("", shirtType.x, shirtType.y + 48);
		private static const pressToGoBack:CharChain = new CharChain("Press x to save and exit", 240, 320);
		
		// gorilla
		private static const gorillaTex:GorillaTex = new GorillaTex(GorillaTex.ARMS_DOWN);
		
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
			
			hatType.text = "Hat: " + (object.hatType || "none");
			shirtType.text = "Shirt: " + (object.shirtType || "none");
			trouserType.text = "Trousers: " + (object.trouserType || "none");
		}
		
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF0000AB);
			
			var m:Matrix = new Matrix();
			m.scale(4, 4);
			m.translate(400, 100);
			canvas.draw(gorillaTex, m);
			
			hatType.draw(canvas);
			shirtType.draw(canvas);
			trouserType.draw(canvas);
			
			pressToGoBack.draw(canvas);
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			// x or esc
			if (e.keyCode == 88 || e.keyCode == 27)
				gotoState(new Menu(client, kongregate));
		}
	}
}