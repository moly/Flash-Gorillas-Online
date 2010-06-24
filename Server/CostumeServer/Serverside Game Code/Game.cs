using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace MyGame {
	public class Player : BasePlayer {
		public string Name;
	}

	public class GameCode : Game<Player> {
		// This method is called when an instance of your the game is created
		public override void GameStarted() {
            PreloadPlayerObjects = true;
		}

        public override void UserJoined(Player player){
            player.PlayerObject.Set("hat", Convert.ToInt32(player.JoinData["hat"]));
            player.PlayerObject.Set("shirt", Convert.ToInt32(player.JoinData["shirt"]));
            player.PlayerObject.Set("trousers", Convert.ToInt32(player.JoinData["trousers"]));
            player.PlayerObject.Save();
            player.Send("saved");
            player.Disconnect();
        }
	}
}