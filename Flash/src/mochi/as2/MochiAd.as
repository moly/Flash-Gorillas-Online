/*
    Mochi Ads ActionScript 2 code

    Flash movies should be published for Flash 7 or later.

    Copyright (C) 2006-2009 Mochi Media, Inc. All rights reserved.
*/

import mochi.as2.MochiServices;

class mochi.as2.MochiAd {
    static function getVersion():String {
        return MochiServices.getVersion();
    }

    static function showPreGameAd(options:Object):Void {
        /*
            This function will stop the clip, load the Mochi Ad in a
            centered position on the clip, and then resume the clip
            after a timeout or when this movie is loaded, whichever
            comes first.

            options:
                An object with keys and values to pass to the server.
                These options will be passed to MochiAd.load, but the
                following options are unique to showPreGameAd.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                no_bg disables the ad's background entirely when set to true
                (default: false)

                color is the color of the preloader bar
                as a number (default: 0xFF8A00)

                background is the inside color of the preloader
                bar as a number (default: 0xFFFFC9)

                outline is the outline color of the preloader
                bar as a number (default: 0xD58B3C)

                no_progress_bar disables the ad's preload/progress bar when set to true
                (default: false)

                skip disables the loading of a pre-game ad entirely but
                will still behave as a preloader for your game. Great for testing.
                (default: false)

                fadeout_time is the number of milliseconds to
                fade out the ad upon completion (default: 250).

                ad_started is the function to call when the ad
                has started
                (default: function ():Void { this.clip.stop() }).

                ad_finished is the function to call when the ad
                has finished
                (default: function ():Void { this.clip.play() }).

                ad_failed is called if an ad can not be displayed,
                this is usually due to the user having ad blocking
                software installed or issues with retrieving the ad
                over the network. If it is called, then it is called
                before ad_finished.
                (default: function ():void { }).

                ad_loaded is called just before an ad is displayed
                with the width and height of the ad. If it is called,
                it is called after ad_started.
                (default: function(width:Number, height:Number):void { }).

                ad_skipped is called if the ad was skipped, this is
                usually due to frequency capping, or developer initiated
                domain filtering.  If it is called, then it is called
                before ad_finished.
                (default: function():void { }).


                ad_progress is called with the progress of the ad.  The
                progress is the percent (represented from 0 to 100) of the
                ad show time or loading time for the host swf, whichever is more.
                (default: function(percent:Number):void { }).
        */
        var DEFAULTS = {
            clip: _root,
            ad_timeout: 3000,
            fadeout_time: 250,
            regpt: "o",
            method: "showPreloaderAd",
            color: 0xFF8A00,
            background: 0xFFFFC9,
            outline: 0xD58B3C,
            no_progress_bar: false,
            ad_started: function ():Void { this.clip.stop(); },
            ad_finished: function ():Void { this.clip.play(); },
            ad_failed: function ():Void { trace("[MochiAd] Couldn't load an ad, make sure that your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software"); },
            ad_loaded: function (width:Number, height:Number):Void { },
            ad_skipped: function ():Void { },
            ad_progress: function (percent:Number):Void { }
        };
        options = MochiAd._parseOptions(options, DEFAULTS);

        if ("c862232051e0a94e1c3609b3916ddb17".substr(0) == "dfeada81ac97cde83665f81c12da7def") {
            options.ad_started();
            options.ad_finished();
            return;
        }

        var clip = options.clip;
        var ad_msec = 11000;
        var ad_timeout = options.ad_timeout;
        if (options.skip) {
            ad_timeout = 0;
        }
        delete options.ad_timeout;
        var fadeout_time = options.fadeout_time;
        delete options.fadeout_time;

        if (!MochiAd.load(options)) {
            options.ad_failed();
            options.ad_finished();
            return;
        }

        options.ad_started();

        var mc = clip._mochiad;
        mc.onUnload = function () {
            options.ad_finished();
        };

        /* Center the clip */
        var wh = MochiAd._getRes(options);
        var w = wh[0];
        var h = wh[1];
        mc._x = w * 0.5;
        mc._y = h * 0.5;

        var chk = mc.createEmptyMovieClip("_mochiad_wait", 3);
        chk._x = w * -0.5;
        chk._y = h * -0.5;

        var bar = chk.createEmptyMovieClip("_mochiad_bar", 4);
        if (options.no_progress_bar) {
            bar._visible = false;
            delete options.no_progress_bar;
        } else {
            bar._x = 10;
            bar._y = h - 20;
        }

        var bar_color = options.color;
        delete options.color;
        var bar_background = options.background;
        delete options.background;
        var bar_outline = options.outline;
        delete options.outline;

        var backing = bar.createEmptyMovieClip("_outline", 1);
        backing.beginFill(bar_background);
        backing.moveTo(0, 0);
        backing.lineTo(w - 20, 0);
        backing.lineTo(w - 20, 10);
        backing.lineTo(0, 10);
        backing.lineTo(0, 0);
        backing.endFill();

        var inside = bar.createEmptyMovieClip("_inside", 2);
        inside.beginFill(bar_color);
        inside.moveTo(0, 0);
        inside.lineTo(w - 20, 0);
        inside.lineTo(w - 20, 10);
        inside.lineTo(0, 10);
        inside.lineTo(0, 0);
        inside.endFill();
        inside._xscale = 0;

        var outline = bar.createEmptyMovieClip("_outline", 3);
        outline.lineStyle(0, bar_outline, 100);
        outline.moveTo(0, 0);
        outline.lineTo(w - 20, 0);
        outline.lineTo(w - 20, 10);
        outline.lineTo(0, 10);
        outline.lineTo(0, 0);

        chk.ad_msec = ad_msec;
        chk.ad_timeout = ad_timeout;
        chk.started = getTimer();
        chk.showing = false;
        chk.last_pcnt = 0.0;
        chk.fadeout_time = fadeout_time;
        chk.fadeFunction = function () {
            var p = 100 * (1 -
                ((getTimer() - this.fadeout_start) / this.fadeout_time));
            if (p > 0) {
                this._parent._alpha = p;
            } else {
                var _clip = this._parent._parent;
                MochiAd.unload(_clip);
                delete this.onEnterFrame;
            }
        };

        /* Container will call so we can start sending host loading progress
           over specified LC name.
         */
        var sendHostProgress:Boolean = false;
        mc.lc.sendHostLoadProgress = function (lc_name:String):Void {
            sendHostProgress = true;
        }

        mc.lc.adLoaded = options.ad_loaded;
        mc.lc.adSkipped = options.ad_skipped;
        mc.lc.adjustProgress = function (msec:Number):Void {
            var _chk = this.mc._mochiad_wait;
            _chk.server_control = true;
            _chk.started = getTimer();
            _chk.ad_msec = msec;
        };
        mc.lc.rpc = function (callbackID:Number, arg:Object):Void {
            MochiAd.rpc(clip, callbackID, arg);
        };
        // Only used for container RPC method call testing
        mc.rpcTestFn = function(s:String):Object {
            trace('[MOCHIAD rpcTestFn] ' + s);
            return s;
        }

        chk.onEnterFrame = function ():Void {
            var _clip = this._parent._parent;
            var ad_clip = this._parent._mochiad_ctr;
            var elapsed = getTimer() - this.started;
            var finished = false;
            var clip_total = _clip.getBytesTotal();
            var clip_loaded = _clip.getBytesLoaded();
            var clip_pcnt = (100.0 * clip_loaded) / clip_total;
            var ad_pcnt = (100.0 * elapsed) / chk.ad_msec;
            var _inside = this._mochiad_bar._inside;
            var pcnt = Math.min(100.0, Math.min((clip_pcnt || 0.0), ad_pcnt));
            pcnt = Math.max(this.last_pcnt, pcnt);
            this.last_pcnt = pcnt;
            _inside._xscale = pcnt;

            options.ad_progress(pcnt);

            /* Send to our targetting SWF percent of host loaded.
               This is so we can notify the AD SWF when we're loaded.
            */
            if (sendHostProgress) {
                MochiAd.containerNotify(clip, {id: 'hostLoadPcnt', pcnt: clip_pcnt}, clip._mochiad._containerLCName);
                if (clip_pcnt == 100)
                    sendHostProgress = false;
            }

            if (!chk.showing) {
                var total = ad_clip.getBytesTotal();
                if (total > 0 || typeof(total) == "undefined") {
                    chk.showing = true;
                    chk.started = getTimer();
                } else if (elapsed > chk.ad_timeout && clip_pcnt == 100) {
                    options.ad_failed();
                    finished = true;
                }
            }
            if (elapsed > chk.ad_msec) {
                finished = true;
            }
            if (clip_total > 0 && clip_loaded >= clip_total && finished) {
                if (this.server_control) {
                    delete this.onEnterFrame;
                } else {
                    this.fadeout_start = getTimer();
                    this.onEnterFrame = chk.fadeFunction;
                }
            }
        };
    }

