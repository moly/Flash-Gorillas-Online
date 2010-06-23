package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import dee.moly.textures.*;
	
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
		
		// arm state
		private var arms:int = GorillaTex.ARMS_DOWN;
		public function set armState(value:int):void {
			arms = value;
		}
		
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
		
		// clothing position
		public function set x(value:int):void {
			hatMatrix.tx = value + (8 * hatMatrix.a);
			shirtMatrix.tx = value;
			trouserMatrix.tx = value;
		}
		
		public function set y(value:int):void {
			hatMatrix.ty = value - (5 * hatMatrix.a);
			shirtMatrix.ty = value;// + (8 * shirtMatrix.a);
			trouserMatrix.ty = value + (20 * trouserMatrix.a);
		}
		
		public function ClothingDatabase(playerLevel:int, x:int, y:int, scale:int = 1) {
			
			this.playerLevel = playerLevel;
			
			hatMatrix = new Matrix(scale, 0, 0, scale, x + (8 * scale), y - (5 * scale));
			shirtMatrix = new Matrix(scale, 0, 0, scale, x, y);// + (8 * scale));
			trouserMatrix = new Matrix(scale, 0, 0, scale, x, y + (20 * scale));
			
			populateHats();
			populateShirts();
			populateTrousers();
			
			setClothes(0, 0, 0);
		}
		
		// draw the current clothes
		public function draw(canvas:BitmapData):void {
			
			canvas.draw(hatTextures[currentHat], hatMatrix);
			canvas.draw(shirtTextures[currentShirt][arms], shirtMatrix);
			canvas.draw(trouserTextures[currentTrousers], trouserMatrix);
		}
		
		// set the current clothing
		public function setClothes(hat:int, shirt:int, trousers:int):void {
			
			currentHat = hat;
			currentShirt = shirt;
			currentTrousers = trousers;
			
			setTextures();
		}
		
		// go to next hat
		public function nextHat():void {
			
			currentHat++;
			if (currentHat > hatCollection.length - 1)
				currentHat = 0;
				
			setTextures();
		}
		
		// go to previous hat
		public function previousHat():void {
			
			currentHat--;
			if (currentHat < 0)
				currentHat = hatCollection.length - 1;
				
			setTextures();
		}
		
		// go to next shirt
		public function nextShirt():void {
			
			currentShirt++;
			if (currentShirt > shirtCollection.length - 1)
				currentShirt = 0;
				
			setTextures();
		}
		
		// go to previous shirt
		public function previousShirt():void {
			
			currentShirt--;
			if (currentShirt < 0)
				currentShirt = shirtCollection.length - 1;
				
			setTextures();
		}
		
		// go to next trousers
		public function nextTrousers():void {
			
			currentTrousers++;
			if (currentTrousers > trouserCollection.length - 1)
				currentTrousers = 0;
				
			setTextures();
		}
		
		// go to previous trousers
		public function previousTrousers():void {
			
			currentTrousers--;
			if (currentTrousers < 0)
				currentTrousers = trouserCollection.length - 1;
				
			setTextures();
		}
		
		// go to next matching clothes set
		public function nextClothesSet():void {
			
			currentHat++;
			if (currentHat > hatCollection.length - 1 || currentHat > shirtCollection.length - 1 || currentHat > trouserCollection.length - 1)
				currentHat = 0;
				
			currentShirt = currentHat;
			currentTrousers = currentHat;
			
			setTextures();
		}
		
		// go to next matching clothes set
		public function previousClothesSet():void {
			
			currentHat--;
			if (currentHat < 0)
				currentHat = trouserCollection.length - 1;
			
			if (currentHat > hatCollection.length - 1 || currentHat > shirtCollection.length - 1 || currentHat > trouserCollection.length - 1)
				currentHat = 0;
				
			currentShirt = currentHat;
			currentTrousers = currentHat;
			
			setTextures();
		}
		
		// make sure needed textures are loaded
		private function setTextures():void {
			
			if (hatTextures[currentHat] == null)
				hatTextures[currentHat] = new hatCollection[currentHat].texture();
				
			if (shirtTextures[currentShirt] == null)
				shirtTextures[currentShirt] = [	new shirtCollection[currentShirt].texture(GorillaTex.LEFT_ARM),
												new shirtCollection[currentShirt].texture(GorillaTex.RIGHT_ARM),
												new shirtCollection[currentShirt].texture(GorillaTex.ARMS_DOWN)
												]
				
			if (trouserTextures[currentTrousers] == null)
				trouserTextures[currentTrousers] = new trouserCollection[currentTrousers].texture();
		}
		
		// fill up the hats collection
		private function populateHats():void {
			
			hatTextures = new Array();
			hatCollection = [new ClothingItem("None", BlankHat, 0),
								new ClothingItem("Top Hat", TopHat, 1),
								new ClothingItem("Zombie", ZombieHead, 2),
								new ClothingItem("Timebot", ChronoHead, 3),
								new ClothingItem("Lobster", LobsterHead, 4),
								new ClothingItem("Black Hair", SuperHair, 5),
								new ClothingItem("Red Cap", PlumberCap, 6),
								new ClothingItem("Skull", SkeletonHead, 7),
								new ClothingItem("Bowler Hat", ClockworkHat, 8),
								new ClothingItem("Battle Paint", BraveheartHead, 9),
								new ClothingItem("Robo Helmet", RoboPoliceHelmet, 10),
								new ClothingItem("Trucker Cap", PokeHat, 11),
								new ClothingItem("Head Band", RamboHat, 12),
								new ClothingItem("Bandana", PirateHat, 13),
								new ClothingItem("Crown", Crown, 20)
								];
		}
		
		// fill up the shirts collection
		private function populateShirts():void {
			
			shirtTextures = new Array();
			shirtCollection = [new ClothingItem("None", BlankShirt, 0),
								new ClothingItem("Tuxedo", TuxShirt, 1),
								new ClothingItem("Zombie", ZombieBody, 2),
								new ClothingItem("Timebot", ChronoBody, 3),
								new ClothingItem("Lobster", LobsterBody, 4),
								new ClothingItem("Super Hero", SuperShirt, 5),
								new ClothingItem("Dungarees", PlumberShirt, 6),
								new ClothingItem("Skeleton", SkeletonBody, 7),
								new ClothingItem("Droog", ClockworkShirt, 8),
								new ClothingItem("Tartan", BraveheartShirt, 9),
								new ClothingItem("Robo Police", RoboPoliceBody, 10),
								new ClothingItem("Blue", PokeShirt, 11),
								new ClothingItem("Tank Top", RamboShirt, 12),
								new ClothingItem("Stripes", PirateShirt, 13)
								];
		}
		
		// fill up the trouser collection
		private function populateTrousers():void {
			
			trouserTextures = new Array();
			trouserCollection = [new ClothingItem("None", BlankTrousers, 0),
									new ClothingItem("Tuxedo", TuxTrousers, 1),
									new ClothingItem("Zombie", ZombieLegs, 2),
									new ClothingItem("Timebot", ChronoLegs, 3),
									new ClothingItem("Lobster", LobsterLegs, 4),
									new ClothingItem("Super Hero", SuperTrousers, 5),
									new ClothingItem("Jeans/Shoes", PlumberTrousers, 6),
									new ClothingItem("Skeleton", SkeletonLegs, 7),
									new ClothingItem("Droog", ClockworkTrousers, 8),
									new ClothingItem("Kilt", BraveheatTrousers, 9),
									new ClothingItem("Robo Police", RoboPoliceLegs, 10),
									new ClothingItem("Jeans/Trainers", PokeTrousers, 11),
									new ClothingItem("Dark Jeans", RamboTrousers, 12),
									new ClothingItem("Peg Leg", PirateTrousers, 13)
									];
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