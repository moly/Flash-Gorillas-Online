package dee.moly.gameobjects {
	
	import dee.moly.textures.BananaTex;
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
		private var result:int;
		
		private var velocity:Point;
		
		// Four posibilites for the end of the banana
        private const HIT_GORILLA_ONE:int = 0;
        private const HIT_GORILLA_TWO:int = 1;
        private const HIT_BUILDING:int = 2;
        private const OUT_OF_BOUNDS:int = 3;
		
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
		override public function update(elapsed:Number):void {
						
			position.x = int(startPos.x + (velocity.x * time) + (.5 * (windSpeed / 5) *  (time * time)));
			position.y = int(startPos.y + (( -1 * (velocity.y * time)) + (.5 * gravity * (time * time))) * (Main.SCREEN_HEIGHT / 350));
			
			time += 0.1;
			
			rotation++;
		}
		
		// start the banana moving
		public function launch(angle:Number, velocity:int, gravity:Number, windSpeed:Number, startPoint:Point, result:int):void {
			
			this.gravity = gravity;
			this.windSpeed = windSpeed;
			this.result = result;
				
			angle = angle / 180 * 3.142;
			
			this.velocity = new Point(int(Math.cos(angle) * velocity), int(Math.sin(angle) * velocity));
			
			startPos = startPoint;
			time = 0;
			
		}
		
	}

}