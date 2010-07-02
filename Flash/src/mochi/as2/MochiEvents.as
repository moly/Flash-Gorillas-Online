/**
* MochiEvents
* Analytics and Achievements system
* @author Mochi Media+
*/

import mochi.as2.MochiEventDispatcher;
import mochi.as2.MochiServices;

class mochi.as2.MochiEvents {
    public static var ACHIEVEMENT_RECEIVED:String = "AchievementReceived";

    public static var ALIGN_TOP_LEFT:String = "ALIGN_TL";
    public static var ALIGN_TOP:String = "ALIGN_T";
    public static var ALIGN_TOP_RIGHT:String = "ALIGN_TR";
    public static var ALIGN_LEFT:String = "ALIGN_L";
    public static var ALIGN_CENTER:String = "ALIGN_C";
    public static var ALIGN_RIGHT:String = "ALIGN_R";
    public static var ALIGN_BOTTOM_LEFT:String = "ALIGN_BL";
    public static var ALIGN_BOTTOM:String = "ALIGN_B";
    public static var ALIGN_BOTTOM_RIGHT:String = "ALIGN_BR";

    public static var FORMAT_SHORT:String = "ShortForm";
    public static var FORMAT_LONG:String = "LongForm";

    private static var gameStart:Number;
    private static var levelStart:Number;

    private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();


    public static function getVersion():String {
        return MochiServices.getVersion();
    }

    // --- Basic Event Tracking -----
    public static function startSession( achievementID:String ):Void
    {
        // TODO: THIS SHOULD BE CALLED FROM CONNECT!
        MochiServices.send("events_beginSession", { achievementID: achievementID }, null, null );
    }

    // --- UI Notification system ---
    // clip = null to disable automatic notifications (default)
    public static function setNotifications( clip:MovieClip, style:Object ):Void
    {
        var args:Object = {}

        for( var s:String in style )
            args[s] = style[s];
        args.clip = clip;

        MochiServices.send("events_setNotifications", args, null, null );
    }

    // --- Callback system ----------
    public static function addEventListener( eventType:String, thisObject:Object, thatObject:Object ):Void
    {
        _dispatcher.addEventListener( eventType, thisObject, thatObject );
    }

    public static function triggerEvent( eventType:String, args:Object ):Void
    {
        _dispatcher.triggerEvent( eventType, args );
    }

    public static function removeEventListener( eventType:String, thisObject:Object, thatObject:Object ):Void
    {
        _dispatcher.removeEventListener( eventType, thisObject, thatObject );
    }

    // --- Bucketed events ----------
    public static function startPlay( tag:String ):Void {
        if( tag == undefined )
            tag = "gameplay";
        
        MochiServices.send("events_setRoundID", { tag:String(tag) }, null, null );
    }

    public static function endPlay():Void {
        MochiServices.send("events_clearRoundID", null, null, null );
    }

    public static function trackEvent( tag:String, value:Object ):Void {
        MochiServices.send("events_trackEvent", { tag: tag, value:value }, null, null );
    }
}
