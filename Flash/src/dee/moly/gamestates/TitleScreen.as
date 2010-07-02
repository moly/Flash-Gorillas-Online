package dee.moly.gamestates {
	
	import dee.moly.gameobjects.CharChain;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.display.LoaderInfo; 
	import flash.display.Loader; 
	import flash.net.URLRequest; 
	import flash.events.Event; 
	import flash.system.Security;
	import playerio.*;
	
	/**
	 * The title screen. Has the game name, a quick paragraph about the
	 * game and a sparkle border.
	 * @author moly
	 */
	
	public class TitleScreen extends SparkleBorder {
		
		[Embed(source="/dee/moly/sounds/intro.mp3")] private static const IntroMusic:Class;
		private static const introMusic:Sound = new IntroMusic();
		
		// text
		private var title:CharChain = new CharChain("F l a s h    G O R I L L A S", 218, 62);
		private var line1:CharChain = new CharChain("Your mission is to hit your opponent with the exploding", 100, 107, CharChain.NONE, 1, 0xA8A8A8);
		private var line2:CharChain = new CharChain("banana by varying the angle and power of your throw, taking", 80, 123, CharChain.NONE, 1, 0xA8A8A8);
		private var line3:CharChain = new CharChain("into account wind speed, gravity, and the city skyline.", 100, 139, CharChain.NONE, 1, 0xA8A8A8);
		private var line4:CharChain = new CharChain("The wind speed is shown by a directional arrow at the bottom", 80, 155, CharChain.NONE, 1, 0xA8A8A8);
		private var line5:CharChain = new CharChain("of the playing field, its length relative to its strength.", 80, 171, CharChain.NONE, 1, 0xA8A8A8);
		private var pressToContinue:CharChain = new CharChain("Press any key to continue", 220, 300, CharChain.NONE, 1, 0xA8A8A8);
		
		// kongregate API reference 
		private var kongregate:*;
		
		// player.io client reference
		private var client:Client;
		
		// stage reference
		private var stage:Stage;
		
		public function TitleScreen(stage:Stage) {
			
			introMusic.play();
			
			this.stage = stage;
			
			// kongregate API
			// pull the API path from the FlashVars 
			var paramObj:Object = LoaderInfo(stage.root.loaderInfo).parameters; 
 
			// the API path. The "shadow" API will load if testing locally.  
			var apiPath:String = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf"; 
  
			// allow the API access to this SWF 
			Security.allowDomain(apiPath);
			
			// load the API 
			var request:URLRequest = new URLRequest(apiPath); 
			var loader:Loader = new Loader(); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete); 
			loader.load(request); 
			stage.addChild(loader);
		}
		
		// this function is called when kongregate API loading is complete 
		private function loadComplete(event:Event):void {
			
			// save Kongregate API reference 
			kongregate = event.target.content; 
  
			// connect to the back-end 
			kongregate.services.connect(); 
			
			PlayerIO.showLogo(stage, "TR");			
			
			// connect to player.io
			if(!kongregate.services.isGuest())
				PlayerIO.quickConnect.kongregateConnect(stage, "flash-gorillas-online-1nrdveekuspcredhsoew", kongregate.services.getUserId(), kongregate.services.getGameAuthToken(), onConnected, onConnectionError);
			else
				PlayerIO.connect(stage, "flash-gorillas-online-1nrdveekuspcredhsoew", "public", "Guest" + int(Math.random() * 9999), "", onConnected, onConnectionError);
		}
		
		// successfully connected to player.io
		private function onConnected(client:Client):void {
			this.client = client;
			//client.multiplayer.developmentServer = "localhost:8184";
		}
		
		// not successfully connected to player.io
		private function onConnectionError(error:PlayerIOError):void {
			trace(error);
		}
		
		// draw the intro screen
		override public function draw(canvas:BitmapData):void {
			
			super.draw(canvas);
			
			title.draw(canvas);
			line1.draw(canvas);
			line2.draw(canvas);
			line3.draw(canvas);
			line4.draw(canvas);
			line5.draw(canvas);
			
			if(client != null)
				pressToContinue.draw(canvas);
			
		}
		
		override public function onKeyDown(e:KeyboardEvent):void {
			
			if(client != null)
				gotoState(new Menu(client, kongregate));
		}
	}
}