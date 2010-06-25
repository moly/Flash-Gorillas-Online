package dee.moly.gameobjects {
	
	import dee.moly.textures.BananaTex;
	import dee.moly.textures.PokeBallTex;
	import dee.moly.textures.InfectedBananaTex;
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
		
		private var currentTexture:int;
		
		private static const textures:Array = [[new BananaTex(BananaTex.LEFT),
												new BananaTex(BananaTex.RIGHT),
												new BananaTex(BananaTex.UP),
												new BananaTex(BananaTex.DOWN)],
		
												[new PokeBallTex(BananaTex.LEFT),
												new PokeBallTex(BananaTex.RIGHT),
												new PokeBallTex(BananaTex.UP),
												new PokeBallTex(BananaTex.DOWN)],
												
												[new InfectedBananaTex(BananaTex.LEFT),
												new InfectedBananaTex(BananaTex.RIGHT),
												new InfectedBananaTex(BananaTex.UP),
												new InfectedBananaTex(BananaTex.DOWN)]];
		
		private var r:int;
		public function set rotation(value:int):void {
			
			r = value;
			
			texture = textures[currentTexture][r % 4];
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
		public function launch(angle:Number, velocity:int, gravity:Number, windSpeed:Number, startPoint:Point, textureNum:int):void {
			
			this.gravity = gravity;
			this.windSpeed = windSpeed;
				
			angle = angle / 180 * 3.142;
			
			this.velocity = new Point(int(Math.cos(angle) * velocity), int(Math.sin(angle) * velocity));
			
			startPos = startPoint;
			time = 0;
			
			currentTexture = textureNum;
			texture = textures[currentTexture][0];
		}
		
		override public function draw(canvas:BitmapData):void {
			canvas.copyPixels(texture, texture.rect, position.subtract(new Point(3, 3)), null, null, true);
		}
	}
}