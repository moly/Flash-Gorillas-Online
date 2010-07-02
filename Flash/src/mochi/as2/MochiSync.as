import mochi.as2.MochiServices;

class mochi.as2.MochiSync {
    public static var SYNC_REQUEST:String = "SyncRequest";
    public static var SYNC_PROPERTY:String = "UpdateProperty";
    private var _syncContainer:Object;

    public function MochiSync()
    {
        _syncContainer = {};
    }

    public function getProp( name:String ):Object {
        return _syncContainer[name];
    }

    public function setProp( name:String, value:Object ):Void {
        if( _syncContainer[name] == value )
            return ;

        _syncContainer[name] = value;
        MochiServices.send("sync_propUpdate", {name:name,value:value});
    }

    public function triggerEvent( eventType:String, args:Object ):Void
    {
        switch( eventType )
        {
            case SYNC_REQUEST:
                MochiServices.send("sync_syncronize", _syncContainer );
                break ;
            case SYNC_PROPERTY:
                _syncContainer[args.name] = args.value;
                break ;
        }
    }
}
