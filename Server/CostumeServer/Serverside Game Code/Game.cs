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

        Player player;

        bool[] requirements = new bool[18];

		// This method is called when an instance of your the game is created
		public override void GameStarted() 
        {
            PreloadPlayerObjects = true;
		}
       
        public override void UserJoined(Player player)      
        {
            this.player = player;
            this.player.Name = player.JoinData["name"];
            int hat = Convert.ToInt32(player.JoinData["hat"]);
            int shirt = Convert.ToInt32(player.JoinData["shirt"]);
            int trousers = Convert.ToInt32(player.JoinData["trousers"]);

            SetRequirements();
            if (hat < requirements.Length && shirt < requirements.Length && trousers < requirements.Length)
            {
                if (requirements[hat] && requirements[shirt] && requirements[trousers])
                {
                    player.PlayerObject.Set("hat", hat);
                    player.PlayerObject.Set("shirt", shirt);
                    player.PlayerObject.Set("trousers", trousers);
                    player.PlayerObject.Save();
                }
            }
            player.Send("saved");
            player.Disconnect();
        }

        private void SetRequirements()
        {
            requirements[0] = true;
            requirements[1] = true;
            requirements[2] = true;
            requirements[3] = true;
            requirements[4] = player.PlayerObject.GetInt("level", 0) >= 1;
            requirements[5] = player.PlayerObject.GetInt("level", 0) >= 2;
            requirements[6] = player.PlayerObject.GetInt("level", 0) >= 3;
            requirements[7] = player.PlayerObject.GetInt("level", 0) >= 4;
            requirements[8] = player.PlayerObject.GetInt("level", 0) >= 5;
            requirements[9] = player.PlayerObject.GetInt("level", 0) >= 6;
            requirements[10] = player.PlayerObject.GetInt("level", 0) >= 7;
            requirements[11] = player.PlayerObject.GetInt("level", 0) >= 8;
            requirements[12] = player.PlayerObject.GetInt("level", 0) >= 9;
            requirements[13] = player.PlayerObject.GetInt("level", 0) >= 10;
            requirements[14] = player.PlayerObject.GetInt("level", 0) >= 11;
            requirements[15] = player.PlayerObject.GetInt("level", 0) >= 12;
            requirements[16] = player.PlayerObject.GetUInt("totalTime", 0) > 5000;
			requirements[17] = player.PlayerObject.GetBool("zombieUnlocked", false) || player.Name.ToLower().Contains("z");
			//					new ClothingItem("Crown", Crown, function():Boolean { return playerObject.isOnLeaderBoards || false
        }
	}
}