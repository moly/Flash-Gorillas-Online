using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using PlayerIO.GameLibrary;

namespace ServersideGameCode
{
    public class Player : BasePlayer
    {
        // A gorilla image
        private Bitmap texture;

        // Player's current score
        private int score;
        public int Score
        {
            get { return score; }
            set { score = value; }
        }

        // Player's position
        private Point position;
        public int X
        {
            get { return position.X; }
            set { position.X = value; }
        }
        public int Y
        {
            get { return position.Y; }
            set { position.Y = value; }
        }

        // The player's display name
        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        // Whether or not the player is currently a zombie
        public bool IsZombie
        {
            get { return PlayerObject.GetInt("hat", 0) == 17 && PlayerObject.GetInt("shirt", 0) == 17 && PlayerObject.GetInt("trousers", 0) == 17; }
        }

        // Number of bananas this player has thrown
        private int bananasThrown;
        public int BananasThrown
        {
            get { return bananasThrown;}
            set { bananasThrown = value;}
        }


        public Player() : base()
        {
            texture = GorillaTexture.Create(new Bitmap(28, 30));
            bananasThrown = 0;
            score = 0;
        }
        
        // Draw the gorilla
        public void Draw(Graphics g)
        {
            g.DrawImage(texture, position);
        }

        // Check for a collision
        public bool IsColliding(Point point)
        {
            if (point.X < position.X ||
                point.X >= position.X + texture.Width ||
                point.Y < position.Y ||
                point.Y >= position.Y + texture.Height)
                return false;

            return texture.GetPixel(point.X - position.X, point.Y - position.Y).A != 0;
        }
    }

    class GorillaTexture 
    {
        public static Bitmap Create(Bitmap bitmap) 
        {            
            Graphics g = Graphics.FromImage(bitmap);
            SolidBrush gorillaColour = new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51)));
            Pen backgroundColour = new Pen(Color.FromArgb(unchecked((int)0xFF0000AD)));

            // draw head
			g.FillRectangle(gorillaColour, 10, 1, 8, 7);
			g.FillRectangle(gorillaColour, 9, 3, 10, 3);
			
			// draw eyes/brow
			g.DrawLine(backgroundColour, 11, 3, 17, 3);
			
			// draw nose
            g.DrawLine(backgroundColour, 12, 5, 13, 5);
            g.DrawLine(backgroundColour, 15, 5, 16, 5);
			
			// neck
            g.FillRectangle(gorillaColour, 11, 8, 6, 1);
			
			// body
            g.FillRectangle(gorillaColour, 6, 9, 16, 7);
            g.FillRectangle(gorillaColour, 8, 16, 12, 6);
			
			// legs
            g.FillRectangle(gorillaColour, 7, 21, 4, 2);
            g.FillRectangle(gorillaColour, 5, 22, 5, 2);
            g.FillRectangle(gorillaColour, 4, 24, 5, 5);
            g.FillRectangle(gorillaColour, 5, 29, 5, 1);

            g.FillRectangle(gorillaColour, 16, 22, 6, 1);
            g.FillRectangle(gorillaColour, 17, 23, 5, 1);
            g.FillRectangle(gorillaColour, 18, 24, 5, 5);
            g.FillRectangle(gorillaColour, 17, 29, 5, 1);

			// chest
			g.DrawLine(backgroundColour, 9, 15, 11, 15);
            g.DrawLine(backgroundColour, 12, 14, 13, 13);
            g.DrawLine(backgroundColour, 14, 12, 14, 11);
            g.DrawLine(backgroundColour, 15, 13, 16, 14);
            g.DrawLine(backgroundColour, 17, 15, 19, 15);
			
			// arms
			/*if(arms == RIGHT_ARM){
				line(20, 0, 24, 0, 0xFFFFAD51);
				line(21, 1, 25, 1, 0xFFFFAD51);
				fillRect(new Rectangle(22, 2, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(23, 4, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(22, 7, 5, 2), 0xFFFFAD51);
				line(21, 9, 25, 9, 0xFFFFAD51);
				line(20, 10, 24, 10, 0xFFFFAD51);
			}	
			if(arms == RIGHT_ARM || arms == ARMS_DOWN){*/
				g.FillRectangle(gorillaColour, 3, 10, 4, 1);
                g.FillRectangle(gorillaColour, 2, 11, 4, 1);
				g.FillRectangle(gorillaColour, 1, 12, 5, 2);
				g.FillRectangle(gorillaColour, 0, 14, 5, 3);
				g.FillRectangle(gorillaColour, 1, 17, 5, 2);
                g.FillRectangle(gorillaColour, 2, 19, 4, 1);
                g.FillRectangle(gorillaColour, 3, 20, 4, 1);
			/*}
			if (arms == LEFT_ARM) {
				line(3, 0, 7, 0, 0xFFFFAD51);
				line(2, 1, 6, 1, 0xFFFFAD51);
				fillRect(new Rectangle(1, 2, 5, 2), 0xFFFFAD51);
				fillRect(new Rectangle(0, 4, 5, 3), 0xFFFFAD51);
				fillRect(new Rectangle(1, 7, 5, 2), 0xFFFFAD51);
				line(2, 9, 6, 9, 0xFFFFAD51);
				line(3, 10, 7, 10, 0xFFFFAD51);
			}
			if (arms == LEFT_ARM || arms == ARMS_DOWN) {*/
                g.FillRectangle(gorillaColour, 20, 10, 4, 1);
                g.FillRectangle(gorillaColour, 21, 11, 4, 1);
                g.FillRectangle(gorillaColour, 22, 12, 5, 2);
                g.FillRectangle(gorillaColour, 23, 14, 5, 3);
                g.FillRectangle(gorillaColour, 22, 17, 5, 2);
                g.FillRectangle(gorillaColour, 21, 19, 4, 1);
                g.FillRectangle(gorillaColour, 20, 20, 4, 1);
			//}

            return bitmap;
        }
    }
}
