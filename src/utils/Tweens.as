package utils {
import flash.utils.Dictionary;

import starling.animation.Juggler;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;

public class Tweens {

    private static var _instance:Tweens;
    private var _juggler:Juggler;
    private var _tweens:Dictionary;

    public function Tweens():void {
        _tweens = new Dictionary();
        _juggler = new Juggler();
        Starling.juggler.add(_juggler);
    }

    public function tweenTo(object:Object, params:Object, onCompleteData:Object = null, onCompleteCallback:Function = null):void {

        var tween:Tween = new Tween(object, params.time,  params.transitionType);
        tween.animate(params.property, params.endValue);
        _juggler.add(tween);

        if(_tweens[object] == null){
            _tweens[object] = new Dictionary();
        }

        _tweens[object][params.property] = tween;

        if(onCompleteData){

            if(!onCompleteCallback){
                tween.onComplete = onComplete;
                onCompleteData.tween = tween;
                tween.onCompleteArgs = [onCompleteData];
            }
            else {
                tween.onComplete = onCompleteCallback;
                tween.onCompleteArgs = [object];
            }
        }
    }

    public function stopTween(object:DisplayObject, property:String):void {

        _juggler.remove(_tweens[object][property]);
        delete _tweens[object][property];

    }


    private function onComplete(args:Object):void {
        args.tween.target[args.property] = args.endValue;
    }






    public static function getInstance():Tweens {
        if(!_instance){
            _instance = new Tweens();
        }
        return _instance;
    }



}










}