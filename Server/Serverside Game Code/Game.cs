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

        // The game level
        private Cityscape cityscape;

        // A throwable banana
        private Banana banana;

        // Constants
        private const float GRAVITY = 9.8f;

		public override void GameStarted() {
			
			Console.WriteLine("Game is started: " + RoomId);

            canvas = new Bitmap(640,350);

            cityscape = new Cityscape();
            cityscape.BuildSkyline();

            banana = new Banana();

			// This is how you setup a timer
			AddTimer(delegate {
				// code here will code every 100th millisecond (ten times a second)
			}, 25);
			
			AddTimer(delegate {
				// This will cause the GenerateDebugImage() method to be called
				RefreshDebugView(); 
			}, 250);
		}

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() {
			Console.WriteLine("RoomId: " + RoomId);
		}

		// This method is called whenever a player joins the game
		public override void UserJoined(Player player) {

            if (player1 == null){
                player1 = player;
                cityscape.PlaceGorilla(player1, 1);
                player1.Name = player.JoinData["name"];
            } else {
                player2 = player;
                cityscape.PlaceGorilla(player2, 2);
                player2.Name = player.JoinData["name"];
            }
            
            if (PlayerCount == 2){
                playerTurn = player1;
                player1.Send("start", ListToByteArray(cityscape.BuildingCoordinates), cityscape.WindSpeed, player1.X, player1.Y, player2.X, player2.Y, player2.Name);
                player2.Send("start", ListToByteArray(cityscape.BuildingCoordinates), cityscape.WindSpeed, player1.X, player1.Y, player2.X, player2.Y, player1.Name);
            }
		}

        // Prevent more than two people joining a game
        public override bool AllowUserJoin(Player player){
            return (player1 == null || player2 == null);
        }

		// This method is called when a player leaves the game
		public override void UserLeft(Player player) {
			Broadcast("UserLeft", player.Id);
            (player == player1 ? player2 : player1).Disconnect();
		}

		// This method is called when a player sends a message into the server code
        public override void GotMessage(Player player, Message message){
            switch (message.Type){

                // A player has sent an angle and a velocity for their turn
                case "throw":
                    
                    // If it's not actually their turn, disregard
                    if (player != playerTurn)
                        return;

                    // Get the angle and velocity from the message
                    int angle = message.GetInt(0);
                    int velocity = message.GetInt(1);

                    // Send other player the angle and velocity of the shot 
                    (player == player1 ? player2 : player1).Send("throw", angle, velocity);
                    Console.WriteLine(player.Name + " angle: " + angle + " velocity: " + velocity);

                    // Work out ourselves where the banana will land
                    Point startPoint;
                    if (playerTurn == player1){
						startPoint = new Point(player1.X, player1.Y - 7);
					}else{
						startPoint = new Point(player2.X + 25, player2.Y - 7);
					}

                    int result = banana.Launch(angle, velocity, GRAVITY, cityscape.WindSpeed, startPoint, cityscape, player1, player2);
                    
                    // Increase score appropriately
                    if (result == Banana.HIT_GORILLA_ONE)
                        player2.Score++;

                    if (result == Banana.HIT_GORILLA_TWO)
                        player1.Score++;

                    // Next players turn
                    playerTurn = playerTurn == player1 ? player2 : player1;

                    break;
            }
        }

		// This method gets called whenever triggered by the RefreshDebugView() method.
		public override Image GenerateDebugImage() {

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

        // Convert a two dimensional list to a byte array
        private byte[] ListToByteArray(List<List<int>> list){
            byte[] byteArray = new byte[list.Count * 8];
            for (int i = 0; i < list.Count; ++i){
                byteArray[i * 8] = (byte)(list[i][0] >> 24);
                byteArray[(i * 8) + 1] = (byte)(list[i][0] >> 16);
                byteArray[(i * 8) + 2] = (byte)(list[i][0] >> 8);
                byteArray[(i * 8) + 3] = (byte)list[i][0];
                byteArray[(i * 8) + 4] = (byte)(list[i][1] >> 24);
                byteArray[(i * 8) + 5] = (byte)(list[i][1] >> 16);
                byteArray[(i * 8) + 6] = (byte)(list[i][1] >> 8);
                byteArray[(i * 8) + 7] = (byte)list[i][1];
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