package dee.moly.gameobjects {
	
	import dee.moly.textures.ContentManager;
	import flash.geom.Point;
	
	/**
	 * a gorilla
	 * @author moly
	 */
	
	public class Gorilla extends GameObject{
		
		private var textures:Array = [ContentManager.gorillaL, ContentManager.gorillaR, ContentManager.gorillaD];
		
		public function Gorilla(x:int = 0, y:int = 0) {
			
			position = new Point(x, y);
			
			texture = textures[2];
			
		}
		
		public function raiseLeftArm():void {
			
			texture = textures[0];
			
		}
		
		public function raiseRightArm():void {
			
			texture = textures[1];
			
		}
		
		public function swapArms():void {
			
			texture = texture == textures[0] ? textures[1] : textures[0];
			
		}
		
	}

}