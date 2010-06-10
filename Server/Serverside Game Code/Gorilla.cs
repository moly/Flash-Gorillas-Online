using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using PlayerIO.GameLibrary;

namespace ServersideGameCode{

    public class Gorilla : BasePlayer{

        // A gorilla image
        private Bitmap texture;

        // Player's position
        private Point position;
        public int X{
            get { return position.X; }
            set { position.X = value; }
        }
        public int Y{
            get { return position.Y; }
            set { position.Y = value; }
        }

        // The player's display name
        private string name;
        public string Name{
            get { return name; }
            set { name = value; }
        }

        public Gorilla() : base(){
             texture = GorillaTexture.Create(new Bitmap(28, 30));
        }
        
        // Draw the gorilla
        public void Draw(Graphics g){
            g.DrawImage(texture, position);
        }
    }

    class GorillaTexture {

        public static Bitmap Create(Bitmap bitmap) {
            
            Graphics g = Graphics.FromImage(bitmap);

            // draw head
			g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(10, 1, 8, 7));
			g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(9, 3, 10, 3));
			
			// draw eyes/brow
			g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFF0000AD))), new Rectangle(11, 3, 6, 1));
			
			// draw nose
			for (int i = -2; i <= -1; i++){
				bitmap.SetPixel(14 + i, 5, Color.FromArgb(unchecked((int)0x000000AD)));
                bitmap.SetPixel(17 + i, 5, Color.FromArgb(unchecked((int)0x000000AD)));
			}
			
			// neck
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(11, 8, 6, 1));
			
			// body
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(6, 9, 16, 7));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(8, 16, 12, 6));
			
			// legs
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(7, 21, 4, 2));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(5, 22, 5, 2));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(4, 24, 5, 5));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(5, 29, 5, 1));

            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(16, 22, 6, 1));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(17, 23, 5, 1));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(18, 24, 5, 5));
            g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(17, 29, 5, 1));

			// chest
			g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFF0000AD))), 9, 15, 11, 15);
			bitmap.SetPixel(12, 14, Color.FromArgb(unchecked((int)0x000000AD)));
            bitmap.SetPixel(13, 13, Color.FromArgb(unchecked((int)0x000000AD)));
            g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFF0000AD))), 14, 12, 14, 11);
            bitmap.SetPixel(15, 13, Color.FromArgb(unchecked((int)0x000000AD)));
            bitmap.SetPixel(16, 14, Color.FromArgb(unchecked((int)0x000000AD)));
            g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFF0000AD))), 17, 15, 19, 15);
			
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
				g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 3, 10, 7, 10);
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 2, 11, 6, 11);
				g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(1, 12, 5, 2));
				g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(0, 14, 5, 3));
				g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(1, 17, 5, 2));
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 2, 19, 6, 19);
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 3, 20, 7, 20);
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
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 20, 10, 24, 10);
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 21, 11, 25, 11);
                g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(22, 12, 5, 2));
                g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(23, 14, 5, 3));
                g.FillRectangle(new SolidBrush(Color.FromArgb(unchecked((int)0xFFFFAD51))), new Rectangle(22, 17, 5, 2));
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 21, 19, 25, 19);
                g.DrawLine(new Pen(Color.FromArgb(unchecked((int)0xFFFFAD51))), 20, 20, 24, 20);
			//}

            return bitmap;

        }
    }
}
