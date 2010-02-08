package dee.moly.gameobjects{
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * A basic game object. All game objects should inherit from this.
	 * @author moly
	 */
	
	public class GameObject{
		
		// The object's texture
		protected var texture:BitmapData;
		
		// The object's position on the screen
		protected var position:Point;
		public function get x():int {
			return position.x;
		}
		public function get y():int {
			return position.y;
		}
		public function set x(value:int):void {
			position.x = value;
		}
		public function set y(value:int):void {
			position.y = value;
		}
		
		public function GameObject() {
			
		}
		
		public function update():void {
			
		}
		
		// copy the texture to the canvas
		public function draw(canvas:BitmapData):void {
			canvas.copyPixels(texture, texture.rect, position, null, null, true);
		}
		
	}

}