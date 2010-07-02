/**
* MochiServices
* Class that provides API access to Mochi Coins Service
* @author Mochi Media
*/
import mochi.as2.MochiEventDispatcher;
import mochi.as2.MochiServices;
import mochi.as2.MochiSocial;

class mochi.as2.MochiCoins {
    public static var STORE_SHOW:String = "StoreShow";
    public static var STORE_HIDE:String = "StoreHide";

    // event passes {id: item id, count: number owned}
    public static var ITEM_OWNED:String = "ItemOwned";

    // event passes {id: item id, count: number of new items}
    public static var ITEM_NEW:String = "ItemNew";

    // initiated with getStoreItems() call.
    // event passes array of item metas [ { id: "ab473e7f87129ecb", name: "Super Cannon", desc: "A Super Cannon",
    //    imgURL: "http://..", cost: 150, maxNum: 1, tags: [ level-1, powerup] ], properties: { power: 20 } } ]
    public static var STORE_ITEMS:String = "StoreItems";

    public static var ERROR:String = "Error";
    // error types
    public static var IO_ERROR:String = "IOError";
    public static var NO_USER:String = "NoUser";

    public static function getVersion():String
    {
        return MochiServices.getVersion();
    }

    /**
     * Method: showStore
     * Displays the MochiGames Store.
     * @param   options object containing variables representing the changeable parameters <see: GUI Options>
     */
    public static function showStore(options:Object):Void
    {
        MochiServices.send("coins_showStore", { options: options }, null, null );
    }

    /**
     * Method: showItem
     * Displays the MochiGames with one item.
     * @param   options object containing variables representing the changeable parameters <see: GUI Options>
     */
    public static function showItem(options:Object):Void
    {
        if ((options == undefined) || (typeof(options.item) != "string")) {
            trace("ERROR: showItem call must pass an Object with an item key");
            return;
        }

        MochiServices.send("coins_showItem", { options: options }, null, null );
    }

    /**
     * Method: showVideo
     * Displays the demonstration video for an item
     * @param   options object containing variables representing the changeable parameters <see: GUI Options>
     */
    public static function showVideo(options:Object):Void
    {
        if ((options == undefined) || (typeof(options.item) != "string")) {
            trace("ERROR: showVideo call must pass an Object with an item key");
            return;
        }

        MochiServices.send("coins_showVideo", { options: options }, null, null );
    }

    /**
     * Method: getStoreItems
     * Calls STORE_ITEMS event, passing an object with all store items, keyed by itemID
     * { ab473e7f87129ecb: { name: "Super Cannon", desc: "A Super Cannon", imgURL: "http://..", cost: 150, maxNum: 1, tags:{ levels: "level-1" } } }
     */
    public static function getStoreItems():Void
    {
        MochiServices.send("coins_getStoreItems");
    }

    // --- Callback system ----------
    public static function addEventListener( eventType:String, delegate:Function ):Void
    {
        MochiSocial.addEventListener( eventType, delegate );
    }

    public static function triggerEvent( eventType:String, args:Object ):Void
    {
        MochiSocial.triggerEvent( eventType, args );
    }

    public static function removeEventListener( eventType:String, delegate:Function ):Void
    {
        MochiSocial.removeEventListener( eventType, delegate );
    }
}