    static function showClickAwayAd(options:Object):Void {
        /*
            This function will load a Mochi Ad in the upper left position position on the clip.
            This ad will remain there until unload() is called.

            options:
                An object with keys and values to pass to the server.
                These options will be passed to MochiAd.load, but the
                following options are unique to showClickAwayAd.

                clip is a MovieClip reference to place the ad in.

                ad_started is the function to call when the ad
                has started (may not get called if network down)
                (default: function ():void { this.clip.stop() }).

                ad_finished is the function to call when the ad
                has finished or could not load
                (default: function ():void { this.clip.play() }).

                ad_failed is called if an ad can not be displayed,
                this is usually due to the user having ad blocking
                software installed or issues with retrieving the ad
                over the network. If it is called, then it is called
                before ad_finished.
                (default: function ():void { }).

                ad_loaded is called just before an ad is displayed
                with the width and height of the ad. If it is called,
                it is called after ad_started.
                (default: function(width:Number, height:Number):void { }).

                ad_skipped is called if the ad was skipped, this is
                usually due to frequency capping, or developer initiated
                domain filtering.  If it is called, then it is called
                before ad_finished.
                (default: function():void { })
        */
        var DEFAULTS = {
            clip: _root,
            ad_timeout: 2000,
            fadeout_time: 250,
            regpt: "o",
            method: "showClickAwayAd",
            res: "300x250",
            no_bg: true,
            ad_started: function ():Void { },
            ad_finished: function ():Void { },
            ad_loaded: function (width:Number, height:Number):Void { },
            ad_failed: function ():Void { trace("[MochiAd] Couldn't load an ad, make sure that your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software"); },
            ad_skipped: function ():Void { }
        };
        options = MochiAd._parseOptions(options, DEFAULTS);

        var clip = options.clip;
        var ad_timeout = options.ad_timeout;
        delete options.ad_timeout;

        /* Load targeting under clip._mochiad */
        if (!MochiAd.load(options)) {
            options.ad_failed();
            options.ad_finished();
            return;
        }

        options.ad_started();

        var mc = clip._mochiad;
        mc.onUnload = function () {
            options.ad_finished();
        };

        /* Center the clip */
        var wh = MochiAd._getRes(options);
        var w = wh[0];
        var h = wh[1];
        mc._x = w * 0.5;
        mc._y = h * 0.5;

        var chk = mc.createEmptyMovieClip("_mochiad_wait", 3);
        chk.ad_timeout = ad_timeout;
        chk.started = getTimer();
        chk.showing = false;

        mc.lc.adLoaded = options.ad_loaded;
        mc.lc.adSkipped = options.ad_skipped;
        mc.lc.rpc = function (callbackID:Number, arg:Object):Void {
            MochiAd.rpc(clip, callbackID, arg);
        };
        // Only used for container RPC method call testing
        mc.rpcTestFn = function(s:String):Object {
            trace('[MOCHIAD rpcTestFn] ' + s);
            return s;
        }

        var sendHostProgress:Boolean = false;

        chk.onEnterFrame = function ():Void {
            var ad_clip = this._parent._mochiad_ctr;
            var elapsed = getTimer() - this.started;
            var finished = false;

            if (!chk.showing) {
                var total = ad_clip.getBytesTotal();
                if (total > 0 || typeof(total) == "undefined") {
                    finished = true;
                    chk.showing = true;
                    chk.started = getTimer();
                } else if (elapsed > chk.ad_timeout) {
                    options.ad_failed();
                    finished = true;
                }
            }

            if (finished) {
                delete this.onEnterFrame;
            }
        };
    }

