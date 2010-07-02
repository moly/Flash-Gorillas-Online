/**
* MochiServices
* Connection class for all MochiAds Remote Services
* @author Mochi Media+
*/

import mochi.as2.MochiEvents;
import mochi.as2.MochiSync;
import mochi.as2.MochiCoins;
import mochi.as2.MochiSocial;

class mochi.as2.MochiServices {

    private static var _id:String;
    private static var _container:MovieClip;
    private static var _clip:MovieClip;
    private static var _loader:MovieClipLoader;
    private static var _loaderListener:Object;

    private static var _servURL:String = "http://www.mochiads.com/static/lib/services/";
    private static var _services:String = "services.swf";
    private static var _mochiLC:String = "MochiLC.swf";

    private static var _swfVersion:String;

    private static var _listenChannel:Object;
    private static var _listenChannelName:String = "__ms_";
    private static var _sendChannel:Object;
    private static var _sendChannelName:String;

    private static var _connecting:Boolean = false;
    private static var _connected:Boolean = false;

    public static var netup:Boolean = true;
    public static var netupAttempted:Boolean = false;

    public static var onError:Object;
    public static var servicesSync:MochiSync = new MochiSync();

    //
    public static function get id ():String {
        return _id;
    }

    //
    public static function get clip ():MovieClip {
        return _container;
    }

    //
    public static function get childClip ():Object {
        return _clip;
    }

    //
    //
    static function getVersion():String {
        return "3.8 as2";
    }

    //
    //
    private static function allowDomains(server:String):String {
        var hostname = server.split("/")[2].split(":")[0];
        if (System.security) {
            if (System.security.allowDomain) {                
                System.security.allowDomain("*");
                System.security.allowDomain(hostname);
            }
            if (System.security.allowInsecureDomain) {                
                System.security.allowInsecureDomain("*");
                System.security.allowInsecureDomain(hostname);
            }
        }
        return hostname;
    }

    //
    public static function get isNetworkAvailable():Boolean {
        if (System.security) {
            var o:Object = System.security;
            if (o.sandboxType == "localWithFile") {
                return false;
            }
        }
        return true;
    }

    //
    public static function set comChannelName(val:String):Void {
        if (val != undefined) {
            if (val.length > 3) {
                _sendChannelName = val + "_fromgame";
                initComChannels();
            }
        }
    }

    //
    public static function get connected ():Boolean {
        return _connected;
    }

    /**
     * Method: connect
     * Connects your game to the MochiServices API
     * @param   id the MochiAds ID of your game
     * @param   clip the MovieClip in which to load the API (optional for all but AS3, defaults to _root)
     * @param   onError a function to call upon connection or IO error
     */
    public static function connect (id:String, clip:MovieClip, onError:Object):Void {
        warnID( id, false );
        if (!_connected && _clip == undefined) {
            trace("MochiServices Connecting...");
            _connecting = true;
            init(id, clip);
        }
        if (onError != undefined) {
            MochiServices.onError = onError;
        } else if (MochiServices.onError == undefined) {
            MochiServices.onError = function (errorCode:String):Void { trace(errorCode); };
        }
    }

    //
    //
    public static function disconnect ():Void {
        if (_connected || _connecting) {
            _connecting = _connected = false;
            flush(true);
            if (_clip != undefined) {
                _clip.removeMovieClip();
                delete _clip;
            }
            _listenChannel.close();
        }
    }

    //
    //
    private static function init (id:String, clip:MovieClip):Void {
        _id = id;
        if (clip != undefined) {
            _container = clip;
        } else {
            _container = _root;
        }
        loadCommunicator(id, _container);
    }

    //
    //
    private static function loadCommunicator (id:String, clip:MovieClip):MovieClip {
        var clipname:String = '_mochiservices_com_' + id;
        var _loader:MovieClipLoader = new MovieClipLoader();
        var _loaderListener:Object = {};

        if (_clip != null) {
            return _clip;
        }

        if (!MochiServices.isNetworkAvailable) {
            return null;
        }

        if (urlOptions().servURL) {
            _servURL = urlOptions().servURL;
        }
        var servicesURL:String = _servURL + _services;

        if (urlOptions().servicesURL) {
            servicesURL = urlOptions().servicesURL;
        }

        MochiServices.allowDomains(servicesURL);

        _clip = clip.createEmptyMovieClip(clipname, 10336, false);

        _listenChannelName += Math.floor((new Date()).getTime()) + "_" + Math.floor(Math.random() * 99999);

        // load com swf into container
        listen();
        if (_loaderListener.waitInterval != null)
            clearInterval(_loaderListener.waitInterval);

        _loaderListener.onLoadError = loadError;
        _loaderListener.onLoadStart = function (target_mc:MovieClip):Void { this.isLoading = true; }
        _loaderListener.onLoadComplete = function (target_mc:MovieClip):Void { target_mc.MochiServices = mochi.as2.MochiServices; }
        _loaderListener.startTime = getTimer();
        _loaderListener.wait = function ():Void {
            if (getTimer() - this.startTime > 10000) {
                if (!this.isLoading) {
                    MochiServices.disconnect();
                    MochiServices.onError.apply(null, ["IOError"]);
                }
                clearInterval(this.waitInterval);
            }
        };
        _loaderListener.waitInterval = setInterval(_loaderListener, "wait", 1000);
        _loader.addListener(_loaderListener);
        _loader.loadClip(servicesURL + "?listenLC=" + _listenChannelName + "&mochiad_options=" + escape(_root.mochiad_options) + "&api_version=" + MochiServices.getVersion(), _clip);

        // init send channel
        _sendChannel = new LocalConnection();
        _sendChannel._queue = [];

        return _clip;
    }

