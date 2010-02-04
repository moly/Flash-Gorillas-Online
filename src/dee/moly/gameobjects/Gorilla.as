package dee.moly.gameobjects {
	
	import dee.moly.textures.ContentManager;
	import flash.geom.Point;
	
	/**
	 * a gorilla
	 * @author moly
	 */
	
	public class Gorilla extends GameObject{
		
		public function Gorilla(x:int = 0, y:int = 0) {
			
			position = new Point(x, y);
			
			texture = ContentManager.gorillaD;
			
		}
		
		public function raiseLeftArm():void {
			
			texture = ContentManager.gorillaL;
			
		}
		
		public function raiseRightArm():void {
			
			texture = ContentManager.gorillaR;
			
		}
		
		public function swapArms():void {
			
			texture = texture == ContentManager.gorillaR ? ContentManager.gorillaL : ContentManager.gorillaR;
			
		}
		
	}

}