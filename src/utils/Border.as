package utils
{
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import starling.display.DisplayObject;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Color;

public class Border
{

    private static var displayObjects:Dictionary = new Dictionary();

    public static function createBorder(rectangle:Rectangle, color:uint = Color.BLACK, thickness:Number = 1):Sprite {

        var container:Sprite = new Sprite();

        for (var i:int=0; i < 4; ++i){
            var quad:Quad = new Quad(thickness, thickness, color);
            quad.touchable = false;
            container.addChild(quad);
        }

        var topLine:Quad    = container.getChildAt(container.numChildren - 4) as Quad;
        var rightLine:Quad  = container.getChildAt(container.numChildren - 3) as Quad;
        var bottomLine:Quad = container.getChildAt(container.numChildren - 2) as Quad;
        var leftLine:Quad   = container.getChildAt(container.numChildren - 1) as Quad;

        topLine.width    = rectangle.width;         topLine.height    = thickness;
        bottomLine.width = rectangle.width;         bottomLine.height = thickness;
        leftLine.width   = thickness;     leftLine.height   = rectangle.height;
        rightLine.width  = thickness;     rightLine.height  = rectangle.height;
        rightLine.x  = rectangle.width  - thickness;
        bottomLine.y = rectangle.height - thickness;
        topLine.color = rightLine.color = bottomLine.color = leftLine.color = color;

        return container;

    }

    public static function addSelectionBorder(sprite:Sprite, color:uint = Color.BLACK, thickness:Number = 1):void {

        var container:Sprite = createBorder(new Rectangle(0, 0, sprite.width, sprite.height), color, thickness);
        displayObjects[sprite] = container;
        sprite.addChild(container);

        sprite.addEventListener(TouchEvent.TOUCH, onTouch);

    }

    private static function onTouch(e:TouchEvent):void {

        var dO:DisplayObject = e.currentTarget as DisplayObject;
        var hover:Touch = e.getTouch(dO, TouchPhase.HOVER);

        displayObjects[dO].visible = hover != null;

    }




}
}