    private static function loadError(target_mc:MovieClip, errorCode:String, httpStatus:Number):Void {
        trace("MochiServices could not load.");
        MochiServices.disconnect();
        MochiServices.onError.apply(null, [errorCode]);
    };

    //
    //
    private static function onStatus (infoObject:Object):Void {
        switch (infoObject.level) {
            case 'error' :
                _connected = false;
                _listenChannel.connect(_listenChannelName);
                break;
        }
    }

    //
    //
    private static function listen ():Void {
        _listenChannel = new LocalConnection();
        _listenChannel.handshake = function (args:Object):Void { MochiServices.comChannelName = args.newChannel; };
        _listenChannel.allowDomain = function (d:String):Boolean { return true; };
        _listenChannel.allowInsecureDomain = _listenChannel.allowDomain;
        _listenChannel._nextcallbackID = 0;
        _listenChannel._callbacks = {};
        _listenChannel.connect(_listenChannelName);
        trace("Waiting for MochiAds services to connect...");
    }

    //
    //
    private static function initComChannels ():Void {
        if (!_connected) {
            _sendChannel.onStatus = function (infoObject:Object):Void { MochiServices.onStatus(infoObject); };
            _sendChannel.send(_sendChannelName, "onReceive", {methodName: "handshakeDone"});
            _sendChannel.send(_sendChannelName, "onReceive", { methodName: "registerGame", id: _id, version: MochiServices.getVersion() } );
            _listenChannel.onStatus = function (infoObject:Object):Void { MochiServices.onStatus(infoObject); };
            _listenChannel.onReceive = function (pkg:Object):Void {
                var cb:String = pkg.callbackID;
                var cblst:Object = this._callbacks[cb];
                if (!cblst) return;
                var method = cblst.callbackMethod;
                var obj = cblst.callbackObject;
                if (obj && typeof(method) == 'string') method = obj[method];
                if (method != undefined) method.apply(obj, pkg.args);
                delete this._callbacks[cb];
            };
            _listenChannel.onEvent = function (pkg:Object):Void {
                switch( pkg.target )
                {
                    // MochiEvents tunnel
                    case "events":
                        MochiEvents.triggerEvent( pkg.event, pkg.args );
                        break ;
                    // MochiCoins tunnel
                    case "coins":
                        MochiSocial.triggerEvent( pkg.event, pkg.args );
                        break ;
                    // MochiSync tunnel
                    case "sync":
                        MochiServices.servicesSync.triggerEvent( pkg.event, pkg.args );
                        break ;
                }
            }
            _listenChannel.onError = function ():Void { MochiServices.onError.apply(null, ["IOError"]); };
            trace("[SERVICES_API] connected!");
            _connecting = false;
            _connected = true;
            while(_sendChannel._queue.length > 0) {
                _sendChannel.send(_sendChannelName, "onReceive", _sendChannel._queue.shift());
            }
        }
    }
    
    public static function updateCopy( args:Object ):Void {
        MochiServices.send("coins_updateCopy", args, null, null );
    }

    //
    //
    private static function flush (error:Boolean):Void {

        var request:Object;
        var callback:Object;

        while (_sendChannel._queue.length > 0) {

            request = _sendChannel._queue.shift();
            delete callback;
            if (request.callbackID != null) callback = _listenChannel._callbacks[request.callbackID];
            delete _listenChannel._callbacks[request.callbackID];

            if (error) {
                handleError(request.args, callback.callbackObject, callback.callbackMethod);
            }

        }

    }

    //
    //
    private static function handleError (args:Object, callbackObject:Object, callbackMethod:Object):Void {

        if (args != null) {
            if (args.onError != null) {
                args.onError.apply(null, ["NotConnected"]);
            }
            if (args.options != null && args.options.onError != null) {
                args.options.onError.apply(null, ["NotConnected"]);
            }
        }

        if (callbackMethod != null) {

            args = { };
            args.error = true;
            args.errorCode = "NotConnected";

            if (callbackObject != null && typeof(callbackMethod) == "string") {
                callbackObject[callbackMethod](args);
            } else if (callbackMethod != null) {
                callbackMethod.apply(args);
            }

        }

    }

