package dee.moly.gameobjects {
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * Contains the CharChain class code.  This class is the text input 
	 * controls used throughout the game that have the look and feel
	 * of DOS input lines. This class is a custom flash control created to further mimic the look
	 * and feel of the original Gorilla game.
	 * @author moly, but copied largely from Chris King
     */
	
	public class CharChain extends GameObject{
		
		[Embed(source="/dee/moly/textures/font.png")] private static const FontBitmap:Class;
		private static const font:BitmapData = new FontBitmap().bitmapData;
		
		// types of chain
		public static const ALPHANUMERIC:int = 0;
		public static const NUMERIC:int = 1;
		
		// cursor types
		public static const NONE:int = 0;
		public static const BLINKING:int = 1;
		public static const SOLID:int = 2;
		
		// cursor state machine items
		private static const CURSOR_HIDDEN:Boolean = false;
		private static const CURSOR_SHOWING:Boolean = true;
		
		// cursors location on the font sheet
		private static const CURSOR_X:int = 240;
		private static const CURSOR_Y:int = 48;
		
		private static const TILE_WIDTH:int = 16;
		private static const TILE_HEIGHT:int = 16;
		private static const CHAR_WIDTH:int = 8;
		private static const CHAR_HEIGHT:int = 14;
		
		// current state. The cursor is blinking by default.
		private var cursorState:Boolean;
		
		private var blinkTimer:Timer;
		
		// the string we are displaying
		private var string:String = "";
		
		// what is the maximum number of characters allowed in this string?  -1 for unlimited.
		private var maxStringLength:int = -1;
		// what input filter is set on this box?  0=everything, 1=numeric only
		private var filter:int;
		
		// what is the number of characters in this box?
		public function get length():int {
			return string.length;
		}
		
		// set the maximum amout of characters for this box
		public function set maxLength(value:int):void {
			maxStringLength = value;
		}
		
		// return the string representation of this text box
		public function get text():String {
			return string;
		}
		public function set text(value:String):void {
			string = value;
			updateTexture();
		}
		
		// font colour
		private var colour:ColorTransform;
		
		public function CharChain(text:String = "", x:int = 0, y:int = 0, cursor:int = NONE, type:int = NUMERIC, colour:uint = 0xFFFFFF, maxLength:int = -1) {
			
			string = text;
			position = new Point(x, y);
			filter = type;
			this.colour = new ColorTransform(0, 0, 0, 1, colour >> 16 & 0xFF, colour >> 8 & 0xFF, colour & 0xFF);
			maxStringLength = maxLength;
			
			switch(cursor) {
				
				case BLINKING:
					blinkTimer = new Timer(700);
					blinkTimer.addEventListener(TimerEvent.TIMER, blinkCursor, false, 0, true);
					blinkTimer.start();
					break;
					
				case NONE:
					cursorState = CURSOR_HIDDEN;
					break;
				
				case SOLID:
					cursorState = CURSOR_SHOWING;
					break;
					
			}
			
			updateTexture();
				
		}
		
		// centre the chain horizontally
		public function centre():void {
			position.x = (Main.SCREEN_WIDTH / 2) - (string.length * CHAR_WIDTH / 2);
		}
		
		public function removeCursor():void {
			if (blinkTimer != null) {
				blinkTimer.removeEventListener(TimerEvent.TIMER, blinkCursor);
				blinkTimer.stop();
			}
			cursorState = CURSOR_HIDDEN;
			updateTexture();
		}
		
		public function showCursor():void {
			cursorState = CURSOR_SHOWING;
			updateTexture();
		}
		
		// show the blinking underscore cursor
		private function blinkCursor(e:TimerEvent):void {
			cursorState = !cursorState;
			updateTexture();
		}
		
		// add a character to the end of this string
		public function addChar(charCode:int):void {
			
			// check some basic parameters.  If the ascii number is less than 32 or greater than 126 it's not a character
			// we support so exit
			if (charCode < 32 || charCode > 126) return;
			
			// if the max length has been reached already exit the function
			if (maxStringLength >= 0 && string.length >= maxStringLength) return;
			
			// if the filter has been set to numeric only and the ascii character is higher than 57,
			// lower than 48 or not the decimal (46) than it isnt a number and it violates the input filter.
			if (filter == 1) {
				if (charCode > 57) return;
				if (charCode < 48) if (charCode != 46) return;
			}
			
			string = string.concat(String.fromCharCode(charCode));
			updateTexture();
		}
		
		// this function removes the last character from the string
		public function backspace():void {
			
			if(string.length > 0) {
				string = string.slice(0, string.length - 1);
				updateTexture();
			}
		}
		
		// draw the string to a texture
		private function updateTexture():void {
			
			texture = new BitmapData((string.length + 1) * CHAR_WIDTH, CHAR_HEIGHT, true, 0x00);
			
			texture.lock();
			
			for (var i:int = 0; i < string.length; i++) {
				var code:int = string.charCodeAt(i) - 32;
				texture.copyPixels(font, new Rectangle(int(code % 16) * TILE_WIDTH + 4, int(code / 16) * TILE_HEIGHT + 2, CHAR_WIDTH, CHAR_HEIGHT), new Point(i * CHAR_WIDTH, 0), null, null, true);
			}
			if (cursorState == CURSOR_SHOWING)
				texture.copyPixels(font, new Rectangle(CURSOR_X + 4, CURSOR_Y + 2, CHAR_WIDTH, CHAR_HEIGHT), new Point(string.length * CHAR_WIDTH, 0), null, null, true);
			
			texture.colorTransform(texture.rect, colour);
			
			texture.unlock();
		}
	}
}
