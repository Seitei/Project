package utils {
import flash.utils.Dictionary;

import starling.display.DisplayObject;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class TouchAndGestures {

    private static var _instance:TouchAndGestures;
    private var _callBacks:Dictionary;
    private var _draggableObjects:Dictionary;

    public function TouchAndGestures():void {
        _callBacks = new Dictionary();
        _draggableObjects = new Dictionary();
    }

    //////////////// CLICK ////////////////

    public function onClick(dO:Object, callback:Function):void {

        dO.addEventListener(TouchEvent.TOUCH, onClicked);
        _callBacks[dO] = callback;

    }

    public function removeOnClick(dO:Object):void {

        dO.removeEventListener(TouchEvent.TOUCH, onClicked);
        _callBacks[dO] = null;

    }

    private function onClicked(e:TouchEvent):void {

        var dO:DisplayObject = DisplayObject(e.currentTarget);
        var touch:Touch = e.getTouch(dO, TouchPhase.BEGAN);

        if(touch){
            _callBacks[dO](dO);
        }

    }

    //////////////// DRAG ////////////////

    public function setToDrag(dO:Object):void {

        dO.addEventListener(TouchEvent.TOUCH, onDrag);
        _draggableObjects[dO] = dO;

    }

    public function removeSetToDrag(dO:Object):void {
        dO.removeEventListener(TouchEvent.TOUCH, onDrag);
        _draggableObjects[dO] = null;
    }

    private function onDrag(e:TouchEvent):void {

        e.stopImmediatePropagation();

        var dO:DisplayObject = DisplayObject(e.currentTarget);
        var touch:Touch = e.getTouch(dO, TouchPhase.MOVED);

        if(touch){
            dO.x += touch.getMovement(dO.parent).x;
            dO.y += touch.getMovement(dO.parent).y;
        }

    }

























    public static function getInstance():TouchAndGestures {
        if(!_instance){
            _instance = new TouchAndGestures();
        }
        return _instance;
    }

}
}
