using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace ServersideGameCode {

	public class GameCode : Game<Player> {

        // A bitmap to draw to, used for debugging
        private Bitmap canvas;

        // The players in the game
        private Player player1;
        private Player player2;

        // Which players turn it is
        private Player playerTurn;

        // Which player won
        private Player winningPlayer;

        // The game levels
        private Cityscape cityscape;

        // A throwable banana
        private Banana banana;

        // Constants
        private const float GRAVITY = 9.8f;
        private const int PLAY_TO_POINTS = 3;

        // Time limit for player input
        private const int TURN_TIME_LIMIT = 15;
        private int currentTimer;

        // Has the game finished
        private bool gameFinished;

		public override void GameStarted()
        {
			Console.WriteLine("Game is started: " + RoomId);

            canvas = new Bitmap(640,350);

            // Set up all our cityscapes
            cityscape = new Cityscape();
            cityscape.BuildSkylines(3);
            cityscape.SetCityscape(0);

            banana = new Banana();

            gameFinished = false;

            PreloadPlayerObjects = true;
		}

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() 
        {
			Console.WriteLine("RoomId: " + RoomId);
		}

		// This method is called whenever a player joins the game
		public override void UserJoined(Player player) 
        {

            if (player1 == null)
            {
                player1 = player;
                player1.Name = player.JoinData["name"];
            } 
            else
            {
                player2 = player;
                player2.Name = player.JoinData["name"];
            }
            
            // Start the game when we have to players ready
            if (PlayerCount == 2)
                StartGame();
		}

        // Start a new game
        private void StartGame()
        {

            playerTurn = player1;
            PlaceGorillas();

            byte[] buildingCoordinates = BuildingCoordinatesToByteArray(cityscape.BuildingCoordinates);
            byte[] player1Positions = PlayerPositionsToByteArray(cityscape.AllPlayer1Positions);
            byte[] player2Positions = PlayerPositionsToByteArray(cityscape.AllPlayer2Positions);
            byte[] windSpeeds = WindSpeedsToByteArray(cityscape.AllWindSpeeds);

            player1.Send("start", buildingCoordinates, player1Positions, player2Positions, windSpeeds, player2.Name);
            player2.Send("start", buildingCoordinates, player1Positions, player2Positions, windSpeeds, player1.Name);

            // Set up a time limit for players to take a shot
            currentTimer = TURN_TIME_LIMIT;
            AddTimer(delegate
            {
                if (currentTimer == 5000)
                    return;

                currentTimer--;
                if (currentTimer <= 0)
                {
                    Broadcast("timeOut");
                    playerTurn = playerTurn == player1 ? player2 : player1;
                    currentTimer = TURN_TIME_LIMIT;
                }
            }, 1000);

            Visible = false;
            RefreshDebugView();

        }

		// This method is called when a player sends a message into the server code
        public override void GotMessage(Player player, Message message)
        {
            // Don't respond to anything if the game has finished
            if (gameFinished)
                return;

            switch (message.Type)
            {
                // A player has sent an angle and a velocity for their turn
                case "throw":
                    
                    // If it's not actually their turn, do nothing
                    if (player != playerTurn)
                        return;

                    // Get the angle and velocity from the message
                    int angle = message.GetInt(0);
                    int velocity = message.GetInt(1);

                    // Send all players the angle and velocity of the received shot 
                    Broadcast("throw", angle, velocity);
                    
                    // Work out ourselves where the banana will land
                    Point startPoint = new Point();
                    if (player == player1)
                    {
						startPoint = new Point(player1.X, player1.Y - 7);
					}
                    else if(player == player2)
                    {
						startPoint = new Point(player2.X + 25, player2.Y - 7);
					}

                    int result = banana.Launch(angle, velocity, GRAVITY, cityscape.WindSpeed, startPoint, cityscape, player1, player2);

                    // Increase score appropriately
                    if (result == Banana.HIT_GORILLA_ONE)
                    {
                        player2.Score++;
                    }
                    
                    if (result == Banana.HIT_GORILLA_TWO)
                    {
                        player1.Score++;
                    }

                    currentTimer = 5000;

                    if (player1.Score + player2.Score >= PLAY_TO_POINTS)
                    {
                        EndGame();
                    }
                    else if(result == Banana.HIT_GORILLA_ONE || result == Banana.HIT_GORILLA_TWO)
                    {
                        cityscape.NextCityscape();
                        PlaceGorillas();
                    }

                    ScheduleCallback(delegate
                    {
                        // Next players turn
                        playerTurn = playerTurn == player1 ? player2 : player1;
                        currentTimer = TURN_TIME_LIMIT;
                    }, (int)(banana.Time * 1000));// must add explosion/dance time

                    RefreshDebugView();

                    break;
            }
        }

        // Game has finished
        private void EndGame()
        {
            gameFinished = true;
            winningPlayer = player1.Score > player2.Score ? player1 : player2;

            // Calculate experince and level gains
            foreach (Player player in Players)
            {
                int level = player.PlayerObject.GetInt("level", 0);
                int xp = player.PlayerObject.GetInt("xp", 0);

                xp += (player == winningPlayer ? 100 : 0) + (player.Score * 15);
                while (true)
                {
                    if (xp >= 100 + (level * 100))
                        level++;
                    else
                        break;
                }

                if(!player.PlayerObject.Contains("name"))
                    player.PlayerObject.Set("name", player.Name);
                player.PlayerObject.Set("level", level);
                player.PlayerObject.Set("xp", xp);
                player.PlayerObject.Save();
            }
        }

        // Prevent more than two people joining a game
        public override bool AllowUserJoin(Player player)
        {
            return (player1 == null || player2 == null);
        }

        // This method is called when a player leaves the game
        public override void UserLeft(Player player)
        {
            if(!gameFinished)
                Broadcast("userLeft", player.Id);
        }

        // Position players correctly
        private void PlaceGorillas()
        {
            player1.X = cityscape.Player1Position.X;
            player1.Y = cityscape.Player1Position.Y;
            player2.X = cityscape.Player2Position.X;
            player2.Y = cityscape.Player2Position.Y;
        }

		// This method gets called whenever triggered by the RefreshDebugView() method.
		public override Image GenerateDebugImage()
        {
            Graphics g = Graphics.FromImage(canvas);
                
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFF0000AD))), new Rectangle(0, 0, canvas.Width, canvas.Height));
                
            cityscape.Draw(g);

            if (player1 != null)
                player1.Draw(g);

            if (player2 != null)
                player2.Draw(g);

            banana.Draw(g);

			return canvas;
		}

        // Convert all building coordinates to a byte array
        private byte[] BuildingCoordinatesToByteArray(List<List<List<int>>> list)
        {
            int bytes = list.Count * 4;
            for (int i = 0; i < list.Count; ++i)
                bytes += list[i].Count * 8;

            byte[] byteArray = new byte[bytes];
            int lastCount = 0;
            for (int i = 0; i < list.Count; ++i)
            {
                byteArray[lastCount] = (byte)(list[i].Count * 8 >> 24);
                byteArray[lastCount + 1] = (byte)(list[i].Count * 8 >> 16);
                byteArray[lastCount + 2] = (byte)(list[i].Count * 8 >> 8);
                byteArray[lastCount + 3] = (byte)(list[i].Count * 8);
                lastCount += 4;
                for (int j = 0; j < list[i].Count; ++j)
                {
                    byteArray[lastCount + (j * 8)] = (byte)(list[i][j][0] >> 24);
                    byteArray[lastCount + (j * 8) + 1] = (byte)(list[i][j][0] >> 16);
                    byteArray[lastCount + (j * 8) + 2] = (byte)(list[i][j][0] >> 8);
                    byteArray[lastCount + (j * 8) + 3] = (byte)list[i][j][0];
                    byteArray[lastCount + (j * 8) + 4] = (byte)(list[i][j][1] >> 24);
                    byteArray[lastCount + (j * 8) + 5] = (byte)(list[i][j][1] >> 16);
                    byteArray[lastCount + (j * 8) + 6] = (byte)(list[i][j][1] >> 8);
                    byteArray[lastCount + (j * 8) + 7] = (byte)list[i][j][1];
                }
                lastCount += list[i].Count * 8;
            }
            
            return byteArray;
        }

        // Convert player positions to a byte array
        private byte[] PlayerPositionsToByteArray(List<Point> list)
        {
            byte[] byteArray = new byte[list.Count * 8];
            for (int i = 0; i < list.Count; ++i)
            {
                byteArray[i * 8] = (byte)(list[i].X >> 24);
                byteArray[(i * 8) + 1] = (byte)(list[i].X >> 16);
                byteArray[(i * 8) + 2] = (byte)(list[i].X >> 8);
                byteArray[(i * 8) + 3] = (byte)list[i].X;
                byteArray[(i * 8) + 4] = (byte)(list[i].Y >> 24);
                byteArray[(i * 8) + 5] = (byte)(list[i].Y >> 16);
                byteArray[(i * 8) + 6] = (byte)(list[i].Y >> 8);
                byteArray[(i * 8) + 7] = (byte)list[i].Y;
            }

            return byteArray;
        }

        // Convert windspeeds to byte array
        private byte[] WindSpeedsToByteArray(List<int> list)
        {
            byte[] byteArray = new byte[list.Count * 4];
            for (int i = 0; i < list.Count; ++i)
            {
                byteArray[i * 4] = (byte)(list[i] >> 24);
                byteArray[(i * 4) + 1] = (byte)(list[i] >> 16);
                byteArray[(i * 4) + 2] = (byte)(list[i] >> 8);
                byteArray[(i * 4) + 3] = (byte)list[i];
            }

            return byteArray;
        }

		// During development, it's very usefull to be able to cause certain events
		// to occur in your serverside code. If you create a public method with no
		// arguments and add a [DebugAction] attribute like we've down below, a button
		// will be added to the development server. 
		// Whenever you click the button, your code will run.
		//[DebugAction("Play", DebugAction.Icon.Play)]
		//public void PlayNow() {
		//	Console.WriteLine("The play button was clicked!");
		//}

		// If you use the [DebugAction] attribute on a method with
		// two int arguments, the action will be triggered via the
		// debug view when you click the debug view on a running game.
		//[DebugAction("Set Debug Point", DebugAction.Icon.Green)]
		//public void SetDebugPoint(int x, int y) {
		//	debugPoint = new Point(x,y);
		//}
	}
}