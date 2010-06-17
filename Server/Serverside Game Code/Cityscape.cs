using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace ServersideGameCode
{
    class Cityscape
    {	
        // screen width and height
        public const int SCREEN_WIDTH = 640;
        public const int SCREEN_HEIGHT = 350;

		// colours	
		private const uint BUILDING_RED = 0xFFA80000;
		private const uint BUILDING_GRAY = 0xFFA8A8A8;	
		private const uint BUILDING_GREEN = 0xFF00A8A8;	
		private const uint LIT_WINDOW_COLOUR = 0xFFFCFC54;
		private const uint UNLIT_WINDOW_COLOUR = 0xFF545454;
        private const uint WIND_LINE_COLOUR = 0xFFFF0052;
		
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

        // an image to draw to
        private Bitmap texture;

        // a random number generator
        private Random random;

        private int currentCityscape;

        private List<List<List<int>>> buildingCoordinates;
        public List<List<List<int>>> BuildingCoordinates
        {
            get { return buildingCoordinates; }
        }

        private List<int> windSpeeds;
        public int WindSpeed 
        {
            get { return windSpeeds[currentCityscape]; }
        }
        public List<int> AllWindSpeeds
        {
            get { return windSpeeds; }
        }

        private List<Point> player1Positions;
        public Point Player1Position
        {
            get { return player1Positions[currentCityscape]; }
        }
        public List<Point> AllPlayer1Positions
        {
            get { return player1Positions; }
        }

        private List<Point> player2Positions;
        public Point Player2Position
        {
            get { return player2Positions[currentCityscape]; }
        }
        public List<Point> AllPlayer2Positions
        {
            get { return player2Positions; }
        }

		public Cityscape()
        {
            random = new Random();
            buildingCoordinates = new List<List<List<int>>>();
            windSpeeds = new List<int>();
            player1Positions = new List<Point>();
            player2Positions = new List<Point>();
            currentCityscape = 0;
		}
		
		public void Draw(Graphics g) 
        {
            g.DrawImage(texture, 0, 0);
		}

        // move to the next cityscape
        public void NextCityscape()
        {
            currentCityscape++;
            SetCityscape(currentCityscape);
        }
		
		// generate random sky lines
		public void BuildSkylines(int numberOfSkylines) 
        {	
            for(int i = 0; i < numberOfSkylines; ++i)
            {    
			    int currentBuildingHeight = 0;
			    int currentBuildingWidth = 0;
			    int drawingXLocation = 2;
                int horizonLine = 350 - 15;
			    int currentHeightBase = 0;
    			
			    List<List<int>> buildingCoordinates = new List<List<int>>();

                int slopeState = random.Next(6);
    			
			    switch (slopeState)
                {	
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
    			
			    while(drawingXLocation <= SCREEN_WIDTH - HEIGHT_TREND)
                {
				    switch(slopeState)
                    {    					
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
						    if(drawingXLocation > (SCREEN_WIDTH / 2))
                            {
							    //West side of the screen.  Aggressively change the slope downward
							    currentHeightBase = currentHeightBase - 2 * HEIGHT_TREND;
						    }
                            else
                            {
							    //East side of the screen.  Aggressively change the slope upward
							    currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						    }
						    break;
					    case 5:
						    //Which side of the screen are we on?
						    if(drawingXLocation > SCREEN_WIDTH / 2){
							    //West side.  Aggressively change the slope upward.
							    currentHeightBase = currentHeightBase + 2 * HEIGHT_TREND;
						    }
                            else
                            {
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
    				
                    List<int> xAndHeight = new List<int>();
                    xAndHeight.Add(drawingXLocation);
                    xAndHeight.Add(horizonLine - currentBuildingHeight);
				    buildingCoordinates.Add(xAndHeight);								
    				
				    drawingXLocation += currentBuildingWidth + BUILDING_SEPARATION;
			    }

                this.buildingCoordinates.Add(buildingCoordinates);
			    this.windSpeeds.Add(SetWindSpeed());
                this.player1Positions.Add(PlaceGorilla(1, buildingCoordinates));
                this.player2Positions.Add(PlaceGorilla(2, buildingCoordinates));
            }
		}
		
        // set the current cityscape
        public void SetCityscape(int cityscapeNumber)
        {	
			uint currentBuildingColour;
			int currentBuildingHeight = 0;
			int currentBuildingWidth = 0;
			int drawingXLocation = 0;
			int horizonLine = SCREEN_HEIGHT - 15;
			uint currentWindowColour;
			
            texture = new Bitmap(640, 350);
            Graphics g = Graphics.FromImage(texture);

            currentCityscape = cityscapeNumber;

			for(int i = 0; i < buildingCoordinates[cityscapeNumber].Count; ++i)
            {	
				currentBuildingColour = (uint)random.Next(3);

				switch(currentBuildingColour)
                {
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
				
				drawingXLocation = buildingCoordinates[cityscapeNumber][i][0];
				currentBuildingHeight = horizonLine - buildingCoordinates[cityscapeNumber][i][1];
				
				if(i != buildingCoordinates[cityscapeNumber].Count - 1){
					currentBuildingWidth = buildingCoordinates[cityscapeNumber][i + 1][0] - drawingXLocation - BUILDING_SEPARATION;
				}
                else
                {
					currentBuildingWidth = SCREEN_WIDTH - drawingXLocation - BUILDING_SEPARATION;
				}
				
				g.FillRectangle(new SolidBrush(Color.FromArgb((int)currentBuildingColour)), drawingXLocation - 1, (horizonLine + 1) - currentBuildingHeight, currentBuildingWidth, currentBuildingHeight);
				
				int windowDrawingXLocation = drawingXLocation + 3;
				
				while(windowDrawingXLocation < drawingXLocation + currentBuildingWidth - 5)
                {	
					for(int topToWindowDistance = currentBuildingHeight - 3; topToWindowDistance >= 10; topToWindowDistance -= WINDOW_HEIGHT_SEPARATION){
						
						if(random.Next(3) <= 1)
                        {
							currentWindowColour = LIT_WINDOW_COLOUR;					
						}
                        else
                        {
							currentWindowColour = UNLIT_WINDOW_COLOUR;
						}
						g.FillRectangle(new SolidBrush(Color.FromArgb((int)currentWindowColour)), windowDrawingXLocation, horizonLine - topToWindowDistance, WINDOW_WIDTH, WINDOW_HEIGHT);
					}
					windowDrawingXLocation = windowDrawingXLocation + WINDOW_WIDTH_SEPARATION;
				} 
				drawingXLocation += currentBuildingWidth + BUILDING_SEPARATION;
				
			}
		
			DrawWindLine();
		}

		// put the gorillas on either the second or third building from either end
		private Point PlaceGorilla(int playerNumber, List<List<int>> buildingCoordinates)
        {
			int xAdj = 15;
			int yAdj = 29;
            int bNum = 0;

			if (playerNumber == 1)
				bNum = random.Next(1, 3);
			else
				bNum = buildingCoordinates.Count - 1 - random.Next(1, 3);
					
			int bWidth = buildingCoordinates[bNum + 1][0] - buildingCoordinates[bNum][0];

            Point position = new Point(buildingCoordinates[bNum][0] + bWidth / 2 - xAdj, buildingCoordinates[bNum][1] - yAdj);

            return position;
		}

        // Check for a collision
        public bool IsColliding(Point point)
        {
            if (point.Y < 0 || point.Y >= SCREEN_HEIGHT || point.X < 0 || point.X >= SCREEN_WIDTH)
                return false;
            return texture.GetPixel(point.X, point.Y).A != 0;
        }
		
		// explode a piece of the cityscape
		public void CreateSmallExplosion(int x, int y)
        {
            for (int i = 0; i <= 7; ++i)
                DrawCircle(x, y, i, Color.Transparent);
		}
		
        /*
		// explode a really big piece of the cityscape
		public function createBigExplosion(x:int, y:int):void {
			bigExplosion.create(x, y);
		}
        
		*/

		// decide a random wind speed/direction for each cityscape
		private int SetWindSpeed() 
        {	
			int wind = random.Next(-5, 6); //int(Math.random() * 11) - 5;
			
			if (random.Next(3) == 2) 
            {
				if (wind > 0)
					wind += random.Next(11);
				else
					wind -= random.Next(11);
			}

            return wind;
		}

		// draw a line along the bottom of the screen relative to the wind's strength
		private void DrawWindLine()
        {
            int wind = windSpeeds[currentCityscape];

			if (wind == 0)
				return;
			
			int windLine = wind * 3 * (SCREEN_WIDTH / 320);
		
			if (wind > 0)
            {
				for (int px = SCREEN_WIDTH / 2; px <= (SCREEN_WIDTH / 2) + windLine; px++)
					texture.SetPixel(px, SCREEN_HEIGHT - 5, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine - 1, SCREEN_HEIGHT - 6, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine - 2, SCREEN_HEIGHT - 7, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine - 1, SCREEN_HEIGHT - 4, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine - 2, SCREEN_HEIGHT - 3, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
			}
            else 
            {
				for (int px = SCREEN_WIDTH / 2; px >= (SCREEN_WIDTH / 2) + windLine; px--)
                    texture.SetPixel(px, SCREEN_HEIGHT - 5, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine + 1, SCREEN_HEIGHT - 6, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine + 2, SCREEN_HEIGHT - 7, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine + 1, SCREEN_HEIGHT - 4, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
                texture.SetPixel(SCREEN_WIDTH / 2 + windLine + 2, SCREEN_HEIGHT - 3, Color.FromArgb(unchecked((int)WIND_LINE_COLOUR)));
			}
			
		}

        // Draw a circle on the texture bitmap
        private void DrawCircle(int x, int y, int radius, Color colour)
        {
            int px, py, xRadius, yRadius, xChange, yChange;
			int ellipseError, twoASquare, twoBSquare, stoppingX, stoppingY;
			
			xRadius = radius;
			yRadius = (int)(radius * 0.8);
			
			if (xRadius <= 0) return;
			
			twoASquare = 2 * xRadius * xRadius;
			twoBSquare = 2 * yRadius * yRadius;
			px = xRadius;
			py = 0;
			xChange = yRadius * yRadius * (1 - 2 * xRadius);
			yChange = xRadius * xRadius;
			ellipseError = 0;
			stoppingX = twoBSquare * xRadius;
			stoppingY = 0;
			
			while (stoppingX >= stoppingY)
            {
				Plot4EllipsePoints(x, y, px, py, colour);
				py++;
				stoppingY += twoASquare;
				ellipseError += yChange;
				yChange += twoASquare;
				if ((2 * ellipseError + xChange) > 0)
                {
					px--;
					stoppingX -= twoBSquare;
					ellipseError += xChange;
					xChange += twoBSquare;
				}
			}
			
			px = 0;
			py = yRadius;
			xChange = yRadius * yRadius;
			yChange = xRadius * xRadius * (1 - 2 * yRadius);
			ellipseError = 0;
			stoppingX = 0;
			stoppingY = twoASquare * yRadius;
			
			while (stoppingX <= stoppingY)
            {	
				Plot4EllipsePoints(x, y, px, py, colour);
				px++;
				stoppingX += twoBSquare;
				ellipseError += xChange;
				xChange += twoBSquare;
				if ((2 * ellipseError + yChange) > 0)
                {
					py--;
					stoppingY -= twoASquare;
					ellipseError += yChange;
					yChange += twoASquare;
				}
			}
		}
		
		private void Plot4EllipsePoints(int x, int y, int px, int py, Color colour)
        {	
			texture.SetPixel(x + px, y + py, colour);
			texture.SetPixel(x - px, y + py, colour);
			texture.SetPixel(x - px, y - py, colour);
			texture.SetPixel(x + px, y - py, colour);	
		}
    }
}
