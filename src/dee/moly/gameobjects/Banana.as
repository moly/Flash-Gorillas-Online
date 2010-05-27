package dee.moly.gameobjects {
	
	import dee.moly.textures.BananaTex;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * the banana that the gorillas throw at each other
	 * @author moly
	 */
	
	public class Banana extends GameObject{
		
		public var inMotion:Boolean;
		
		private var startPos:Point;
		private var gravity:Number;
		private var windSpeed:Number;
		private var time:Number;
		
		private var velocity:Point;
		
		private static const left:BitmapData = new BananaTex(BananaTex.LEFT);
		private static const right:BitmapData = new BananaTex(BananaTex.RIGHT);
		private static const up:BitmapData = new BananaTex(BananaTex.UP);
		private static const down:BitmapData = new BananaTex(BananaTex.DOWN);
		
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
			texture = left;
			
		}
		
		// move the banana
		override public function update(elapsed:Number):void 
		{	
			time += elapsed / 200;
			
			position.x = int(startPos.x + (velocity.x * time) + (.5 * (windSpeed / 5) *  (time * time)));
			position.y = int(startPos.y + (( -1 * (velocity.y * time)) + (.5 * gravity * (time * time))) * (Main.SCREEN_HEIGHT / 350));
			
			rotation++;
			
			if (position.x > Main.SCREEN_WIDTH || position.x < 0 || position.y > Main.SCREEN_HEIGHT)
				inMotion = false;
		}
		
		// start the banana moving
		public function doShot(angle:Number, velocity:int, gravity:Number, windSpeed:Number, startPoint:Point):void {
			
			this.gravity = gravity;
			this.windSpeed = windSpeed;
				
			angle = angle / 180 * 3.142;
			
			this.velocity = new Point(Math.cos(angle) * velocity, Math.sin(angle) * velocity);
			
			startPos = startPoint;
			
			time = 0;
			inMotion = true;
			
		}
		
	}

}