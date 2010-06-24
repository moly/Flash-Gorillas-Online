package dee.moly.gameobjects {
	
	import dee.moly.textures.BananaTex;
	import dee.moly.textures.PokeBallTex;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * the banana that the gorillas throw at each other
	 * @author moly
	 */
	
	public class Banana extends GameObject{
		
		private var startPos:Point;
		private var gravity:Number;
		private var windSpeed:Number;
		private var time:Number;
		
		private var velocity:Point;
		
		private var left:BitmapData;
		private var right:BitmapData;
		private var up:BitmapData;
		private var down:BitmapData;
		
		private static const mainLeft:BitmapData = new BananaTex(BananaTex.LEFT);
		private static const mainRight:BitmapData = new BananaTex(BananaTex.RIGHT);
		private static const mainUp:BitmapData = new BananaTex(BananaTex.UP);
		private static const mainDown:BitmapData = new BananaTex(BananaTex.DOWN);
		
		private static const altLeft:BitmapData = new PokeBallTex(BananaTex.LEFT);
		private static const altRight:BitmapData = new PokeBallTex(BananaTex.RIGHT);
		private static const altUp:BitmapData = new PokeBallTex(BananaTex.UP);
		private static const altDown:BitmapData = new PokeBallTex(BananaTex.DOWN);
		
		private var r:int;
		public function set rotation(value:int):void {
			
			r = value;
			
			switch(r % 4) {
				case 0:
					texture = left;
					break;
				case 1:
					texture = right;
					break;
				case 2:
					texture = up;
					break;
				case 3:
					texture = down;
					break;
			}
		}
		
		public function get rotation():int {
			return r;
		}
		
		public function Banana() {
			
			r = 0;
			position = new Point();
		}
		
		// move the banana
		override public function update(elapsed:Number):void {
						
			position.x = int(startPos.x + (velocity.x * time) + (.5 * (windSpeed / 5) *  (time * time)));
			position.y = int(startPos.y + (( -1 * (velocity.y * time)) + (.5 * gravity * (time * time))) * (Main.SCREEN_HEIGHT / 350));
			
			time += 0.1;
			
			rotation++;
		}
		
		// start the banana moving
		public function launch(angle:Number, velocity:int, gravity:Number, windSpeed:Number, startPoint:Point, altTexture:Boolean):void {
			
			this.gravity = gravity;
			this.windSpeed = windSpeed;
				
			angle = angle / 180 * 3.142;
			
			this.velocity = new Point(int(Math.cos(angle) * velocity), int(Math.sin(angle) * velocity));
			
			startPos = startPoint;
			time = 0;
			
			if (altTexture) {
				left = altLeft;
				right = altRight;
				up = altUp;
				down = altDown;
			}else {
				left = mainLeft;
				right = mainRight;
				up = mainUp;
				down = mainDown;
			}
			
			texture = left;
		}
		
		override public function draw(canvas:BitmapData):void {
			canvas.copyPixels(texture, texture.rect, position.subtract(new Point(3, 3)), null, null, true);
		}
	}
}