    //
    //
    public static function send (methodName:String, args:Object, callbackObject:Object, callbackMethod:Object):Void {
        if (_connected) {
            _sendChannel.send(_sendChannelName, "onReceive", {methodName: methodName, args: args, callbackID: _listenChannel._nextcallbackID});
        } else if (_clip == undefined || !_connecting) {
            trace( "Error: MochiServices not connected.   Please call MochiServices.connect().  Function: " + methodName);
            handleError(args, callbackObject, callbackMethod);
            flush(true);
            return;
        } else {
            _sendChannel._queue.push({methodName: methodName, args: args, callbackID: _listenChannel._nextcallbackID});
        }
        _listenChannel._callbacks[_listenChannel._nextcallbackID] = {callbackObject: callbackObject, callbackMethod: callbackMethod};
        _listenChannel._nextcallbackID++;
    }

    private static function urlOptions():Object {
        var opts = {};
        var options:String;

        if (_root._url.indexOf("mochiad_options") != -1) {
            var i:Number = _root._url.indexOf("mochiad_options") + "mochiad_options".length + 1;
            options = _root._url.substr(i, _root._url.length);
        } else if (_root.mochiad_options) {
            options = _root.mochiad_options;
        }

        if (options) {
            var pairs = _root.mochiad_options.split("&");
            for (var i = 0; i < pairs.length; i++) {
                var kv = pairs[i].split("=");
                opts[unescape(kv[0])] = unescape(kv[1]);
            }
        }

        return opts;
    }

    public static function warnID(bid:String, leaderboard:Boolean):Void {
        bid = bid.toLowerCase();

        if( bid.length != 16 )
        {
            trace( "WARNING: " + (leaderboard?"board":"game") + " ID is not the appropriate length" );
            return ;
        }
        else if( bid == "1e113c7239048b3f" )
        {
            if( leaderboard )
                trace( "WARNING: Using testing board ID");
            else
                trace( "WARNING: Using testing board ID as game ID");
            return ;
        }
        else if( bid == "84993a1de4031cd8" )
        {
            if( leaderboard )
                trace( "WARNING: Using testing game ID as board ID");
            else
                trace( "WARNING: Using testing game ID");
            return ;
        }

        for( var i:Number = 0; i < bid.length; i++ )
        {
            switch( bid.charAt(i) )
            {
                case "0": case "1": case "2": case "3":
                case "4": case "5": case "6": case "7":
                case "8": case "9": case "a": case "b":
                case "c": case "d": case "e": case "f":
                    continue ;
                default:
                    trace( "WARNING: Board ID contains illegal characters: " + bid );
                    return ;
            }
        }
    }


    //
    //
    public static function addLinkEvent(url:String, burl:String, btn:MovieClip, onClick:Function):Void {
        var timeout:Number = 1500;
        var t0:Number = getTimer();
        var vars:Object = new Object();
        vars["mav"] = MochiServices.getVersion();
        vars["swfv"] = btn.getSWFVersion() || 6;
        vars["swfurl"] = btn._url;
        vars["fv"] = System.capabilities.version;
        vars["os"] = System.capabilities.os;
        vars["lang"] = System.capabilities.language;
        vars["scres"] = (System.capabilities.screenResolutionX + "x" + System.capabilities.screenResolutionY);

        var s:String = "?";
        var i:Number = 0;
        for (var x:String in vars) {
            if (i != 0) s = s + "&";
            i++;
            s = s + x + "=" + escape(vars[x]);
        }

        if (! (netupAttempted || _connected)) {
            var ping:MovieClip = btn.createEmptyMovieClip("ping", 777);
            var nettest:MovieClip = btn.createEmptyMovieClip("nettest", 778);

            MochiServices.netupAttempted = true;

            ping.loadMovie("http://x.mochiads.com/linkping.swf?t=" + getTimer());

            nettest.onEnterFrame = function () {
                if (ping._totalframes > 0 && (ping._totalframes == ping._framesloaded)) {
                    delete this.onEnterFrame;
                } else if ((getTimer() - t0) > timeout) {
                    delete this.onEnterFrame;
                    MochiServices.netup = false;
                }
            }
        }

        var clk:MovieClip = btn.createEmptyMovieClip("clk", 1001);
        clk._alpha = 0;
        clk.beginFill(0xFF0FF);
        clk.moveTo(0, 0);
        clk.lineTo(0, btn._height);
        clk.lineTo(btn._width, btn._height);
        clk.lineTo(btn._width, 0);
        clk.lineTo(0, 0);
        clk.endFill();

        clk.onRelease = function () {
            if (MochiServices.netup) {
                getURL(url + s, "_blank");
            } else {
                getURL(burl, "_blank");
            }

            if (onClick != undefined) {
                onClick();
            }
        }

    }

    //
    //
    public static function setContainer(clip:MovieClip) {
        // not needed for AS2. in AS3 this does the addChild of the clip where Services is loaded in the passed clip.
    }

    //
    //
    public static function stayOnTop(clip:MovieClip) {
        // not needed for AS2, as it can be done in loaded widget
    }

}
