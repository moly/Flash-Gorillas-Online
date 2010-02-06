package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import dee.moly.gameobjects.CityScape;
	import dee.moly.gameobjects.Gorilla;
	import flash.display.BitmapData;
	import dee.moly.textures.ContentManager;
	import flash.events.KeyboardEvent;
	import dee.moly.gameobjects.Sun;
	
	/**
	 * the main level with the gorillas and the buildings and such
	 * @author moly
	 */
	
	public class GameStateLevel extends GameState{
		
		// the game setings for this round
		private var gameSettings:GameSettings;
		
		// the cityscape in the background
		private var cityScape:CityScape;
		
		// two gorillas
		private var gorilla1:Gorilla;
		private var gorilla2:Gorilla;
		
		// names
		private var player1NameText:CharChain;
		private var player2NameText:CharChain;
		
		// a smiley sun
		private var sun:Sun;
		
		public function GameStateLevel(gameSettings:GameSettings) {
			
			this.gameSettings = gameSettings;
			
			gorilla1 = new Gorilla();
			gorilla2 = new Gorilla();
			
			player1NameText = new CharChain(gameSettings.player1Name, 0, 3);
			player2NameText = new CharChain(gameSettings.player2Name, Main.SCREEN_WIDTH - (gameSettings.player2Name.length * 8) - 8, 3);
			
			sun = new Sun();
			
			cityScape = new CityScape();
			placeGorillas(cityScape.buildSkyline());
			
		}
		
		// put the gorillas on either the second or third building from either end
		private function placeGorillas(buildingCoords:Array):void {

			const xAdj:int = 15;
			const yAdj:int = 29;

			for (var i:int = 1; i <= 2; i++){

				if (i == 1)
					var bNum:int = int(Math.random() * 2) + 1;
				else
					bNum = buildingCoords.length - 1 - (int(Math.random() * 2) + 1);
					
				var bWidth:int = buildingCoords[bNum + 1][0] - buildingCoords[bNum][0];
				
				if (i == 1){
					gorilla1.x = buildingCoords[bNum][0] + bWidth / 2 - xAdj;
					gorilla1.y = buildingCoords[bNum][1] - yAdj;
				}else{
					gorilla2.x = buildingCoords[bNum][0] + bWidth / 2 - xAdj;
					gorilla2.y = buildingCoords[bNum][1] - yAdj;
				}

			}
			
		}
		
		// draw everything to the screen
		override public function draw(canvas:BitmapData):void {
			
			canvas.fillRect(canvas.rect, 0xFF0000AD);
			cityScape.draw(canvas);
			player1NameText.draw(canvas);
			player2NameText.draw(canvas);
			gorilla1.draw(canvas);
			gorilla2.draw(canvas);
			sun.draw(canvas);
			
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			cityScape.buildSkyline();
			
		}
		
	}

}