package dee.moly.gameobjects {
	
	import dee.moly.textures.DrawingBitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	/**
	 * generates a random skyline
	 * @author moly, borrowed heavily from Chris King
	 */
	
	public class Cityscape extends GameObject {
		
		// store all the cityscapes
		private var buildingCoordinates:Array;
		private var windSpeeds:Array;
		private var player1Positions:Array;
		private var player2Positions:Array;
		private var currentCityscape:int;
		
		// colours	
		private static const BUILDING_RED:uint = 0xFFA80000;
		private static const BUILDING_GRAY:uint	= 0xFFA8A8A8;	
		private static const BUILDING_GREEN:uint = 0xFF00A8A8;	
		private static const LIT_WINDOW_COLOUR:uint = 0xFFFCFC54;
		private static const UNLIT_WINDOW_COLOUR:uint = 0xFF545454;
		
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
		
		private var smallExplosion:SmallExplosion;
		private var bigExplosion:BigExplosion;
		public function get explosionFinished():Boolean {
			return smallExplosion.finished && bigExplosion.finished;
		}
		
		public function get player1Position():Point {
			return player1Positions[currentCityscape];
		}
		
		public function get player2Position():Point {
			return player2Positions[currentCityscape];
		}
		
		public function get windSpeed():int {
			return windSpeeds[currentCityscape];
		}
		
		public function Cityscape(buildingCoordinates:ByteArray, player1Positions:ByteArray, player2Positions:ByteArray, windSpeeds:ByteArray) {
			
			position = new Point(0, 0);
			smallExplosion = new SmallExplosion();
			bigExplosion = new BigExplosion();
			this.buildingCoordinates = buildingCoordinatesToArray(buildingCoordinates);
			this.player1Positions = positionsToArray(player1Positions);
			this.player2Positions = positionsToArray(player2Positions);
			this.windSpeeds = windSpeedsToArray(windSpeeds);
			currentCityscape = -1;
		}
		
		override public function draw(canvas:BitmapData):void {
			
			smallExplosion.draw(texture);
			bigExplosion.draw(texture);
			super.draw(canvas);
		}
		
		// go to the next cityscape
		public function nextCityscape():void {
			
			currentCityscape++;
			setCityscape(currentCityscape);
		}
		
		// Set the current
		public function setCityscape(cityscapeNumber:int):void {
			
			currentCityscape = cityscapeNumber;
		
			var currentBuildingColour:uint;
			var currentBuildingHeight:int = 0;
			var currentBuildingWidth:int = 0;
			var drawingXLocation:int = 0;
			var horizonLine:int = Main.SCREEN_HEIGHT - 15;
			var currentWindowColour:uint;
			var currentHeightBase:int;
			
			texture = new DrawingBitmap(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, true, 0x00);
			
			buildingCoordinates[currentCityscape].position = 0;
			while (buildingCoordinates[currentCityscape].bytesAvailable) {
				
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
				
				drawingXLocation = buildingCoordinates[currentCityscape].readInt();
				currentBuildingHeight = horizonLine - buildingCoordinates[currentCityscape].readInt();
				
				if(buildingCoordinates[currentCityscape].bytesAvailable){
					currentBuildingWidth = buildingCoordinates[currentCityscape].readInt() - drawingXLocation - BUILDING_SEPARATION;
					buildingCoordinates[currentCityscape].position -= 4;
				}else {
					currentBuildingWidth = Main.SCREEN_WIDTH - drawingXLocation - BUILDING_SEPARATION;
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
			
			drawWindLine();
		}
		
		// explode a piece of the cityscape
		public function createSmallExplosion(x:int, y:int):void {
			smallExplosion.create(x, y);
		}
		
		// explode a really big piece of the cityscape
		public function createBigExplosion(x:int, y:int):void {
			bigExplosion.create(x, y);
		}
		
		// convert the buildingCoordinates bytearray to an array
		private function buildingCoordinatesToArray(byteArray:ByteArray):Array {
			
			var buildingCoordinates:Array = new Array();
			
			while (byteArray.bytesAvailable) {
				var length:int = byteArray.readInt();
				var array:ByteArray = new ByteArray();
				
				for (var i:int = 0; i < length; ++i)
					array.writeByte(byteArray.readByte());
				buildingCoordinates.push(array);
			}
			
			return buildingCoordinates;
		}
		
		// converts the playerPostions bytearray to an array of points
		private function positionsToArray(byteArray:ByteArray):Array {
			
			var positionsArray:Array = new Array();
			while (byteArray.bytesAvailable) {
				positionsArray.push(new Point(byteArray.readInt(), byteArray.readInt()));
			}
			
			return positionsArray;
		}
		
		// convert windSpeeds bytearray to an array if ints
		private function windSpeedsToArray(byteArray:ByteArray):Array {
			
			var windArray:Array = new Array();
			while (byteArray.bytesAvailable) {
				windArray.push(byteArray.readInt());
			}
			
			return windArray;
		}
		
		// draw a line along the bottom of the screen relative to the wind's strength
		private function drawWindLine():void {
			
			var wind:int = windSpeeds[currentCityscape];
			
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