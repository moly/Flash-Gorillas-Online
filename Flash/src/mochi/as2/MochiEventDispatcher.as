class mochi.as2.MochiEventDispatcher
{
    // Event table
    private var eventTable:Object;

    public function MochiEventDispatcher()
    {
        eventTable = {};
    }

    private function buildDelegate( thisObject:Object, thatObject:Object ):Object
    {
        var delegate:Object = { thisObject:thisObject, thatObject:thatObject };

        if( thatObject != undefined )
        {
            var funct = ( typeof(thatObject) == "string" ) ? thisObject[thatObject] : thatObject;
            delegate.delegate = function(args:Object) { funct.call( thisObject, args ); };
        }
        else
        {
            delegate.delegate = thisObject;
        }

        return delegate;
    }

    private function compareDelegate( d_A:Object, d_B:Object ):Boolean
    {
        if( d_A.thisObject != d_B.thisObject ||
            d_A.thatObject != d_B.thatObject )
            return false;

        return true;
    }

    public function addEventListener ( event:String, thisObject:Object, thatObject:Object ):Void
    {
        // Make sure we don't refire events (and initialize)
        removeEventListener( event, thisObject, thatObject );

        eventTable[event].push( buildDelegate(thisObject,thatObject) );
    }

    public function removeEventListener ( event:String, thisObject:Object, thatObject:Object ):Void
    {
        var delegate = buildDelegate(thisObject,thatObject);

        // Abort if event is not monitored
        if( eventTable[event] == undefined )
        {
            eventTable[event] = [];
            return ;
        }

        for( var s:String in eventTable[event] )
        {
            if( !compareDelegate( eventTable[event][s], delegate) )
                continue ;

            eventTable[event].splice(Number(s),1);
        }
    }

    public function triggerEvent ( event:String, args:Object ):Void
    {
        // Abort if event is not monitored
        if( eventTable[event] == undefined )
            return ;

        for( var i:String in eventTable[event] )
            eventTable[event][i].delegate(args);
    }
}
