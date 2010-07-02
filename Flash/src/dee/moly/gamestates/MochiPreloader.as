package dee.moly.gamestates 
{
	import flash.display.Stage;
	import mochi.as3.*;
	import flash.display.MovieClip;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author moly
	 */
	public class MochiPreloader extends GameState
	{
		private var stage:Stage;
		
		public function MochiPreloader(stage:Stage) 
		{
			this.stage = stage;
			MochiServices.connect("b8280d57cec5ed7a", MovieClip(stage.getChildAt(0)), onError);
			MochiAd.showPreGameAd( { id:"b8280d57cec5ed7a", res:"640x350", no_progress_bar:true, clip:MovieClip(stage.getChildAt(0)), ad_finished:onAdFinished } );
			trace("go");
		}
		
		private function onError(error:String):void
		{
			trace(error);
		}
		
		private function onAdFinished():void
		{
			gotoState(new TitleScreen(stage));
		}
		
	}

}