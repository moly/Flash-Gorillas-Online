package dee.moly.textures {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	/**
	 * Manages optional clothing for the gorilla
	 * @author moly
	 */
	
	public class ClothingDatabase{
		
		// hat collection
		private var hatCollection:Array;
		
		// shirt collection
		private var shirtCollection:Array;
		
		// trouser collection
		private var trouserCollection:Array;
		
		// texture collections
		private var hatTextures:Array;
		private var shirtTextures:Array;
		private var trouserTextures:Array;
		
		// current clothes chosen
		private var currentHat:int;
		private var currentShirt:int;
		private var currentTrousers:int;
		
		// names of current clothing
		public function get currentHatName():String {
			return hatCollection[currentHat].level <= playerLevel ? hatCollection[currentHat].name : "Requires level " + hatCollection[currentHat].level;
		}
		public function get currentShirtName():String {
			return shirtCollection[currentShirt].level <= playerLevel ? shirtCollection[currentShirt].name : "Requires level " + shirtCollection[currentShirt].level;
		}
		public function get currentTrousersName():String {
			return trouserCollection[currentTrousers].level <= playerLevel ? trouserCollection[currentTrousers].name : "Requires level " + trouserCollection[currentTrousers].level;
		}
		
		// players level
		private var playerLevel:int;
		
		// position/scale matrix
		private var hatMatrix:Matrix;
		private var shirtMatrix:Matrix;
		private var trouserMatrix:Matrix;
		
		public function ClothingDatabase(playerLevel:int, x:int, y:int, scale:int = 1) {
			
			this.playerLevel = playerLevel;
			
			hatMatrix = new Matrix(scale, 0, 0, scale, x + (8 * scale), y - (5 * scale));
			shirtMatrix = new Matrix(scale, 0, 0, scale, x, y + (8 * scale));
			trouserMatrix = new Matrix(scale, 0, 0, scale, x, y + (20 * scale));
			
			populateHats();
			populateShirts();
			populateTrousers();
			
			setClothes(0, 0, 0);
		}
		
		// draw the current clothes
		public function draw(canvas:BitmapData):void {
			
			canvas.draw(hatTextures[currentHat], hatMatrix);
			canvas.draw(shirtTextures[currentShirt], shirtMatrix);
			canvas.draw(trouserTextures[currentTrousers], trouserMatrix);
		}
		
		// set the current clothing
		public function setClothes(hat:int, shirt:int, trousers:int):void {
			
			currentHat = hat;
			currentShirt = shirt;
			currentTrousers = trousers;
			
			if (hatTextures[currentHat] == null)
				hatTextures[currentHat] = new hatCollection[currentHat].texture();
				
			if (shirtTextures[currentShirt] == null)
				shirtTextures[currentShirt] = new shirtCollection[currentShirt].texture();
				
			if (trouserTextures[currentTrousers] == null)
				trouserTextures[currentTrousers] = new trouserCollection[currentTrousers].texture();
		}
		
		// go to next hat
		public function nextHat():void {
			
			currentHat++;
			if (currentHat > hatCollection.length - 1)
				currentHat = 0;
				
			if (hatTextures[currentHat] == null)
				hatTextures[currentHat] = new hatCollection[currentHat].texture();
		}
		
		// go to previous hat
		public function previousHat():void {
			
			currentHat--;
			if (currentHat < 0)
				currentHat = hatCollection.length - 1;
				
			if (hatTextures[currentHat] == null)
				hatTextures[currentHat] = new hatCollection[currentHat].texture();
		}
		
		// go to next shirt
		public function nextShirt():void {
			
			currentShirt++;
			if (currentShirt > shirtCollection.length - 1)
				currentShirt = 0;
				
			if (shirtTextures[currentShirt] == null)
				shirtTextures[currentShirt] = new shirtCollection[currentShirt].texture();
		}
		
		// go to previous shirt
		public function previousShirt():void {
			
			currentShirt--;
			if (currentShirt < 0)
				currentShirt = shirtCollection.length - 1;
				
			if (shirtTextures[currentShirt] == null)
				shirtTextures[currentShirt] = new shirtCollection[currentShirt].texture();
		}
		
		// go to next trousers
		public function nextTrousers():void {
			
			currentTrousers++;
			if (currentTrousers > trouserCollection.length - 1)
				currentTrousers = 0;
				
			if (trouserTextures[currentTrousers] == null)
				trouserTextures[currentTrousers] = new trouserCollection[currentTrousers].texture();
		}
		
		// go to previous trousers
		public function previousTrousers():void {
			
			currentTrousers--;
			if (currentTrousers < 0)
				currentTrousers = trouserCollection.length - 1;
				
			if (trouserTextures[currentTrousers] == null)
				trouserTextures[currentTrousers] = new trouserCollection[currentTrousers].texture();
		}
		
		// fill up the hats collection
		private function populateHats():void {
			
			hatCollection = new Array();
			hatTextures = new Array();
			hatCollection.push(new ClothingItem("none", Blank, 0));
			hatCollection.push(new ClothingItem("Top Hat", TopHat, 1));
		}
		
		// fill up the shirts collection
		private function populateShirts():void {
			
			shirtCollection = new Array();
			shirtTextures = new Array();
			shirtCollection.push(new ClothingItem("none", Blank, 0));
			shirtCollection.push(new ClothingItem("Tuxedo", TuxShirt, 1));
		}
		
		// fill up the trouser collection
		private function populateTrousers():void {
			
			trouserCollection = new Array();
			trouserTextures = new Array();
			trouserCollection.push(new ClothingItem("none", Blank, 0));
			trouserCollection.push(new ClothingItem("Tuxedo", TuxTrousers, 1));
		}
	}
}

import flash.display.BitmapData;

class ClothingItem {
	
	public var name:String;
	public var texture:Class;
	public var level:int;
	
	public function ClothingItem(name:String, texture:Class, level:int) {
		this.name = name;
		this.texture = texture;
		this.level = level;
	}
}