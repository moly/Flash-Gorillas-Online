﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace ServersideGameCode{

    class Cityscape{
		
        // screen width and height
        public const int SCREEN_WIDTH = 640;
        public const int SCREEN_HEIGHT = 350;

		// colours	
		private const uint BUILDING_RED = 0xFFA80000;
		private const uint BUILDING_GRAY = 0xFFA8A8A8;	
		private const uint BUILDING_GREEN = 0xFF00A8A8;	
		private const uint LIT_WINDOW_COLOUR = 0xFFFCFC54;
		private const uint UNLIT_WINDOW_COLOUR = 0xFF545454;
		
		// measurment Constants
		private const int BUILDING_SEPARATION = 1;
		private const int UPPER_DRAWING_LIMIT = 65;
		private const int WIDTH_AGGREGATE = 70;
		private const int HEIGHT_AGGREGATE = 70;
		private const int WINDOW_WIDTH = 4;
		private const int WINDOW_HEIGHT = 7;
		
		// all new heights generated will increase or decrease by this amount
		private const int HEIGHT_TREND = 18;
		
		// all new widths generated will increase or decrease by this amount
		private const int WIDTH_TREND = 32;
		
		private const int WINDOW_HEIGHT_SEPARATION = 15;
		private const int WINDOW_WIDTH_SEPARATION = 10;
		private const int BUILDING_MINIMUM_HEIGHT = 25;
		
        // positions and widths for buildings
		private List<int> buildingCoordinates;
		
		// the level's wind speed
		private int wind;
		public int WindSpeed {
            get {return wind;}
		}

        // an image to draw to
        public Bitmap texture;

        // a random number generator
        private Random random;
		
		public Cityscape() {
            random = new Random();
		}
		
		public void Draw() {
			
		}
		
		// draw a random sky line
		public void BuildSkyline() {
			
		    uint currentBuildingColour;
			int currentBuildingHeight = 0;
			int currentBuildingWidth = 0;
			int drawingXLocation = 2;
			int horizonLine = 350 - 15;
			uint currentWindowColour;
			int currentHeightBase = 0;
			
			int slopeState = random.Next(6);
			
			buildingCoordinates = new List<int>();
			
			texture = new Bitmap(640, 350);
            Graphics g = Graphics.FromImage(texture);
			
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
			
			while(drawingXLocation <= SCREEN_WIDTH - HEIGHT_TREND){
	
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
						if(drawingXLocation > (SCREEN_WIDTH / 2)){
							//West side of the screen.  Aggressively change the slope downward
							currentHeightBase = currentHeightBase - 2 * HEIGHT_TREND;
						}else{
							//East side of the screen.  Aggressively change the slope upward
							currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						}
						break;
					case 5:
						//Which side of the screen are we on?
						if(drawingXLocation > SCREEN_WIDTH / 2){
							//West side.  Aggressively change the slope upward.
							currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						}else{
							//East side.  Aggressively bring the base height down on this iteration.
							currentHeightBase = currentHeightBase - 2 * HEIGHT_TREND;
						}
						break;
				}
				
				currentBuildingWidth = random.Next(WIDTH_TREND, WIDTH_TREND + WIDTH_AGGREGATE + 1); //int(Math.random() * (WIDTH_AGGREGATE + 1)) + WIDTH_TREND;
				
				if (drawingXLocation + currentBuildingWidth > SCREEN_WIDTH)
					currentBuildingWidth = SCREEN_WIDTH - drawingXLocation - BUILDING_SEPARATION;
				
				if ((SCREEN_WIDTH - currentBuildingWidth - drawingXLocation) < WIDTH_TREND)
					currentBuildingWidth += SCREEN_WIDTH - currentBuildingWidth - drawingXLocation;						
					
				currentBuildingHeight = random.Next(currentHeightBase, currentHeightBase + HEIGHT_AGGREGATE + 1); //int(Math.random() * (HEIGHT_AGGREGATE + 1)) + currentHeightBase;
				  
				if (currentBuildingHeight < HEIGHT_TREND)
					currentBuildingHeight = HEIGHT_TREND + BUILDING_MINIMUM_HEIGHT + random.Next(HEIGHT_AGGREGATE + 1); //int(Math.random() * (HEIGHT_AGGREGATE + 1));	
				
				if (horizonLine - currentBuildingHeight <= UPPER_DRAWING_LIMIT)
					currentBuildingHeight = horizonLine - UPPER_DRAWING_LIMIT - random.Next(HEIGHT_AGGREGATE + 1); //int(Math.random() * (HEIGHT_AGGREGATE + 1));	
								
				//buildingCoordinates.Add([drawingXLocation, horizonLine - currentBuildingHeight]);								
			
				currentBuildingColour = (uint)random.Next(3); //int(Math.random() * 3);

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
				
				g.FillRectangle(new SolidBrush(Color.FromArgb((int)currentBuildingColour)), new Rectangle(drawingXLocation - 1, (horizonLine + 1) - currentBuildingHeight, currentBuildingWidth, currentBuildingHeight));
				
				int windowDrawingXLocation = drawingXLocation + 3;
				
				while(windowDrawingXLocation < drawingXLocation + currentBuildingWidth - 5){	
		
					for(int topToWindowDistance = currentBuildingHeight - 3; topToWindowDistance >= 10; topToWindowDistance -= WINDOW_HEIGHT_SEPARATION){
						
						if(random.Next(3) <= 1){
							currentWindowColour = LIT_WINDOW_COLOUR;					
						}else{
							currentWindowColour = UNLIT_WINDOW_COLOUR;
						}
						g.FillRectangle(new SolidBrush(Color.FromArgb((int)currentWindowColour)), new Rectangle(windowDrawingXLocation, horizonLine - topToWindowDistance, WINDOW_WIDTH, WINDOW_HEIGHT));
					}
					windowDrawingXLocation = windowDrawingXLocation + WINDOW_WIDTH_SEPARATION;
				} 
				drawingXLocation += currentBuildingWidth + BUILDING_SEPARATION;
			}
		
			//setWindSpeed();
			//drawWindLine();
		}
		/*
		// put the gorillas on either the second or third building from either end
		public function placeGorillas(gorilla1:Gorilla, gorilla2:Gorilla):void {

			int xAdj = 15;
			int yAdj = 29;

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
		public function createSmallExplosion(x:int, y:int):void {
			smallExplosion.create(x, y);
		}
		
		// explode a really big piece of the cityscape
		public function createBigExplosion(x:int, y:int):void {
			bigExplosion.create(x, y);
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

}*/
    }
}
