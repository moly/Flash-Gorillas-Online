using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace ServersideGameCode {

	public class GameCode : Game<Gorilla> {

        // A bitmap to draw to, used for debugging
        private Bitmap canvas;

        // The players in the game
        private Gorilla player1;
        private Gorilla player2;

        // Which players turn it is
        private int playerTurn;

        // The game level
        private Cityscape cityscape;

		public override void GameStarted() {
			
			Console.WriteLine("Game is started: " + RoomId);

            canvas = new Bitmap(640,350);

            playerTurn = 1;

            cityscape = new Cityscape();
            cityscape.BuildSkyline();

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
		public override void UserJoined(Gorilla player) {

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
                player1.Send("start", ListToByteArray(cityscape.BuildingCoordinates), cityscape.WindSpeed, player1.X, player1.Y, player2.X, player2.Y, player2.Name);
                player2.Send("start", ListToByteArray(cityscape.BuildingCoordinates), cityscape.WindSpeed, player1.X, player1.Y, player2.X, player2.Y, player1.Name);
            }
		}

        // Prevent more than two people joining a game
        public override bool AllowUserJoin(Gorilla player){
            return (player1 == null || player2 == null);
        }

		// This method is called when a player leaves the game
		public override void UserLeft(Gorilla player) {
			Broadcast("UserLeft", player.Id);
		}

		// This method is called when a player sends a message into the server code
        public override void GotMessage(Gorilla player, Message message){
            switch (message.Type){
                case "shot":
                    (playerTurn == 1 ? player2 : player1).Send("shot", message.GetInt(0), message.GetInt(1));
                    playerTurn = 3 - playerTurn;
                    break;
            }
        }

		// This method gets called whenever triggered by the RefreshDebugView() method.
		public override Image GenerateDebugImage() {

			using(Graphics g = Graphics.FromImage(canvas)) {
                
                g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFF0000AD))), new Rectangle(0, 0, canvas.Width, canvas.Height));
                
                cityscape.Draw(g);

                if (player1 != null)
                    player1.Draw(g);

                if (player2 != null)
                    player2.Draw(g);
			}

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