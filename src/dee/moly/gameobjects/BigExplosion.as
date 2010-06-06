package dee.moly.gameobjects {
	
	import dee.moly.textures.DrawingBitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * A big explosion when a gorilla is hit
	 * @author moly
	 */
	
	public class BigExplosion extends GameObject{
		
		private var currentRadius:int;
		
		// what stage in the animation sequence we are at
		private var stage:int;
		
		public function get finished():Boolean {
			return stage == FINISHED;
		}
		
		private static const YADJ:int = 12;
		private static const XADJ:int = 5;
		private static const SCLX:int = Main.SCREEN_WIDTH / 320;
		private static const SCLY:int = Main.SCREEN_HEIGHT / 200;
		
		private static const EXPLOSION_COLOUR1:uint = 0xFFFC0054;
		private static const EXPLOSION_COLOUR2:uint = 0xFFFCA854;
		
		private static const STAGE_1:int = 0;
		private static const STAGE_2:int = 1;
		private static const STAGE_3:int = 2;
		private static const FINISHED:int = 3;
		
		public function BigExplosion() {
			stage = FINISHED;
		}
		
		// start a new explosion
		public function create(x:int, y:int):void {
			position = new Point(x, y);
			stage = STAGE_1;
			currentRadius = 1;			
		}
		
		override public function draw(canvas:BitmapData):void {
			
			if (finished) return;
			for (var i:int = 0; i < 2; ++i){
				if (stage == STAGE_1) {
					DrawingBitmap(canvas).circle(position.x + 4 * SCLX + XADJ, position.y + 7 * SCLY + YADJ, currentRadius, EXPLOSION_COLOUR1, 0.6);
					canvas.fillRect(new Rectangle(position.x - 7 * SCLX, position.y + 9 * SCLY - currentRadius, 7 * SCLX, 1), EXPLOSION_COLOUR1);
					if (++currentRadius >= SCLX * 8){
						stage = STAGE_2;
						currentRadius = 1;
					}
				}
				if (stage == STAGE_2) {
					if (++currentRadius >= SCLX * 16) {
						stage = STAGE_3;
					}
					if (currentRadius < 8 * SCLX)
						DrawingBitmap(canvas).circle(position.x + 3.5 * SCLX + XADJ, position.y + 7 * SCLY + YADJ, (8 * SCLX + 1) - currentRadius, 0xFF0000AD, 0.6);
					DrawingBitmap(canvas).circle(position.x + 3.5 * SCLX + XADJ, position.y + YADJ, currentRadius, currentRadius % 2 == 0 ? EXPLOSION_COLOUR1 : EXPLOSION_COLOUR2, 0.6);
				}
				if (stage == STAGE_3) {
					DrawingBitmap(canvas).circle(position.x + 3.5 * SCLX + XADJ, position.y + YADJ, currentRadius, 0xFF0000AD, 0.6);
					if (--currentRadius <= 0)
						stage = FINISHED;
				}
			}
		}
		
	}

}