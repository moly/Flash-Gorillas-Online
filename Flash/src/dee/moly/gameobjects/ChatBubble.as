package dee.moly.gameobjects {
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * A white chat bubble to display messages
	 * @author moly
	 */
	
	public class ChatBubble extends GameObject{
		
		private var showing:Boolean;
		private var charChain:CharChain;
		private var timer:Timer;
		
		public function ChatBubble() {
			showing = false;
			timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, hide, false, 0, true);
		}
		
		// create a new bubble
		public function create(text:String, x:int, y:int):void {
			showing = true;
			timer.stop();
			
			texture = new BitmapData((text.length * 8) + 8, 21 + 6, true, 0x00FFFFFF);
			
			if(x < Main.SCREEN_WIDTH / 2)
				position = new Point((x - texture.width) > 5 ? x - texture.width : 5, y - texture.height);
			else
				position = new Point(((x - 6) + texture.width) > Main.SCREEN_WIDTH - 5 ? Main.SCREEN_WIDTH - 5 - (texture.width) : x - 6, y - texture.height);
			
			texture.fillRect(new Rectangle(0, 0, texture.width, texture.height - 6), 0xFFFFFFFF);
			texture.fillRect(new Rectangle(x - position.x - 6, texture.height - 6, 6, 2), 0xFFFFFFFF);
			texture.fillRect(new Rectangle(x - position.x - 4, texture.height - 4, 4, 2), 0xFFFFFFFF);
			texture.fillRect(new Rectangle(x - position.x - 2, texture.height - 2, 2, 2), 0xFFFFFFFF);	
		
			charChain = new CharChain(text, 4, 7, CharChain.NONE, CharChain.ALPHANUMERIC, 0xFF000000);
			charChain.draw(texture);
			
			timer.start();
		}
		
		// only draw the bubble if it should be showing
		override public function draw(canvas:BitmapData):void {
			if (!showing)
				return;
			
			super.draw(canvas);
		}
		
		// stop the bubble showing
		private function hide(e:TimerEvent = null):void {
			showing = false;
		}
	}
}