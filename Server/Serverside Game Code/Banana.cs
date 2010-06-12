using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;

namespace ServersideGameCode{

    class Banana{

        // A texture for debugging
        private Bitmap texture;

        // Four posibilites for the end of the banana
        public const int HIT_GORILLA_ONE = 0;
        public const int HIT_GORILLA_TWO = 1;
        public const int HIT_BUILDING = 2;
        public const int OUT_OF_BOUNDS = 3;

        // How long the banana took to fly
        private float time;

        // Throw a banana
        public int Launch(float angle, int velocity, float gravity, float windSpeed, Point startPoint, Cityscape cityscape, Player player1, Player player2){

            texture = new Bitmap(640, 350);

            angle = (float)(angle / 180 * 3.142);

            int velocityX = (int)(Math.Cos(angle) * velocity);
            int velocityY = (int)(Math.Sin(angle) * velocity);

            Point position = new Point();
            time = 0;
            
            while (true){

                position.X = (int)(startPoint.X + (velocityX * time) + (.5 * (windSpeed / 5) * (time * time)));
                position.Y = (int)(startPoint.Y + ((-1 * (velocityY * time)) + (.5 * gravity * (time * time))));
                time += 0.1f;
                
                if (cityscape.IsColliding(position))
                    return HIT_BUILDING;

                if (player1.IsColliding(position))
                    return HIT_GORILLA_ONE;

                if (player2.IsColliding(position))
                    return HIT_GORILLA_TWO;

                if (position.X > 640 || position.X < 0 || position.Y > 350)
                    return OUT_OF_BOUNDS;

                if (position.Y > 0)
                    texture.SetPixel(position.X, position.Y, Color.Red);
            }
        }

        // Draw the texture
        public void Draw(Graphics g){
            if (texture == null)
                return;

            g.DrawImage(texture, 0, 0);
        }
    }
}