    static function showInterLevelAd(options:Object):Void {
        /*
            This function will stop the clip, load the Mochi Ad in a
            centered position on the clip, and then resume the clip
            after a timeout.

            options:
                An object with keys and values to pass to the server.
                These options will be passed to MochiAd.load, but the
                following options are unique to showInterLevelAd.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                no_bg disables the ad's background entirely when set to true
                (default: false)

                fadeout_time is the number of milliseconds to
                fade out the ad upon completion (default: 250).

                ad_started is the function to call when the ad
                has started (may not get called if network down)
                (default: function ():Void { this.clip.stop() }).

                ad_finished is the function to call when the ad
                has finished or could not load
                (default: function ():Void { this.clip.play() }).

                ad_failed is called if an ad can not be displayed,
                this is usually due to the user having ad blocking
                software installed or issues with retrieving the ad
                over the network. If it is called, then it is called
                before ad_finished.
                (default: function ():void { }).

                ad_loaded is called just before an ad is displayed
                with the width and height of the ad. If it is called,
                it is called after ad_started.
                (default: function(width:Number, height:Number):void { }).

                ad_skipped is called if the ad was skipped, this is
                usually due to frequency capping, or developer initiated
                domain filtering.  If it is called, then it is called
                before ad_finished.
                (default: function():void { })
        */
        var DEFAULTS = {
            clip: _root,
            ad_timeout: 2000,
            fadeout_time: 250,
            regpt: "o",
            method: "showTimedAd",
            ad_started: function ():Void { this.clip.stop(); },
            ad_finished: function ():Void { this.clip.play(); },
            ad_failed: function ():Void { trace("[MochiAd] Couldn't load an ad, make sure that your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software"); },
            ad_loaded: function (width:Number, height:Number):Void { },
            ad_skipped: function ():Void { }
        };
        options = MochiAd._parseOptions(options, DEFAULTS);

        var clip = options.clip;
        var ad_msec = 11000;
        var ad_timeout = options.ad_timeout;
        delete options.ad_timeout;
        var fadeout_time = options.fadeout_time;
        delete options.fadeout_time;

        if (!MochiAd.load(options)) {
            options.ad_failed();
            options.ad_finished();
            return;
        }

        options.ad_started();

        var mc = clip._mochiad;
        mc.onUnload = function () {
            options.ad_finished();
        };

        /* Center the clip */
        var wh = MochiAd._getRes(options);
        var w = wh[0];
        var h = wh[1];
        mc._x = w * 0.5;
        mc._y = h * 0.5;

        var chk = mc.createEmptyMovieClip("_mochiad_wait", 3);
        chk.ad_msec = ad_msec;
        chk.ad_timeout = ad_timeout;
        chk.started = getTimer();
        chk.showing = false;
        chk.fadeout_time = fadeout_time;
        chk.fadeFunction = function () {
            var p = 100 * (1 -
                ((getTimer() - this.fadeout_start) / this.fadeout_time));
            if (p > 0) {
                this._parent._alpha = p;
            } else {
                var _clip = this._parent._parent;
                MochiAd.unload(_clip);
                delete this.onEnterFrame;
            }
        };

        mc.lc.adLoaded = options.ad_loaded;
        mc.lc.adSkipped = options.ad_skipped;
        mc.lc.adjustProgress = function (msec:Number):Void {
            var _chk = this.mc._mochiad_wait;
            _chk.server_control = true;
            _chk.started = getTimer();
            _chk.ad_msec = msec - 250;
        };
        mc.lc.rpc = function (callbackID:Number, arg:Object):Void {
            MochiAd.rpc(clip, callbackID, arg);
        };
        // Only used for container RPC method call testing
        mc.rpcTestFn = function(s:String):Object {
            trace('[MOCHIAD rpcTestFn] ' + s);
            return s;
        }

        chk.onEnterFrame = function ():Void {
            var ad_clip = this._parent._mochiad_ctr;
            var elapsed = getTimer() - this.started;
            var finished = false;
            if (!chk.showing) {
                var total = ad_clip.getBytesTotal();
                if (total > 0 || typeof(total) == "undefined") {
                    chk.showing = true;
                    chk.started = getTimer();
                } else if (elapsed > chk.ad_timeout) {
                    options.ad_failed();
                    finished = true;
                }
            }
            if (elapsed > chk.ad_msec) {
                finished = true;
            }
            if (finished) {
                if (this.server_control) {
                    delete this.onEnterFrame;
                } else {
                    this.fadeout_start = getTimer();
                    this.onEnterFrame = this.fadeFunction;
                }
            }
        };

    }

