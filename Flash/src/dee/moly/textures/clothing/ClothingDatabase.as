package dee.moly.textures.clothing {
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import dee.moly.textures.*;
	import playerio.*;
	
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
		
		// player object
		private var playerObject:DatabaseObject;
		
		// arm state
		private var arms:int = GorillaTex.ARMS_DOWN;
		public function set armState(value:int):void {
			arms = value;
		}
		
		// current clothes numbers
		public function get currentHatNumber():int {
			return currentHat;
		}
		public function get currentShirtNumber():int {
			return currentShirt;
		}
		public function get currentTrousersNumber():int {
			return currentTrousers;
		}
		
		// names of current clothing
		public function get currentHatName():String {
			return hatCollection[currentHat].name;
		}
		public function get currentShirtName():String {
			return shirtCollection[currentShirt].name;
		}
		public function get currentTrousersName():String {
			return trouserCollection[currentTrousers].name;
		}
		
		// whether or not the current item is unlocked
		public function get currentHatUnlocked():Boolean {
			return hatCollection[currentHat].requirements();
		}
		public function get currentShirtUnlocked():Boolean {
			return shirtCollection[currentShirt].requirements();
		}
		public function get currentTrousersUnlocked():Boolean {
			return trouserCollection[currentTrousers].requirements();
		}
		
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
		
		public function ClothingDatabase(x:int, y:int, scale:int = 1, playerObject:DatabaseObject = null) {
			
			this.playerObject = playerObject;
			
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
			
			do{
				currentHat++;
				if (currentHat > hatCollection.length - 1)
					currentHat = 0;
			}while (currentHatUnlocked == false);
				
			setTextures();
		}
		
		// go to previous hat
		public function previousHat():void {
			
			do{
				currentHat--;
				if (currentHat < 0)
					currentHat = hatCollection.length - 1;
			}while (currentHatUnlocked == false);
			
			setTextures();
		}
		
		// go to next shirt
		public function nextShirt():void {
			
			do{
				currentShirt++;
				if (currentShirt > shirtCollection.length - 1)
					currentShirt = 0;
			}while (currentShirtUnlocked == false);
				
			setTextures();
		}
		
		// go to previous shirt
		public function previousShirt():void {
			
			do{
				currentShirt--;
				if (currentShirt < 0)
					currentShirt = shirtCollection.length - 1;
			}while (currentShirtUnlocked == false);
				
			setTextures();
		}
		
		// go to next trousers
		public function nextTrousers():void {
			
			do{
				currentTrousers++;
				if (currentTrousers > trouserCollection.length - 1)
					currentTrousers = 0;
			}while (currentTrousersUnlocked == false);
				
			setTextures();
		}
		
		// go to previous trousers
		public function previousTrousers():void {
			
			do{
				currentTrousers--;
				if (currentTrousers < 0)
					currentTrousers = trouserCollection.length - 1;
			}while (currentTrousersUnlocked == false);
				
			setTextures();
		}
		
		// go to next matching clothes set
		public function nextClothesSet():void {
			
			do{
				currentHat++;
				if (currentHat > hatCollection.length - 1 || currentHat > shirtCollection.length - 1 || currentHat > trouserCollection.length - 1)
					currentHat = 0;
				
				currentShirt = currentHat;
				currentTrousers = currentHat;
			}while (currentHatUnlocked == false || currentShirtUnlocked == false || currentTrousersUnlocked == false);
				
			setTextures();
		}
		
		// go to next matching clothes set
		public function previousClothesSet():void {
			
			do{
				currentHat--;
				if (currentHat < 0)
					currentHat = trouserCollection.length - 1;
			
				if (currentHat > hatCollection.length - 1 || currentHat > shirtCollection.length - 1 || currentHat > trouserCollection.length - 1)
					currentHat = 0;
				
				currentShirt = currentHat;
				currentTrousers = currentHat;
			}while (currentHatUnlocked == false || currentShirtUnlocked == false || currentTrousersUnlocked == false);
			
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
			hatCollection = [new ClothingItem("None", BlankHat, function():Boolean { return true; } ),
								new ClothingItem("Red", RedHat, function():Boolean { return true; } ),
								new ClothingItem("Blue", BlueHat, function():Boolean { return true; } ),
								new ClothingItem("Green", GreenHat, function():Boolean { return true;} ),
								new ClothingItem("Head Band", RamboHat, function():Boolean { return (playerObject.level || 0) >= 1;} ),
								new ClothingItem("Bandana", PirateHat, function():Boolean { return (playerObject.level || 0) >= 2; } ),
								new ClothingItem("Doctor", DoctorHead, function():Boolean { return (playerObject.level || 0) >= 3;} ),
								new ClothingItem("Trucker Cap", PokeHat, function():Boolean { return (playerObject.level || 0) >= 4;} ),
								new ClothingItem("Battle Paint", BraveheartHead, function():Boolean { return (playerObject.level || 0) >= 5;} ),
								new ClothingItem("Black Hair", SuperHair, function():Boolean { return (playerObject.level || 0) >= 6;} ),
								new ClothingItem("Red Cap", PlumberCap, function():Boolean { return (playerObject.level || 0) >= 7;} ),
								new ClothingItem("Bowler Hat", ClockworkHat, function():Boolean { return (playerObject.level || 0) >= 8;} ),
								new ClothingItem("Lobster", LobsterHead, function():Boolean { return (playerObject.level || 0) >= 9;} ),
								new ClothingItem("Skull", SkeletonHead, function():Boolean { return (playerObject.level || 0) >= 10;} ),
								new ClothingItem("Robo Helmet", RoboPoliceHelmet, function():Boolean { return (playerObject.level || 0) >= 11;} ),
								new ClothingItem("Top Hat", TopHat, function():Boolean { return (playerObject.level || 0) >= 12;} ),
								new ClothingItem("Timebot", ChronoHead, function():Boolean { return (playerObject.totalTime || 0) > 5000;} ),
								new ClothingItem("Zombie", ZombieHead, function():Boolean { return (playerObject.zombieUnlocked || playerObject.name.toLowerCase().indexOf("z") != -1);} ),
								new ClothingItem("Crown", Crown, function():Boolean { return playerObject.isOnLeaderBoards || false;} )
								];
		}
		
		// fill up the shirts collection
		private function populateShirts():void {
			
			shirtTextures = new Array();
			shirtCollection = [new ClothingItem("None", BlankShirt, function():Boolean { return true; } ),
								new ClothingItem("Red", RedShirt, function():Boolean { return true; } ),
								new ClothingItem("Blue", BlueShirt, function():Boolean { return true; } ),
								new ClothingItem("Green", GreenShirt, function():Boolean { return true;} ),
								new ClothingItem("Tank Top", RamboShirt, function():Boolean { return (playerObject.level || 0) >= 1;} ),
								new ClothingItem("Stripes", PirateShirt, function():Boolean { return (playerObject.level || 0) >= 2; } ),
								new ClothingItem("Doctor", DoctorShirt, function():Boolean { return (playerObject.level || 0) >= 3;} ),
								new ClothingItem("Blue", PokeShirt, function():Boolean { return (playerObject.level || 0) >= 4;} ),
								new ClothingItem("Tartan", BraveheartShirt, function():Boolean { return (playerObject.level || 0) >= 5;} ),
								new ClothingItem("Super Hero", SuperShirt, function():Boolean { return (playerObject.level || 0) >= 6;} ),
								new ClothingItem("Dungarees", PlumberShirt, function():Boolean { return (playerObject.level || 0) >= 7;} ),
								new ClothingItem("Droog", ClockworkShirt, function():Boolean { return (playerObject.level || 0) >= 8;} ),
								new ClothingItem("Lobster", LobsterBody, function():Boolean { return (playerObject.level || 0) >= 9;} ),
								new ClothingItem("Skeleton", SkeletonBody, function():Boolean { return (playerObject.level || 0) >= 10;} ),
								new ClothingItem("Robo Police", RoboPoliceBody, function():Boolean { return (playerObject.level || 0) >= 11;} ),
								new ClothingItem("Tuxedo", TuxShirt, function():Boolean { return (playerObject.level || 0) >= 12;} ),
								new ClothingItem("Timebot", ChronoBody, function():Boolean { return (playerObject.totalTime || 0) > 5000;} ),
								new ClothingItem("Zombie", ZombieBody, function():Boolean { return (playerObject.zombieUnlocked || playerObject.name.indexOf("z") != -1);} ),							
								];
		}
		
		// fill up the trouser collection
		private function populateTrousers():void {
			
			trouserTextures = new Array();
			trouserCollection = [new ClothingItem("None", BlankTrousers, function():Boolean { return true; } ),
									new ClothingItem("Red", RedTrousers, function():Boolean { return true; } ),
									new ClothingItem("Blue", BlueTrousers, function():Boolean { return true; } ),
									new ClothingItem("Green", GreenTrousers, function():Boolean { return true;} ),
									new ClothingItem("Dark Jeans", RamboTrousers, function():Boolean { return (playerObject.level || 0) >= 1;} ),
									new ClothingItem("Peg Leg", PirateTrousers, function():Boolean { return (playerObject.level || 0) >= 2; } ),
									new ClothingItem("Doctor", DoctorTrousers, function():Boolean { return (playerObject.level || 0) >= 3;} ),
									new ClothingItem("Jeans/Trainers", PokeTrousers, function():Boolean { return (playerObject.level || 0) >= 4;} ),
									new ClothingItem("Kilt", BraveheatTrousers, function():Boolean { return (playerObject.level || 0) >= 5;} ),
									new ClothingItem("Super Hero", SuperTrousers, function():Boolean { return (playerObject.level || 0) >= 6;} ),
									new ClothingItem("Jeans/Shoes", PlumberTrousers, function():Boolean { return (playerObject.level || 0) >= 7;} ),
									new ClothingItem("Droog", ClockworkTrousers, function():Boolean { return (playerObject.level || 0) >= 8;} ),
									new ClothingItem("Lobster", LobsterLegs, function():Boolean { return (playerObject.level || 0) >= 9;} ),
									new ClothingItem("Skeleton", SkeletonLegs, function():Boolean { return (playerObject.level || 0) >= 10;} ),
									new ClothingItem("Robo Police", RoboPoliceLegs, function():Boolean { return (playerObject.level || 0) >= 11;} ),
									new ClothingItem("Tuxedo", TuxTrousers, function():Boolean { return (playerObject.level || 0) >= 12;} ),
									new ClothingItem("Timebot", ChronoLegs, function():Boolean { return (playerObject.totalTime || 0) > 5000;} ),
									new ClothingItem("Zombie", ZombieLegs, function():Boolean { return (playerObject.zombieUnlocked || playerObject.name.indexOf("z") != -1);} ),
									];
		}
	}
}

import flash.display.BitmapData;

class ClothingItem {
	
	public var name:String;
	public var texture:Class;
	public var requirements:Function;
	
	public function ClothingItem(name:String, texture:Class, requirements:Function) {
		this.name = name;
		this.texture = texture;
		this.requirements = requirements;
	}
}