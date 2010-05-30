package dee.moly.gameobjects {
	
	import dee.moly.textures.DrawingBitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * generates a random skyline
	 * @author moly, borrowed heavily from Chris King
	 */
	
	public class CityScape extends GameObject{
		
		// colours	
		private static const BUILDING_RED:uint = 0xFFA80000;
		private static const BUILDING_GRAY:uint	= 0xFFA8A8A8;	
		private static const BUILDING_GREEN:uint = 0xFF00A8A8;	
		private static const LIT_WINDOW_COLOUR:uint = 0xFFFCFC54;
		private static const UNLIT_WINDOW_COLOUR:uint = 0xFF545454;
		private static const EXPLOSION_COLOUR:uint = 0xFFFC0054;
		
		// measurment Constants
		private static const BUILDING_SEPARATION:int = 1;
		private static const UPPER_DRAWING_LIMIT:int = 65;
		private static const WIDTH_AGGREGATE:int = 70;
		private static const HEIGHT_AGGREGATE:int = 70;
		private static const WINDOW_WIDTH:int = 4;
		private static const WINDOW_HEIGHT:int = 7;
		
		// all new heights generated will increase or decrease by this amount
		private static const HEIGHT_TREND:int = 18;
		
		// all new widths generated will increase or decrease by this amount
		private static const WIDTH_TREND:int = 32;
		
		private static const WINDOW_HEIGHT_SEPARATION:int = 15;
		private static const WINDOW_WIDTH_SEPARATION:int = 10;
		private static const BUILDING_MINIMUM_HEIGHT:int = 25;
		
		private var buildingCoordinates:Array;
		
		private var explosionPosition:Point;
		private var explosionRadius:Number;
		private var explosionUp:Boolean = true;
		private var _explosionFinished:Boolean = false;
		public function get explosionFinished():Boolean {
			return _explosionFinished;
		}
		
		// the level's wind speed
		private var wind:int;
		public function get windSpeed():int {
			return wind;
		}
		
		public function CityScape() {
			
			position = new Point(0, 0);
			texture = new DrawingBitmap(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, true, 0x00);
			
		}
		
		// animate an explosion
		override public function update(elapsed:Number):void {
			
			const MAX_RADIUS:int = Main.SCREEN_HEIGHT / 50;
			
			if (explosionUp == true){
				if (explosionRadius < MAX_RADIUS)
					explosionRadius += 0.82;
				else
					explosionUp = false;
			}else {
				if (explosionRadius > 1)
					explosionRadius -= 0.605;
				else
					_explosionFinished = true;
			}
			
			DrawingBitmap(texture).circle(explosionPosition.x, explosionPosition.y, explosionRadius, explosionUp ? EXPLOSION_COLOUR : 0x00);
  
		}
		
		// draw a random sky line
		public function buildSkyline():void {
			
			var currentBuildingColour:uint;
			var currentBuildingHeight:int = 0;
			var currentBuildingWidth:int = 0;
			var drawingXLocation:int = 2;
			var horizonLine:int = Main.SCREEN_HEIGHT - 15;
			var currentWindowColour:uint;
			var currentHeightBase:int
			
			var slopeState:int = int(Math.random() * 6);
			
			buildingCoordinates = new Array();
			
			switch (slopeState) {
				
				case 0: 
					//Upward slopeState
					currentHeightBase = 15;                 	
					break;
				case 1: 
					//Downward slopeState
					currentHeightBase = 130;                	
					break;
				case 2:
				case 3:
				case 4: 
					//"V" slopeState - most common.  We allow 3 cases to fall here to increase the chances
					//we have a V slope
					currentHeightBase = 15;            	 	
					break;
				case 5: 
					//Inverted "V" slopeState
					currentHeightBase = 130;
					break;
			}
			
			while(drawingXLocation <= Main.SCREEN_WIDTH - HEIGHT_TREND){
	
				switch(slopeState) {
					
					case 0:
						// This is an upward slope.  Gently increase the base height for this next building	
						currentHeightBase = currentHeightBase + HEIGHT_TREND;
						break;
						
					case 1:
						//This is a downward slope so gently decrease the base height
						currentHeightBase = currentHeightBase - HEIGHT_TREND;
						break;
						
					case 2:
					case 3:
					case 4:
						//Which side of the screen are we on?
						if(drawingXLocation > (Main.SCREEN_WIDTH / 2)){
							//West side of the screen.  Aggressively change the slope downward
							currentHeightBase = currentHeightBase - 2 * HEIGHT_TREND;
						}else{
							//East side of the screen.  Aggressively change the slope upward
							currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						}
						break;
					case 5:
						//Which side of the screen are we on?
						if(drawingXLocation > Main.SCREEN_WIDTH / 2){
							//West side.  Aggressively change the slope upward.
							currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						}else{
							//East side.  Aggressively bring the base height down on this iteration.
							currentHeightBase = currentHeightBase - 2 * HEIGHT_TREND;
						}
						break;
				}
				
				currentBuildingWidth = int(Math.random() * (WIDTH_AGGREGATE + 1)) + WIDTH_TREND;
				
				if (drawingXLocation + currentBuildingWidth > Main.SCREEN_WIDTH)
					currentBuildingWidth = Main.SCREEN_WIDTH - drawingXLocation - BUILDING_SEPARATION;
				
				if ((Main.SCREEN_WIDTH - currentBuildingWidth - drawingXLocation) < WIDTH_TREND)
					currentBuildingWidth += Main.SCREEN_WIDTH - currentBuildingWidth - drawingXLocation;						
					
				currentBuildingHeight = int(Math.random() * (HEIGHT_AGGREGATE + 1)) + currentHeightBase;
				  
				if (currentBuildingHeight < HEIGHT_TREND)
					currentBuildingHeight = HEIGHT_TREND + BUILDING_MINIMUM_HEIGHT + int(Math.random() * (HEIGHT_AGGREGATE + 1));	
				
				if (horizonLine - currentBuildingHeight <= UPPER_DRAWING_LIMIT)
					currentBuildingHeight = horizonLine - UPPER_DRAWING_LIMIT - int(Math.random() * (HEIGHT_AGGREGATE + 1));	
								
				buildingCoordinates.push([drawingXLocation, horizonLine - currentBuildingHeight]);								
				
				currentBuildingColour = int(Math.random() * 3);

				switch(currentBuildingColour){
					case 0:
						currentBuildingColour = BUILDING_RED;
						break;
					case 1:
						currentBuildingColour = BUILDING_GRAY;
						break;
					case 2:
						currentBuildingColour = BUILDING_GREEN;
						break;
				}
				
				texture.fillRect(new Rectangle(drawingXLocation - 1, (horizonLine + 1) - currentBuildingHeight, currentBuildingWidth, currentBuildingHeight), currentBuildingColour);
				
				var windowDrawingXLocation:int = drawingXLocation + 3;
				
				while(windowDrawingXLocation < drawingXLocation + currentBuildingWidth - 5){	
		
					for(var topToWindowDistance:int = currentBuildingHeight - 3; topToWindowDistance >= 10; topToWindowDistance -= WINDOW_HEIGHT_SEPARATION){
						
						if(int(Math.random() * 3) <= 1){
							currentWindowColour = LIT_WINDOW_COLOUR;					
						}else{
							currentWindowColour = UNLIT_WINDOW_COLOUR;
						}
						texture.fillRect(new Rectangle(windowDrawingXLocation, horizonLine - topToWindowDistance, WINDOW_WIDTH, WINDOW_HEIGHT), currentWindowColour);
					}
					windowDrawingXLocation = windowDrawingXLocation + WINDOW_WIDTH_SEPARATION;
				} 
				drawingXLocation += currentBuildingWidth + BUILDING_SEPARATION;
			}
		
			setWindSpeed();
			drawWindLine();
		}
		
		// put the gorillas on either the second or third building from either end
		public function placeGorillas(gorilla1:Gorilla, gorilla2:Gorilla):void {

			const xAdj:int = 15;
			const yAdj:int = 29;

			for (var i:int = 1; i <= 2; i++){

				if (i == 1)
					var bNum:int = int(Math.random() * 2) + 1;
				else
					bNum = buildingCoordinates.length - 1 - (int(Math.random() * 2) + 1);
					
				var bWidth:int = buildingCoordinates[bNum + 1][0] - buildingCoordinates[bNum][0];
				
				if (i == 1){
					gorilla1.x = buildingCoordinates[bNum][0] + bWidth / 2 - xAdj;
					gorilla1.y = buildingCoordinates[bNum][1] - yAdj;
				}else{
					gorilla2.x = buildingCoordinates[bNum][0] + bWidth / 2 - xAdj;
					gorilla2.y = buildingCoordinates[bNum][1] - yAdj;
				}

			}
			
		}
		
		// explode a piece of the cityscape
		public function createExplosion(x:int, y:int):void {

			explosionUp = true;
			_explosionFinished = false;
			explosionRadius = 1;
			explosionPosition = new Point(x, y);
			
		}
		
		// decide a random wind speed/direction for each cityscape
		private function setWindSpeed():void {
			
			wind = int(Math.random() * 11) - 5;
			
			if (int(Math.random() * 3) == 2) {
				if (wind > 0)
					wind += int(Math.random() * 11);
				else
					wind -= int(Math.random() * 11);
			}
			
		}
		
		// draw a line along the bottom of the screen relative to the wind's strength
		private function drawWindLine():void {
			
			if (wind == 0)
				return;
			
			var windLine:int = wind * 3 * (Main.SCREEN_WIDTH / 320);
		
			if (wind > 0) {
				for (var px:int = Main.SCREEN_WIDTH / 2; px <= (Main.SCREEN_WIDTH / 2) + windLine; px++)
					texture.setPixel32(px, Main.SCREEN_HEIGHT - 5, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine - 1, Main.SCREEN_HEIGHT - 6, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine - 2, Main.SCREEN_HEIGHT - 7, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine - 1, Main.SCREEN_HEIGHT - 4, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine - 2, Main.SCREEN_HEIGHT - 3, 0xFFFF0052);
			}else {
				for (px = Main.SCREEN_WIDTH / 2; px >= (Main.SCREEN_WIDTH / 2) + windLine; px--)
					texture.setPixel32(px, Main.SCREEN_HEIGHT - 5, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine + 1, Main.SCREEN_HEIGHT - 6, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine + 2, Main.SCREEN_HEIGHT - 7, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine + 1, Main.SCREEN_HEIGHT - 4, 0xFFFF0052);
				texture.setPixel32(Main.SCREEN_WIDTH / 2 + windLine + 2, Main.SCREEN_HEIGHT - 3, 0xFFFF0052);
			}
			
		}
		
	}

}