   static function showPreloaderAd(options:Object):Void {
        /* Compatibility stub for MochiAd 1.5 terminology */
        trace("[MochiAd] DEPRECATED: showPreloaderAd was renamed to showPreGameAd in 2.0");
        MochiAd.showPreGameAd(options);
    }

    static function showTimedAd(options:Object):Void {
         /* Compatibility stub for MochiAd 1.5 terminology */
         trace("[MochiAd] DEPRECATED: showTimedAd was renamed to showInterLevelAd in 2.0");
         MochiAd.showInterLevelAd(options);
    }

    static function _allowDomains(server:String):String {
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

    static function load(options:Object):Object {
        /*
            Load a MochiAd into the given MovieClip

            options:
                An object with keys and values to pass to the server.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                id should be the unique identifier for this Mochi Ad.

                server is the base URL to the Mochi Ad server.

                res is the resolution of the container clip or movie
                as a string, e.g. "500x500"
        */
        var DEFAULTS = {
            clip: _root,
            server: "http://x.mochiads.com/srv/1/",
            method: "load",
            depth: 10333,
            id: "_UNKNOWN_"
        };
        options = MochiAd._parseOptions(options, DEFAULTS);
        options.swfv = options.clip.getSWFVersion() || 6;
        options.mav = MochiAd.getVersion();

        var clip = options.clip;

        if (!MochiAd._isNetworkAvailable()) {
            return null;
        }

        if (clip._mochiad_loaded) {
            return null;
        }

        var depth = options.depth;
        delete options.depth;
        var mc = clip.createEmptyMovieClip("_mochiad", depth);

        var wh = MochiAd._getRes(options);
        options.res = wh[0] + "x" + wh[1];

        options.server += options.id;
        delete options.id;

        clip._mochiad_loaded = true;

        if (clip._url.indexOf("http") != 0) {
            trace("[MochiAd] NOTE: Security Sandbox Violation errors below are normal");
        }

        var lv = mc.createEmptyMovieClip("_mochiad_ctr", 1);
        for (var k:String in options) {
            lv[k] = options[k];
        }

        var server = lv.server;
        delete lv.server;
        var hostname = MochiAd._allowDomains(server);

        mc.onEnterFrame = function ():Void {
            if (this._mochiad_ctr._url != this._url) {
                this.onEnterFrame = function () {
                    if (!this._mochiad_ctr) {
                        delete this.onEnterFrame;
                        MochiAd.unload(this._parent);
                    };
                };
            }
        };


/* Set up LocalConnection recieve between here and targetting swf */
/* Remove LocalConnection and allow ad container to cross script instead */
        var lc = new Object();
        //var lc = new LocalConnection();
        var name = [
            "", Math.floor((new Date()).getTime()), random(999999)
        ].join("_");
        lc.mc = mc;
        lc.name = name;
        lc.hostname = hostname;
        lc.allowDomain = function (d:String):Boolean {
            return true;
        };
        lc.allowInsecureDomain = lc.allowDomain;
        lc.connect(name);
        mc.lc = lc;
        
        /* Container will call so we know Container LC */
        mc.lc.regContLC = function (lc_name:String):Void {
            mc._containerLCName = lc_name;
        }
        
        /* register our LocalConnection name with targetting swf */
        lv.lc = name;

        lv.st = getTimer();
        /* load targetting swf */
        if (!options.skip) {
            lv.loadMovie(server + '.swf', "POST");
        }

        return mc;
    }

    static function unload(clip:Object):Boolean {
        /*
            Unload a Mochi Ad from the given MovieClip

                clip:
                    a MovieClip reference (e.g. _root.myBanner)
        */
        if (typeof(clip) == "undefined") {
            clip = _root;
        }
        if (clip.clip && clip.clip._mochiad) {
            clip = clip.clip;
        }
        if (!clip._mochiad) {
            return false;
        }
        containerNotify(clip, {id: 'unload'}, clip._mochiad._containerLCName);
        clip._mochiad.removeMovieClip();
        delete clip._mochiad_loaded;
        delete clip._mochiad;
        return true;
    }

    static function _isNetworkAvailable():Boolean {
        if (System.security) {
            var o:Object = System.security;
            if (o.sandboxType == "localWithFile") {
                return false;
            }
        }
        return true;
    }

    static function _getRes(options:Object):Object {
        var b = options.clip.getBounds();
        var w = 0;
        var h = 0;
        if (typeof(options.res) != "undefined") {
            var xy = options.res.split("x");
            w = parseFloat(xy[0]);
            h = parseFloat(xy[1]);
        } else {
            w = b.xMax - b.xMin;
            h = b.yMax - b.yMin;
        }
        if (w == 0 || h == 0) {
            w = Stage.width;
            h = Stage.height;
        }
        return [w, h];
    }

    static function _parseOptions(options:Object, defaults:Object):Object {
        var optcopy = {};
        for (var k:String in defaults) {
            optcopy[k] = defaults[k];
        }
        if (options) {
            for (var k:String in options) {
                optcopy[k] = options[k];
            }
        }
        if (_root.mochiad_options) {
            var pairs = _root.mochiad_options.split("&");
            for (var i = 0; i < pairs.length; i++) {
                var kv = pairs[i].split("=");
                optcopy[unescape(kv[0])] = unescape(kv[1]);
            }
        }
        if (optcopy.id == 'test') {
            trace("[MochiAd] WARNING: Using the MochiAds test identifier, make sure to use the code from your dashboard, not this example!");
        }
        return optcopy;
    }

    static function rpc(clip:Object, callbackID:Number, arg:Object):Void {
        switch (arg.id) {
            case 'setValue':
                MochiAd.setValue(clip, arg.objectName, arg.value);
                break;
            case 'getValue':
                var val:Object = MochiAd.getValue(clip, arg.objectName);
                MochiAd.containerRpcResult(clip, callbackID, val, clip._mochiad._containerLCName);
                break;
            case 'runMethod':
                var ret:Object = MochiAd.runMethod(clip, arg.method, arg.args);
                MochiAd.containerRpcResult(clip, callbackID, ret, clip._mochiad._containerLCName);
                break;
            default:
                trace('[mochiads rpc] unknown rpc id: ' + arg.id);
        }
    }

    static function setValue(base:Object, objectName:String, value:Object):Void {
        var nameArray:Array = objectName.split(".");
        var i:Number;

        // drill down through the base object until we get the parent class of object to modify
        for (i = 0; i < nameArray.length - 1; i++) {
            if (base[nameArray[i]] == undefined || base[nameArray[i]] == null) {
                return;
            }
            base = base[nameArray[i]];
        }

        base[nameArray[i]] = value;
    }

    static function getValue(base:Object, objectName:String):Object {
        var nameArray:Array = objectName.split(".");
        var i:Number;

        // drill down through the base object until we get the parent class of object to modify
        for (i = 0; i < nameArray.length - 1; i++) {
            if (base[nameArray[i]] == undefined || base[nameArray[i]] == null) {
                return undefined;
            }
            base = base[nameArray[i]];
        }

        // return the object requested
        return base[nameArray[i]];
    }

    static function runMethod(base:Object, methodName:String, argsArray:Array):Object {
        var nameArray:Array = methodName.split(".");
        var i:Number;

        // drill down through the base object until we get the parent class of method to run
        for (i = 0; i < nameArray.length - 1; i++) {
            if (base[nameArray[i]] == undefined || base[nameArray[i]] == null) {
                return undefined;
            }
            base = base[nameArray[i]];
        }

        // run method
        if (typeof(base[nameArray[i]]) == 'function') {
            return base[nameArray[i]].apply(base, argsArray);
        } else {
            return undefined;
        }
    }

    static function containerNotify(clip:Object, args:Object, lcName:String) {
        var container:Object = clip._mochiad._mochiad_ctr.ad.app;

        if (container.notify) {
            // cross script into container
            container.notify(args);
        } else {
            // use Localconnection
            (new LocalConnection()).send(lcName, 'notify', args);
        }
    }

    static function containerRpcResult(clip:Object, callbackID:Object, val:Object, lcName:String) {
        var container:Object = clip._mochiad._mochiad_ctr.ad.app;

        if (container.rpcResult) {
            // cross script into container
            container.rpcResult(callbackID, val);
        } else {
            // use Localconnection
            (new LocalConnection()).send(lcName, 'rpcResult', callbackID, val);
        }
    }

}
